import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrijourney/utils/constants.dart';
import 'package:nutrijourney/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:nutrijourney/services/recipe_services.dart';

import '../../providers/user_provider.dart';
import '../../widgets/text_field_input.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddRecipeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController prepareTimeController = TextEditingController();
  Uint8List? _file;
  bool isLoading = false; //used to show the loading indicator

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    caloriesController.dispose();
    prepareTimeController.dispose();
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    String uid = userProvider.getUser.uid;

    //function to show the popup for user to select upload image method

    _selectImage(BuildContext parentContext) async {
      return showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Create A Recipe'),
            children: <Widget>[
              SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Take a photo'),
                  onPressed: () async {
                    Navigator.pop(context);
                    Uint8List file = await pickImage(ImageSource.camera);
                    setState(() {
                      _file = file;
                    });
                  }),
              SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Choose from Gallery'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.gallery);
                    setState(() {
                      _file = file;
                    });
                  }),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }

    //function to save recipe nto DB after getting all data
    void addRecipe() async {
      // first, set the isLoading to true. So that the UI will show loading
      setState(() {
        isLoading = true;
      });

      //get data from the text controller
      String title = titleController.text;
      String description = prepareTimeController.text;
      int calories = int.parse(caloriesController.text);
      String prepareTime = (prepareTimeController.text);
      String recipeId = const Uuid().v1();

      try {
        String res = await RecipeServices().createRecipe(
            title, description, calories, prepareTime, _file!, uid);
        if (res == "success") {
          setState(() {
            isLoading = false;
          });
          showSnackBar(
            context,
            'Added Recipe!',
          );

          clearImage();
          Navigator.pop(context);
        } else {
          showSnackBar(context, res);
        }
      } catch (err) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          err.toString(),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'Create a Post',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: (Colors.transparent),
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                addRecipe();
              }
            },
            child: const Text(
              "Create",
              style: TextStyle(
                  color: kPrimaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? const LinearProgressIndicator()
            : Form(
                key: formKey,
                child: Column(children: [
                  SizedBox(
                    width: 200, // specify the desired width
                    height: 200, // specify the desired height
                    child: _file == null
                        ? Image.network(
                            "https://docs.flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png")
                        : Image.memory(_file!),
                  ),
                  TextButton(
                    onPressed: () => _selectImage(context),
                    child: Text("Add Image"),
                  ),
                  TextFieldInput(
                      hintText: 'Enter Recipe Title',
                      textInputType: TextInputType.text,
                      textEditingController: titleController),
                  TextFieldInput(
                      hintText: 'Description',
                      textInputType: TextInputType.text,
                      textEditingController: descriptionController),
                  TextFieldInput(
                      hintText: 'Calories',
                      textInputType: TextInputType.number,
                      textEditingController: caloriesController
                      ),

                  // TextFormField(
                  //   inputFormatters: [
                  //     FilteringTextInputFormatter.allow(
                  //       RegExp(r"[0-9]"),
                  //     )
                  //   ],
                  //   validator: (val) {
                  //     final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
                  //     var isValidNumber = phoneRegExp.hasMatch(val!);

                  //     if (isValidNumber == false) {
                  //       return 'please Enter a valid number';
                  //     }
                  //   },
                  //   decoration: InputDecoration(
                  //     hintText: "Calories (exampple: 500)",
                  //     border: OutlineInputBorder(
                  //       borderSide: Divider.createBorderSide(context),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderSide: Divider.createBorderSide(context),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderSide: Divider.createBorderSide(context),
                  //     ),
                  //     filled: true,
                  //     contentPadding: const EdgeInsets.all(8),
                  //   ),
                  //   controller: caloriesController,
                  // ),
                  
                  TextFieldInput(
                      hintText: 'Prepare Time',
                      textInputType: TextInputType.text,
                      textEditingController: prepareTimeController),
                ]),
              ),
      ),
    );
  }
}

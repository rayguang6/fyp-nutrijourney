import 'package:flutter/material.dart';
import 'package:nutrijourney/services/post_services.dart';
import 'package:nutrijourney/services/recipe_services.dart';
import 'package:nutrijourney/utils/constants.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/text_field_input.dart';

class AddPostScreen extends StatefulWidget {
  AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  void addPost() {
    String title = _titleController.text;
    String description = _descriptionController.text;

    PostServices().createPost(title, description);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
        
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
              if (_formKey.currentState!.validate()) {
                addPost();
              }
            },
            child: const Text(
              "Post",
              style: TextStyle(
                  color: kPrimaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(children: [
          TextFieldInput(
              hintText: 'Enter your Title',
              textInputType: TextInputType.text,
              textEditingController: _titleController),
          TextFieldInput(
              hintText: 'Enter your Content',
              textInputType: TextInputType.text,
              textEditingController: _descriptionController),
        ]),
      ),
    );
  }
}

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrijourney/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../models/Recipe.dart';

class RecipeServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> createRecipe(
    String title,
    String description,
    int calories,
    String prepareTime,
    Uint8List image,
    String uid,
  ) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management

    String res = "Some error occurred"; // set res as error first

    try {
      String imageLink =
          "https://docs.flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png";
      imageLink = await uploadPostImageToStorage('recipes', image);

      String recipeId = const Uuid().v1(); // creates unique id based on time
      Recipe recipe = Recipe(
          recipeId: recipeId,
          title: title,
          description: description,
          calories: calories,
          prepareTime: prepareTime,
          image: imageLink,
          createdBy: uid);
      firestore.collection('recipes').doc(recipeId).set(recipe.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

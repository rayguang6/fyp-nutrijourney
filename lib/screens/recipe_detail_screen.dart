import 'package:flutter/material.dart';
import 'package:nutrijourney/utils/constants.dart';
import 'package:nutrijourney/utils/utils.dart';

class RecipeDetailScreen extends StatelessWidget {
  final recipe;
  RecipeDetailScreen({super.key, this.recipe});


  @override
  Widget build(BuildContext context) {

    // Implement the UI for the recipe detail screen using the provided recipe data
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title'].toString()),
        backgroundColor: kPrimaryGreen,
      ),
      body: Column(children: [
        Image.network(recipe['image'].toString()),
        const Text('Recipe Details'),
        Text(recipe['description'].toString()),
      ]),
    );
  }
}

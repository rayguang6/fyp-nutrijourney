import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrijourney/screens/helperscreen/add_recipe_screen.dart';
import 'package:nutrijourney/widgets/recipe_card.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  void createRecipe() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRecipeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: createRecipe,
        icon: const Icon(Icons.add),
      ),
      body: StreamBuilder(
          stream: firebaseFirestore.collection('recipes').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => RecipeCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          }),
    );
  }
}

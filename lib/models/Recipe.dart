import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String recipeId;
  final String title;
  final String description;
  final int calories;
  final String prepareTime;
  final String image;
  final String createdBy;
  // final Map<String, int> nutrition;

  const Recipe({
    required this.recipeId,
    required this.title,
    required this.description,
    required this.calories,
    required this.prepareTime,
    required this.image,
    required this.createdBy,
  });

  static Recipe fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Recipe(
      recipeId: snapshot["recipeId"],
      title: snapshot["title"],
      description: snapshot["description"],
      calories: snapshot["calories"],
      prepareTime: snapshot["prepareTime"],
      image: snapshot["image"],
      createdBy: snapshot["createdBy"],
    );
  }

  Map<String, dynamic> toJson() => {
        "recipeId": recipeId,
        "title": title,
        "description": description,
        "calories": calories,
        "prepareTime": prepareTime,
        "image": image,
        "createdBy": createdBy,
      };
}

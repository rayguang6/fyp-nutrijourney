import 'package:flutter/material.dart';
import 'package:nutrijourney/screens/recipe_detail_screen.dart';
import 'package:nutrijourney/utils/constants.dart';
import 'package:nutrijourney/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:nutrijourney/models/User.dart' as model;

import '../providers/user_provider.dart';

class RecipeCard extends StatefulWidget {
  final snap;
  const RecipeCard({super.key, required this.snap});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {


  void openRecipeDetail(){
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RecipeDetailScreen(recipe: widget.snap),
    ),
  );
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(children: [
        InkWell(
          onTap: openRecipeDetail,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  child: Image.network(
                    widget.snap['image'].toString(),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${widget.snap['recipeId'].toString()}'),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('title: ${widget.snap['title'].toString()}'),
                      Text('Desc: ${widget.snap['description'].toString()}'),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('Cal: ${widget.snap['calories'].toString()}'),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('prepare time: ${widget.snap['prepareTime']}'),
                      InkWell(
                        onTap: () {
                          showSnackBar(context,
                              'Clicked: ${widget.snap['title'].toString()}');
                        },
                        child: Container(
                          width: 150,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                            color: kPrimaryGreen,
                          ),
                          child: const Text('Add To Planner',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

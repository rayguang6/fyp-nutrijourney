import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrijourney/providers/user_provider.dart';
import 'package:nutrijourney/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/Post.dart';
import '../utils/global_variables.dart';

class PostServices {
  //function to create post into database
  void createPost(title, description) async {
    // String photoUrl =
    //     await StorageMethods().uploadImageToStorage('posts', file, true);

    String postId = const Uuid().v1();

    // String userId =

    Post post = Post(
      title: title,
      description: description,
      uid: sharedPreferences!.getString("uid")!,
      username: sharedPreferences!.getString("username")!,
      likes: [],
      datePublished: DateTime.now(),
      postId: postId,
      postUrl:
          'https://img.freepik.com/free-vector/gradient-ui-ux-landing-page-template_23-2149053801.jpg?w=2000',
      profImage:
          'https://img.freepik.com/free-vector/gradient-ui-ux-landing-page-template_23-2149053801.jpg?w=2000',
    );

    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      _firestore.collection('posts').doc(postId).set(post.toJson());
    } catch (e) {
      // showSnackBar(context, e.toString());
      print(e.toString());
    }
  }
}

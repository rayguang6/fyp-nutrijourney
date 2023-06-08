import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/User.dart' as model;
import '../utils/global_variables.dart';
import '../utils/utils.dart';

class AuthMethods {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; //instantiate firestore
  final FirebaseAuth _auth = FirebaseAuth.instance; //instantiate firebase auth

  // get user details from firebase
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // Signing Up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "ERROR Happends when Signing Up!";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty
          //|| bio.isNotEmpty
          // || file != null
          ) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl;
        photoUrl = "https://i.stack.imgur.com/l60Hf.png";
        photoUrl = await uploadImageToStorage('profilePics', file);

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences!.setString("uid", cred.user!.uid);
        await sharedPreferences!.setString("email", email);
        await sharedPreferences!.setString("username", username);
        await sharedPreferences!.setString("photoUrl", photoUrl);

        res = "success";

      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // log in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Error happends when login";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password

        User? currentUser;
        await _auth
            .signInWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then((auth) => currentUser = auth.user!)
            .catchError((onError) {
          print(onError);
        });

        if (currentUser != null) {
          readDataAndSetDataLocally(currentUser!);
        }
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      //if snapshot exists, store data into sharedPreferences
      if (snapshot.exists) {
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!.setString("email", snapshot.data()!["email"]);
        await sharedPreferences!.setString("username", snapshot.data()!["username"]);
        await sharedPreferences!.setString("photoUrl", snapshot.data()!["photoUrl"]);
      }
    });
  }
}

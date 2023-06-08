import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

// for displaying snackbars (popup)
showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

// adding image to firebase storage
Future<String> uploadImageToStorage(String childName, Uint8List file) async {
  // creating location to our firebase storage

  Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

  // putting in uint8list format -> Upload task like a future but not future
  UploadTask uploadTask = ref.putData(file);

  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

// MY Upload Image Post
  Future<String> uploadPostImageToStorage(String childName, Uint8List file) async {
    // creating location to our firebase storage
    
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
   
      String id = const Uuid().v1();
      ref = ref.child(id);

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(
      file
    );

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }




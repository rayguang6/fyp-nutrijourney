import 'package:flutter/material.dart';
import 'package:nutrijourney/screens/helperscreen/add_post.dart';

import 'package:nutrijourney/screens/login_screen.dart';
import 'package:nutrijourney/services/auth_methods.dart';
import 'package:nutrijourney/utils/constants.dart';
import 'package:nutrijourney/utils/global_variables.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        
        child: Column(
          children: [
            Container(
              child: Image.network(sharedPreferences!.getString("photoUrl")!,width: 200, height: 200, fit: BoxFit.cover,),
            ),
            Container(child: Text(sharedPreferences!.getString("username")!),),
            InkWell(
              child: Container(
                  decoration: const BoxDecoration(
                    color: kPrimaryGreen,
                  ),
                  padding: EdgeInsets.all(10),
                  child: const Text('Sign Out')),
              onTap: () {
                AuthMethods().signOut().then((value) {
                  // Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (c) => const LoginScreen()));
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

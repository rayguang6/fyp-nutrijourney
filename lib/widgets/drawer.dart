
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrijourney/screens/profile_screen.dart';

import '../screens/login_screen.dart';
import '../services/auth_methods.dart';
import '../utils/global_variables.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Drawer(
      
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => ProfileScreen(
                          uid: FirebaseAuth.instance.currentUser!.uid,
                        ),
                      ),
                    );
                  },
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(80)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        height: 160,
                        width: 160,
                        child: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          backgroundImage: NetworkImage(
                              sharedPreferences!.getString("photoUrl")!),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  sharedPreferences!.getString("username")!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 24),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //body drawer
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Dashboard",
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Profile",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => ProfileScreen(
                          uid: FirebaseAuth.instance.currentUser!.uid,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Settings",
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    AuthMethods().signOut().then((value) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const LoginScreen()));
                    });
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

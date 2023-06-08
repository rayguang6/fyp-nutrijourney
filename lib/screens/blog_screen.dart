import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("blogs").snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final blogs = snapshot.data!.docs;
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) {
                  final blog = blogs[index];

                  return Column(
                    children: [
                      Row(
                        children: [
                          const Text("TITLE=>   "),
                          Text(blog['title']),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Content=>   "),
                          Text(blog['content']),
                        ],
                      ),

                    ],
                    
                  );
                });
          }),
    );
  }
}

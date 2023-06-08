import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final String title;
  final String content;
  final String userId;

  const Blog(
      {required this.title, required this.content, required this.userId});

  //from firebase to Dart model
  static Blog fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Blog(
      title: snapshot['title'],
      content: snapshot['content'],
      userId: snapshot['userId'],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "userId": userId,
      };
}

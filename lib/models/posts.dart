import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String description;
  final String uid;
  final String userName;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  const Posts(
      {required this.description,
      required this.datePublished,
      required this.likes,
      required this.postUrl,
      required this.postId,
      required this.profImage,
      required this.uid,
      required this.userName});

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Posts(
        description: snapshot["description"],
        datePublished: snapshot["datePublished"],
        likes: snapshot["likes"],
        postUrl: snapshot["postUrl"],
        postId: snapshot["postId"],
        profImage: snapshot["profImage"],
        uid: snapshot["uid"],
        userName: snapshot["userName"]);
  }

   Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "likes": likes,
        "username": userName,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage
      };
}

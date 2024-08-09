import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String userName;
  final String uid;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  const User(
      {required this.bio,
      required this.email,
      required this.followers,
      required this.following,
      required this.photoUrl,
      required this.uid,
      required this.userName});

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "uid": uid,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
        "photoUrl":photoUrl
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        bio: snapshot['bio'],
        email: snapshot['email'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        photoUrl: snapshot['photoUrl'],
        uid: snapshot['uid'],
        userName: snapshot['userName']);
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta/screens/add_post_screen.dart';
import 'package:insta/screens/feed_Screeen.dart';
import 'package:insta/screens/profile_screen.dart';
import 'package:insta/screens/search_screen.dart';

const webScreen = 600;  

List<Widget> homeScreenItems = [
  FeedScreeen(),
  SearchScreen(),
  AddPostScreen(),
  Text('Notification'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)
];

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta/utils/colors.dart';
import 'package:insta/utils/globarVariables.dart';
import 'package:insta/widgets/posts_card.dart';

class FeedScreeen extends StatefulWidget {

  const FeedScreeen({super.key});

  @override
  State<FeedScreeen> createState() => _FeedScreeenState();
}

class _FeedScreeenState extends State<FeedScreeen> {
  @override
  Widget build(BuildContext context) {
      final width = MediaQuery.of(context).size.width;

    return Scaffold(
     backgroundColor:
          width > webScreen ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreen
          ? null
          : AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 32,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.messenger_outline))
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
               return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreen ? width * 0.3 : 0,
                vertical: width > webScreen ? 15 : 0,
              ),
              child: PostsCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
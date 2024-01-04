import 'package:flutter/material.dart';
import 'package:kittyknowhow/components/post_card.dart';
import 'package:kittyknowhow/models/post_viewmodel.dart';
import 'package:kittyknowhow/utils/constants.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(-2507562),
          title: Text(
            'KittyKnowhow',
            style: homeHeadingText,
          ),
        ),
        backgroundColor: Color(-2507562),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return PostCard(
                    owner_name: 'owner',
                    title: 'Is cat nip safe?',
                    body:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac urna vitae mauris sodales rhoncus. Vestibulum accumsan lobortis libero a aliquam. Praesent feugiat metus ut euismod ornare.',
                    likes: 0,
                    comments: 0,
                    image: 'assets/images/pawprint.png',
                    hasImage: true);
              }),
        ));
  }
}

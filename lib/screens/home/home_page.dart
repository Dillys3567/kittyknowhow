import 'package:flutter/material.dart';
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
                return Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(-6656375), width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Posted by Poster',
                                style: smallSignUpText,
                              ),
                              Text(
                                'Is catnip safe?',
                                style: signupButtonText,
                              ),
                            ],
                          ),
                        ),
                        (true)
                            ? Card(
                                child: Image.asset(
                                  'assets/images/pawprint.png',
                                ),
                                elevation: 6,
                              )
                            : Container(),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.favorite_border_rounded)),
                            Text('0'),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.messenger_outline_rounded)),
                            Text('0'),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}

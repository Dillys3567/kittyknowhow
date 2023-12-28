import 'package:flutter/material.dart';
import 'package:kittyknowhow/components/pet_card.dart';
import 'package:kittyknowhow/screens/settings/settings_page.dart';
import 'package:kittyknowhow/screens/signup_signin/signup_signin.dart';
import 'package:kittyknowhow/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            backgroundColor: Color(-6656375),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.fromLTRB(0, 30, 0, 60),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sven",
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'IndieFlower',
                        fontWeight: FontWeight.w900,
                        fontSize: 30),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            snap: true,
            floating: true,
            pinned: true,
            expandedHeight: 160,
            bottom: TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                indicatorWeight: 8,
                unselectedLabelColor: Color(-2507562),
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'IndieFlower',
                    fontWeight: FontWeight.w900,
                    fontSize: 25),
                controller: tabController,
                tabs: [
                  Tab(
                    child: Text('Pets'),
                  ),
                  Tab(
                    child: Text('Posts'),
                  )
                ]),
            actions: [
              Icon(
                Icons.edit,
                color: Colors.white,
                size: 25,
              ),
              IconButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage())),
                  icon: Icon(
                    Icons.menu_rounded,
                    color: Colors.white,
                    size: 35,
                  ))
            ],
          ),
          SliverFillRemaining(
              child: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    PetCard(
                        image: 'assets/images/pawprint.png',
                        petName: 'KitKat',
                        petBreed: 'Orange baby',
                        petAge: '6'),
                    PetCard(
                        image: 'assets/images/pawprint.png',
                        petName: 'KitKat',
                        petBreed: 'Orange baby',
                        petAge: '6'),
                    PetCard(
                        image: 'assets/images/pawprint.png',
                        petName: 'KitKat',
                        petBreed: 'Orange baby',
                        petAge: '6'),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [Text('posts')],
                ),
              ),
            ],
            controller: tabController,
          ))
        ],
      ),
    );
  }
}

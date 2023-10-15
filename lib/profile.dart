import 'package:Rewind/models/Memory.dart';
import 'package:Rewind/services/FirestoreService.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(6),
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          padding: EdgeInsets.all(5),
                          onPressed: () {
                            Navigator.pop(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: ProfilePage()));
                          },
                          icon: Icon(Icons.arrow_back),
                          iconSize: 28,
                          color: Colors.white),
                      Text("Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 24)),
                      IconButton(
                          padding: EdgeInsets.all(5),
                          onPressed: () {},
                          icon: Icon(Icons.more_vert),
                          iconSize: 28,
                          color: Colors.white),
                    ]),
              ),
              //Container(Ima)
              Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                    radius: 116,
                    backgroundImage: AssetImage('assets/images/pfp.jpg')),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text("Andre Koga",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 22)),
                    Text("@akoga3",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 16,
                      decoration: BoxDecoration(
                          color: new Color(0xFF222222),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            "\"There's no editing stage.\"",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text("Your Posts",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 22)),
                  ),
                ],
              ),
              ...listOfPosts(Provider.of<FirestoreService>(context, listen: true).getMemories())
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}

List<Widget> listOfPosts(List<Memory> memories) {
  List<Widget> allPosts = [];
  memories.forEach((mem) => allPosts.add(Padding(
        padding: const EdgeInsets.all(2),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                color: new Color(0xFF111111),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "At Atlanta - Georgia Tech",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        mem.timestamp.toDate().toString().substring(0, 16),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Text(
                      mem.preview,
                      style:
                          TextStyle(color: Colors.white, fontFamily: "Inter"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {},
        ),
      )));

  return allPosts;
}

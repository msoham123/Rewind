import 'package:Rewind/services/FirebaseAuthService.dart';
import 'package:Rewind/services/FirestoreService.dart';
import 'package:Rewind/newPost.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'profile.dart';
import 'package:Rewind/auth/home_screen.dart';

class RewindApp extends StatelessWidget {
  const RewindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<FirebaseAuthService>(
            create: (_) => FirebaseAuthService(),
          ),
          Provider<FirestoreService>(
            create: (_) => FirestoreService(),
          ),
        ],
        child: MaterialApp(
          title: 'Rewind',
          theme: ThemeData(
            fontFamily: 'JetBrainsMono',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(title: "HI"),
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.jpg"),
                    fit: BoxFit.cover)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(6),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [new Color(0xCC000000), Colors.transparent])),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            padding: EdgeInsets.all(5),
                            onPressed: () {},
                            icon: Icon(Icons.people),
                            iconSize: 28,
                            color: Colors.transparent),
                        Text("Rewind",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 24)),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: ProfilePage()));
                            },
                            padding: EdgeInsets.all(5),
                            icon: CircleAvatar(
                                radius: 18,
                                backgroundImage:
                                    AssetImage('assets/images/pfp.jpg')),
                            iconSize: 28,
                            color: Colors.white),
                      ]),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: NewPostPage()));
          },
          tooltip: 'Post',
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            padding: EdgeInsets.all(5),
                            onPressed: () {
                              Navigator.pop(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.topToBottom,
                                      child: NewPostPage()));
                            },
                            icon: Icon(Icons.cancel_sharp),
                            iconSize: 30,
                            color: Colors.white),
                        Text("New Post",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 24)),
                        IconButton(
                            padding: EdgeInsets.all(5),
                            onPressed: () {},
                            icon: Icon(Icons.people),
                            iconSize: 28,
                            color: Colors.transparent),
                      ]),
                ),
                Text("test")
              ],
            )));
  }
}
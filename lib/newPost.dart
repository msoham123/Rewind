import 'package:Rewind/services/FirebaseAuthService.dart';
import 'package:Rewind/services/FirestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

import 'models/Conversation.dart';
import 'models/Memory.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final _emojiController = TextEditingController();
  final _postController = TextEditingController();
  Location location = new Location();

  void makePost(BuildContext context) async {
    String text = _postController.text;
    String emoji = _emojiController.text;
    if (emoji.isEmpty) {
      emoji = '🤔';
    }
    if (!text.isEmpty) {
      LocationData pos = await location.getLocation();
      String authorId = Provider.of<FirebaseAuthService>(context, listen: false).getUser()?.uid ?? 'unknown';
      Memory memory = Memory(
          author: authorId,
          emoji: emoji,
          preview: text,
          timestamp: Timestamp.now(),
          lat: pos.latitude ?? 0.0,
          long: pos.longitude ?? 0.0,
      );
      Message msg = Message(
          author: authorId,
          content: text,
          timestamp: Timestamp.now()
      );
      Provider.of<FirestoreService>(context, listen: false).addMemory(memory, msg);
    }
  }

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
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emojiController,
                          decoration: const InputDecoration(
                            labelText: 'Emoji',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Choose an emoji!';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _postController,
                          decoration: const InputDecoration(
                            labelText: 'Text',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Can\'t leave the post empty!';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: ElevatedButton(
                                onPressed: () {
                                  makePost(context);
                                  _emojiController.clear();
                                  _postController.clear();
                                  Navigator.pop(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.topToBottom,
                                          child: NewPostPage()));
                                },
                                child: const Text(
                                  'Post!',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}

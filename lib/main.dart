import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Rewind/services/FirestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Rewind/models/Message.dart';
import 'package:Rewind/auth/SignIn.dart';
import 'package:Rewind/auth/home_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'firebase_options.dart';

import 'package:Rewind/main.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // sign in page, onsignin navigate to MyHomePage
      home: SignIn(
        onSignIn: () {
          print("HI");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(title: "HI")),

            );
        },
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


import 'package:Rewind/ar_screen.dart';
import 'package:Rewind/location_screen.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RewindApp());
}

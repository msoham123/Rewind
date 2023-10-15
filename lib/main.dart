import 'package:Rewind/widget_projection.dart';
import 'package:Rewind/location_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RewindApp());
}

class RewindApp extends StatelessWidget {
  const RewindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rewind',
      theme: ThemeData(
        fontFamily: 'JetBrainsMono',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Rewind'),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a blue toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: MyHome(),
//     );
//   }
// }
//
// class MyHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//               onPressed: () {
//                 try {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => TapPage())
//                   );
//                 } catch (e) {
//                   print(e);
//                 }
//               },
//               child: const Text("AR Demo")
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 try {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const LocationScreen())
//                   );
//                 } catch (e) {
//                   print(e);
//                 }
//               },
//               child: const Text("Location Test")
//           ),
//         ],
//       ),
//     );
//   }
// }


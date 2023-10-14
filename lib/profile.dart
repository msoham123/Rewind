import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                        onPressed: () {
                          Navigator.pop(context);
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
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

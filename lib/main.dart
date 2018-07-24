import 'package:flutter/material.dart';
import 'ChatScreen.dart';

void main() => runApp(FriendlychatApp());

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fiendly Chat",
      home: ChatScreen()
    );
  }
}


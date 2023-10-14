import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? id;
  String author;
  String content;
  String emoji;
  Timestamp timestamp;
  double lat;
  double long;
  double altitude;


  Message({this.id, required this.author, required this.content, required this.emoji, required this.timestamp, required this.lat, required this.long, required this.altitude});

  factory Message.fromJson(Map<String, dynamic> data) {
    data = data ?? {};
    return Message(
      id: data['id'],
      author: data['author'],
      content: data['content'],
      emoji: data['emoji'],
      timestamp: data['timestamp'],
      lat: data['lat'],
      long: data['long'],
      altitude: data['altitude']
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'author': author,
      'content': content,
      'emoji': emoji,
      'timestamp': timestamp,
      'lat': lat,
      'long': long,
      'altitude': altitude,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
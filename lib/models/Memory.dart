import 'package:cloud_firestore/cloud_firestore.dart';

class Memory {
  String? id;
  String? conversationId;
  String author;
  String emoji;
  Timestamp timestamp;
  double lat;
  double long;
  double altitude;


  Memory({this.id, this.conversationId, required this.author, required this.emoji, required this.timestamp, required this.lat, required this.long, required this.altitude});

  factory Memory.fromJson(Map<String, dynamic> data) {
    data = data ?? {};
    return Memory(
      id: data['id'],
      conversationId: data['conversationId'],
      author: data['author'],
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
      'emoji': emoji,
      'timestamp': timestamp,
      'lat': lat,
      'long': long,
      'altitude': altitude,
    };
    if (id != null) {
      map['id'] = id;
    }
    if (conversationId != null) {
      map['conversationId'] = conversationId;
    }
    return map;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class Memory {
  String? id;
  String? conversationId;
  String author;
  String emoji;
  String preview;
  Timestamp timestamp;
  double lat;
  double long;


  Memory({this.id, this.conversationId, required this.author, required this.emoji, required this.preview, required this.timestamp, required this.lat, required this.long});

  factory Memory.fromJson(Map<String, dynamic> data) {
    data = data ?? {};
    return Memory(
      id: data['id'],
      conversationId: data['conversationId'],
      author: data['author'],
      emoji: data['emoji'],
      preview: data['preview'],
      timestamp: data['timestamp'],
      lat: data['lat'],
      long: data['long']
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'author': author,
      'emoji': emoji,
      'preview': preview,
      'timestamp': timestamp,
      'lat': lat,
      'long': long
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
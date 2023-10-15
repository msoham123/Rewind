import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  String? id;
  List<Message> messages;

  Conversation({this.id, required this.messages});

  factory Conversation.fromJson(Map<String, dynamic> data) {
    data = data ?? {};
    return Conversation(
      id: data['id'],
      messages: data['messages'].map((msg) => Message.fromJson(msg)),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'messages': messages.map((msg) => msg.toJson()),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}

class Message {
  String? id;
  String author;
  String content;
  Timestamp timestamp;

  Message({this.id, required this.author, required this.content, required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> data) {
    data = data ?? {};
    return Message(
      id: data['id'],
      author: data['author'],
      content: data['content'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'author': author,
      'content': content,
      'timestamp': timestamp,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
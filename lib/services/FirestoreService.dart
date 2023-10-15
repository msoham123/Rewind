import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Rewind/models/Memory.dart';
import 'package:Rewind/models/Conversation.dart';

class FirestoreService {
  final _firestoreService = FirebaseFirestore.instance;

  // push a message to the 'messages' collection
  Future<void> addMemory(Message msg) async {
    await _firestoreService.collection('memories').add(msg.toJson());
  }

  // return all messages from the message collection
  Future<List<Message>> getMemories() async {
    List<Message> output = [];
    await _firestoreService.collection('messages').get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        output.add(Message.fromJson({...doc.data(), 'id': doc.id}));
      });
    });
    return output;
  }

  Future<void> addReply(String convoId, Message newMessage) async {
    Conversation convo = await getConversation(convoId);
    convo.messages.add(newMessage);
    await _firestoreService.collection('conversations').doc(convoId).update(convo.toJson());
  }

  Future<Conversation> getConversation(String convoId) async {
    return _firestoreService.collection('conversations').doc(convoId).get().then((doc) {
      return Conversation.fromJson(doc.data()!);
    });
  }
}
/*
  void _listMessages() async {
    List<Message> messages = await _db.getMessages();
    messages.forEach((msg) {
      print(msg.toJson());
    });
  }

  void _addTestMessage() async {
    Message msg = Message(
      author: 'w4ciwehu54',
      content: 'Hello world',
      emoji: '🔥',
      timestamp: Timestamp.now(),
      lat: 10.4,
      long: 15.6
    );
    await _db.pushMessage(msg);
  }
 */
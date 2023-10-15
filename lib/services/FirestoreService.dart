
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Rewind/models/Memory.dart';
import 'package:Rewind/models/Conversation.dart';

class FirestoreService {
  final _firestoreService = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _memoryStream = FirebaseFirestore.instance.collection("memories").snapshots();
  List<Memory> _memories = [];
  List<Memory> getMemories() => _memories;

  // push a memory to the 'memory' collection
  Future<void> addMemory(Memory memory, Message message) async {
    Conversation convo = Conversation(messages: [message]);
    var res = await _firestoreService.collection('conversations').add(convo.toJson());
    convo.id = res.id;

    memory.conversationId = res.id;

    var fb_memory = await _firestoreService.collection('memories').add(memory.toJson());
    memory.id = fb_memory.id;
    _memories.add(memory);
  }

  // return all memories from the memory collection
  Future<List<Memory>> loadMemories() async {
    List<Memory> output = [];
    await _firestoreService.collection('memories').get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        output.add(Memory.fromJson({...doc.data(), 'id': doc.id}));
      });
    });
    // listenToMemories();
    _memories = output;
    return output;
  }

  // log whenever a memory is added to the 'memories' collection
  void listenToMemories() {
    _memoryStream.listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          print(change.doc.data());
          // _memories.add(Memory.fromJson({...change.doc.data()!, 'id': change.doc.id}));
        }
      });
    });
  }

  // TODO: should this take in conversation instead of the id?
  Future<void> addReply(String convoId, Message newMessage) async {
    Conversation convo = await getConversation(convoId);
    convo.messages.add(newMessage);
    await _firestoreService.collection('conversations').doc(convoId).update(convo.toJson());
  }

  Future<Conversation> getConversation(String convoId) async {
    return _firestoreService.collection('conversations').doc(convoId).get().then((doc) {
      Map<String, dynamic> data = {...doc.data()!, 'id': doc.id};
      return Conversation.fromJson(data);
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
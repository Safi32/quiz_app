import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/model/topics_model.dart';

class TopicController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get topicsCollection => _firestore.collection('topics');

  // Generate a random string ID
  String _generateRandomId(int length) {
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  // Stream to fetch topics in real-time
  Stream<List<TopicModel>> getTopicsStream() {
    return topicsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TopicModel.fromFirestore(doc);
      }).toList();
    });
  }

  // Add a topic with a random ID
  Future<void> addTopic(String name) async {
    String randomId = _generateRandomId(10); // Generate a random ID of length 10
    await topicsCollection.add({'name': name, 'topicID': randomId});
  }

  // Check if a topic exists
  Future<bool> topicExists(String name) async {
    final querySnapshot = await topicsCollection
        .where('name', isEqualTo: name)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }
}

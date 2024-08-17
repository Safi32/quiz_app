import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/enums/topics_enum.dart';
import 'package:quiz_app/model/topics_model.dart';

class TopicController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get topicsCollection => _firestore.collection('topics');

  Future<void> syncFirestoreWithEnum() async {
    final topicsFromEnum = Topic.values.map((e) => e.name).toSet();

    final querySnapshot = await topicsCollection.get();
    final existingTopics =
        querySnapshot.docs.map((doc) => doc['name'] as String).toSet();

    final topicsToAdd = topicsFromEnum.difference(existingTopics);

    for (var topic in topicsToAdd) {
      final topicID = _generateRandomId(10);
      await topicsCollection.add({'name': topic, 'topicID': topicID});
    }
  }

  String _generateRandomId(int length) {
    const _chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  Stream<List<TopicModel>> getTopicsStream() {
    return topicsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TopicModel.fromFirestore(doc);
      }).toList();
    });
  }
}

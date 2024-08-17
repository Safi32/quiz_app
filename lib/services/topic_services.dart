import 'dart:math';

import 'package:quiz_app/controllers/topics_controller.dart';
import 'package:quiz_app/enums/topics_enum.dart';

class TopicService {
  final TopicController _topicController = TopicController();

  Future<void> initializeTopics() async {
    // Get all topics from the enum
    final topicsFromEnum = Topic.values.map((e) => e.name).toSet();
    
    // Fetch existing topics from Firestore
    final existingTopics = await _fetchExistingTopics();
    
    // Find topics that need to be added
    final topicsToAdd = topicsFromEnum.difference(existingTopics);
    
    // Add missing topics to Firestore
    for (var topic in topicsToAdd) {
      final topicID = _generateRandomId(10); // Generate a random ID
      await _topicController.topicsCollection.add({'name': topic, 'topicID': topicID});
    }
  }

  // Fetch existing topics from Firestore
  Future<Set<String>> _fetchExistingTopics() async {
    final querySnapshot = await _topicController.topicsCollection.get();
    return querySnapshot.docs.map((doc) => doc['name'] as String).toSet();
  }

  // Generate a random string ID
  String _generateRandomId(int length) {
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}

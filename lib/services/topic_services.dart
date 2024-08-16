import 'package:quiz_app/controllers/topics_controller.dart';
import 'package:quiz_app/enums/topics_enum.dart';

class TopicService {
  final TopicController _topicController = TopicController();

  Future<void> initializeTopics() async {
    for (Topic topic in Topic.values) {
      await _addTopicIfNotExists(topic);
    }
  }

  Future<void> _addTopicIfNotExists(Topic topic) async {
    String topicName = topic.toString().split('.').last; // Convert enum to string
    final querySnapshot = await _topicController.topicsCollection
        .where('name', isEqualTo: topicName)
        .get();

    if (querySnapshot.docs.isEmpty) {
      await _topicController.addTopic(topicName);
    } else {
      print('Topic already exists: $topicName');
    }
  }
}

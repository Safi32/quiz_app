import 'package:quiz_app/controllers/topics_controller.dart';
import 'package:quiz_app/enums/topics_enum.dart';

class TopicService {
  final TopicController _topicController = TopicController();

  Future<void> initializeTopics() async {
    // Iterate over all enum values
    for (Topic topic in Topic.values) {
      await _addTopicIfNotExists(topic);
    }
  }

  Future<void> _addTopicIfNotExists(Topic topic) async {
    String topicName = topic.name;

    // Use the public method to check if a topic exists
    bool exists = await _topicController.topicExists(topicName);
    
    if (!exists) {
      // Only add topics that are defined in the enum
      await _topicController.addTopic(topicName);
      print('Added topic: $topicName');
    } else {
      print('Topic already exists: $topicName');
    }
  }
}

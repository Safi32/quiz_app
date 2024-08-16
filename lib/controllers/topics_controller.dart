import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/model/topics_model.dart';
import 'package:uuid/uuid.dart';

class TopicController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _topicsCollection;

  TopicController() {
    _topicsCollection = _firestore.collection('topics');
  }

  Future<String?> addTopic(String name) async {
    try {
      QuerySnapshot querySnapshot =
          await _topicsCollection.where('name', isEqualTo: name).get();

      if (querySnapshot.docs.isNotEmpty) {
        print('Error: Topic already included: $name');
        return 'Topic already included';
      } else {
        String topicID = Uuid().v4();
        TopicModel topic = TopicModel(name: name, topicID: topicID);

        await _topicsCollection.add(topic.toMap());
        print('Success: Topic added successfully: $name');
        return null;
      }
    } catch (e) {
      print('Error adding topic: $e');
      return 'Error adding topic';
    }
  }

  Future<List<TopicModel>> fetchTopics() async {
    try {
      QuerySnapshot querySnapshot = await _topicsCollection.get();
      List<TopicModel> topics = querySnapshot.docs.map((doc) {
        return TopicModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return topics;
    } catch (e) {
      print('Error fetching topics: $e');
      return [];
    }
  }

  Future<void> updateTopic(String topicID, String newName) async {
    try {
      await _topicsCollection.doc(topicID).update({'name': newName});
      print('Success: Topic updated successfully: $newName');
    } catch (e) {
      print('Error updating topic: $e');
    }
  }

  Future<void> deleteTopic(String topicID) async {
    try {
      await _topicsCollection.doc(topicID).delete();
      print('Success: Topic deleted successfully: $topicID');
    } catch (e) {
      print('Error deleting topic: $e');
    }
  }
}

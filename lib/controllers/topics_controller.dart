import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/model/topics_model.dart';
import 'package:uuid/uuid.dart';


class TopicController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _topicsCollection;

  TopicController() {
    _topicsCollection = _firestore.collection('topics');
  }

  CollectionReference get topicsCollection => _topicsCollection;

  Future<String?> addTopic(String name) async {
    try {
      String topicID = Uuid().v4();
      TopicModel topic = TopicModel(name: name, topicID: topicID);

      await _topicsCollection.add(topic.toMap());
      print('Success: Topic added successfully: $name');
      return null;
    } catch (e) {
      print('Error adding topic: $e');
      return 'Error adding topic';
    }
  }

  Future<List<TopicModel>> fetchTopics() async {
    try {
      QuerySnapshot querySnapshot = await _topicsCollection.get();
      return querySnapshot.docs.map((doc) {
        return TopicModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching topics: $e');
      return [];
    }
  }
}

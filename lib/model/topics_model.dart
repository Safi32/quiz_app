import 'package:cloud_firestore/cloud_firestore.dart';

class TopicModel {
  final String id;
  final String name;
  final String topicID; 

  TopicModel({required this.id, required this.name, required this.topicID});

  factory TopicModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return TopicModel(
      id: doc.id,
      name: data['name'] ?? '',
      topicID: data['topicID'] ?? '', // Retrieve the random topic ID
    );
  }
}

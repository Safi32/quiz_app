class TopicModel {
  final String name;
  final String topicID;

  TopicModel({
    required this.name,
    required this.topicID,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'topicID': topicID,
    };
  }

  factory TopicModel.fromMap(Map<String, dynamic> map) {
    return TopicModel(
      name: map['name'] ?? '',
      topicID: map['topicID'] ?? '',
    );
  }
}

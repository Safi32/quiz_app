class TopicModel {
  final String id;
  final String name;

  TopicModel({
    required this.id,
    required this.name,
  });

  factory TopicModel.fromFirestore(Map<String, dynamic> json, String id) {
    return TopicModel(
      id: id,
      name: json['Name'] ?? '',
    );
  }

  @override
  String toString() => 'TopicModel(id: $id, name: $name)';
}

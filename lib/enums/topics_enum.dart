enum Topic { maths }

extension TopicExtension on Topic {
  String get name {
    switch (this) {
      default:
        return '';
    }
  }
}

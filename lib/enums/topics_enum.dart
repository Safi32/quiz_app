enum Topic {
  maths,
  phy,
  bio,
  chem,
  coding,
}

extension TopicExtension on Topic {
  String get name {
    switch (this) {
      case Topic.maths:
        return 'Maths';
      case Topic.phy:
        return 'Physics';
      case Topic.bio:
        return 'Biology';
      default:
        return '';
    }
  }
}

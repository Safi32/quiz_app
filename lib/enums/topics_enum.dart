enum Topic { maths, phy, bio, chem, coding, computer, urdu }

extension TopicExtension on Topic {
  String get name {
    switch (this) {
      case Topic.maths:
        return 'Maths';
      case Topic.phy:
        return 'Physics';
      case Topic.bio:
        return 'Biology';
      case Topic.chem:
        return 'Chemistry';
      case Topic.coding:
        return 'Coding';
      case Topic.computer:
        return 'Computer';
      case Topic.urdu:
        return 'Urdu';
      default:
        return '';
    }
  }
}

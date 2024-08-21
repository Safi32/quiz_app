import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:quiz_app/model/mcqs_model.dart';

class MCQController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<MCQ>> fetchQuestions(String topicName) {
    return _firestore
        .collection('topics')
        .doc(topicName)
        .collection('Physics_mcqs')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => MCQ.fromFirestore(doc)).toList());
  }
}

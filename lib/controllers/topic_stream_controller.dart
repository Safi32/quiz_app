// // import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:quiz_app/model/topics_model.dart';

// class TopicController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
//   Stream<List<TopicModel>> getTopicsStream() {
//     return _firestore.collection('topics').snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return TopicModel.fromFirestore(doc);
//       }).toList();
//     });
//   }
// }

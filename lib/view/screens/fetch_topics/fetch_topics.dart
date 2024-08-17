import 'package:flutter/material.dart';
import 'package:quiz_app/controllers/topics_controller.dart';
import 'package:quiz_app/model/topics_model.dart';
import 'package:quiz_app/utils/colors.dart';

class FetchTopics extends StatefulWidget {
  static const routeName = "fetchTopics";

  const FetchTopics({super.key});

  @override
  _FetchTopicsState createState() => _FetchTopicsState();
}

class _FetchTopicsState extends State<FetchTopics> {
  final TopicController _topicController = TopicController();

  @override
  void initState() {
    super.initState();
    _syncEnumWithFirestore();
  }

  Future<void> _syncEnumWithFirestore() async {
    await _topicController.syncFirestoreWithEnum();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(
                    "Select Topic",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<List<TopicModel>>(
                  stream: _topicController.getTopicsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No topics available'));
                    } else {
                      final topics = snapshot.data!
                          .where((topic) => topic.name.isNotEmpty)
                          .toList();
                      if (topics.isEmpty) {
                        return const Center(child: Text('No topics available'));
                      }
                      return ListView.builder(
                        itemCount: topics.length,
                        itemBuilder: (context, index) {
                          final topic = topics[index];
                          return Card(
                            child: ListTile(
                              title: Text(topic.name),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

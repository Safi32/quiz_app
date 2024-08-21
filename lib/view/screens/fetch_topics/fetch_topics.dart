import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controllers/topic_controller.dart';
import 'package:quiz_app/model/topic_model.dart';
import 'package:quiz_app/provider/topic_provider.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/view/screens/free_test/free_test.dart';


class FetchTopics extends StatelessWidget {
  static const routeName = "fetchTopics";

  const FetchTopics({super.key});

  @override
  Widget build(BuildContext context) {
    final topicController = Provider.of<TopicController>(context);
    final selectedTopicProvider = Provider.of<SelectedTopicProvider>(context);

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
                  stream: topicController.fetchTopics(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No topics available"));
                    }
                    final topics = snapshot.data!;
                    return ListView.builder(
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        final topic = topics[index];
                        final isSelected = topic.id == selectedTopicProvider.selectedTopicId;
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(
                              topic.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            tileColor: isSelected
                                ? primaryColor.withOpacity(0.2)
                                : null,
                            onTap: () {
                              selectedTopicProvider.selectTopic(topic.id);
                            },
                            trailing: isSelected
                                ? const Icon(Icons.check, color: primaryColor)
                                : null,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedTopicProvider.selectedTopicId == null
                    ? null
                    : () {
                        Navigator.pushNamed(
                          context,
                          FreeTest.routeName,
                          arguments: selectedTopicProvider.selectedTopicId,
                        );
                      },
                child: const Text('Start Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

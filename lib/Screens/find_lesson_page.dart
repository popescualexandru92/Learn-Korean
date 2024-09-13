import 'package:flutter/material.dart';
import '../providers/lesson_provider.dart';
import '../Widgets/button_to_lesson.dart';

class FindLessonPage extends StatefulWidget {
  const FindLessonPage({super.key});

  static String routeName = '/findLesson';

  @override
  State<FindLessonPage> createState() => _FindLessonPageState();
}

class _FindLessonPageState extends State<FindLessonPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Lesson> filteredLessons = lessons
        .where((element) => element.title
            .toLowerCase()
            .contains(_controller.text.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Find Lesson",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter your text'),
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredLessons.length,
                itemBuilder: (context, index) {
                  Lesson item = filteredLessons[index];
                  return ButtonToLesson(
                    lesson: item,
                    wordsToHighLight: "",
                  );
                }),
          )
        ],
      ),
    );
  }
}

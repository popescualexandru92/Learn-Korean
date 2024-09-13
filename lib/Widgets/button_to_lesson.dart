import 'package:flutter/material.dart';
import 'package:learnkorean/providers/lesson_provider.dart';
import '../Screens/lesson_page.dart';

class ButtonToLesson extends StatelessWidget {
  final Lesson lesson;
  final String wordsToHighLight;
  const ButtonToLesson(
      {super.key, required this.lesson, required this.wordsToHighLight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: GestureDetector(
        child: Card(
          color: const Color.fromRGBO(34, 123, 148, 1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              lesson.title,
              style: const TextStyle(
                  color: Color.fromRGBO(238, 231, 215, 0.9), fontSize: 18),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(LessonPage.routeName,
              arguments: {'lesson': lesson, 'words': wordsToHighLight});
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../providers/lesson_provider.dart';
import '../Widgets/button_to_lesson.dart';

class LessonList extends StatelessWidget {
  const LessonList({super.key});
  static String routeName = "/lessonList";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String title = args?['title'];
    String category = args?['category'];
    List<Lesson> filteredLessons =
        lessons.where((element) => element.category == category).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: filteredLessons.length,
            itemBuilder: ((context, index) {
              Lesson item = filteredLessons[index];
              return ButtonToLesson(lesson: item,wordsToHighLight: "",);
            }),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:learnkorean/Screens/find_lesson_page.dart';
import 'package:learnkorean/Screens/lesson_list_page.dart';
import 'package:learnkorean/Screens/search_through_lessons.dart';
import '../Widgets/homepage_button.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});
  static String routeName = "/lessons";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lessons"),
      ),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomePageButton(
                  text: "Beginner 0",
                  route: () {
                    Navigator.of(context).pushNamed(LessonList.routeName,
                        arguments: {"category": "B0", "title": "Beginner 0"});
                  }),
              const SizedBox(
                height: 10,
              ),
              HomePageButton(
                  text: "Beginner 1",
                  route: () {
                    Navigator.of(context).pushNamed(LessonList.routeName,
                        arguments: {"category": "B1", "title": "Beginner 1"});
                  }),
              const SizedBox(
                height: 10,
              ),
              HomePageButton(
                  text: "Beginner 2",
                  route: () {
                    Navigator.of(context).pushNamed(LessonList.routeName,
                        arguments: {"category": "B2", "title": "Beginner 2"});
                  }),
              const SizedBox(
                height: 10,
              ),
              HomePageButton(
                  text: "Beginner 3",
                  route: () {
                    Navigator.of(context).pushNamed(LessonList.routeName,
                        arguments: {"category": "B3", "title": "Beginner 3"});
                  }),
              const SizedBox(
                height: 10,
              ),
              HomePageButton(
                  text: "Intermediate 1",
                  route: () {
                    Navigator.of(context).pushNamed(LessonList.routeName,
                        arguments: {
                          "category": "I1",
                          "title": "Intermediate 1"
                        });
                  }),
            ],
          ),
          Column(
            children: [
              WideButton(
                  title: "Find a lesson by title",
                  route: FindLessonPage.routeName),
              const SizedBox(
                height: 10,
              ),
              WideButton(
                  title: "Find a lesson by content",
                  route: SearchThroughLessons.routeName)
            ],
          ),
        ]),
      ),
    );
  }
}

class WideButton extends StatelessWidget {
  final String title;
  final String route;
  const WideButton({
    super.key,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            route,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
              color: Theme.of(context)
                  .elevatedButtonTheme
                  .style
                  ?.backgroundColor
                  ?.resolve({}),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromRGBO(238, 231, 215, 0.9),
                    fontSize: 20,
                  ),
                ),
              )),
        ));
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:learnkorean/Screens/find_lesson_page.dart';
import 'package:learnkorean/Screens/flash_cards_page.dart';
import 'package:learnkorean/Screens/known_words_page.dart';
import 'package:learnkorean/Screens/lesson_list_page.dart';
import 'package:learnkorean/Screens/lesson_page.dart';
import 'package:learnkorean/Screens/lessons_page.dart';
import 'package:learnkorean/Screens/search_through_lessons.dart';
import 'package:provider/provider.dart';
import 'providers/flash_card_provider.dart';
import './Screens/homepage.dart';
import './Screens/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: FlashCard()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: const Color.fromRGBO(88, 163, 153, 1)),
            appBarTheme: AppBarTheme(
                color: Color.fromARGB(255, 33, 72, 58),
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 23)),
            iconTheme: IconThemeData(color: Colors.white),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(34, 123, 148, 1),
            )),
            drawerTheme: DrawerThemeData(
                backgroundColor: Color.fromRGBO(246, 238, 227, 1)),
            scaffoldBackgroundColor: Color.fromRGBO(246, 238, 227, 1),
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(88, 163, 153, 1)),
          ),
          home: MyHomePage(title: "Flash Cards"),
          routes: {
            SearchWordPage.routeName: (context) => SearchWordPage(),
            FlashCardsPage.routeName: (context) => FlashCardsPage(),
            KnowWordsPage.routeName: (context) => KnowWordsPage(),
            LessonsPage.routeName: (context) => LessonsPage(),
            LessonList.routeName: (context) => LessonList(),
            LessonPage.routeName: (context) => LessonPage(),
            FindLessonPage.routeName: (context) => FindLessonPage(),
            SearchThroughLessons.routeName:(context)=>SearchThroughLessons()
          }),
    );
  }
}

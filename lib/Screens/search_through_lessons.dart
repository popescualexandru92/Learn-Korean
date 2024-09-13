// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:learnkorean/Widgets/button_to_lesson.dart';
import 'package:learnkorean/providers/lesson_provider.dart';

class SearchThroughLessons extends StatefulWidget {
  const SearchThroughLessons({super.key});
  static String routeName = '/searchthroughlessons';

  @override
  State<SearchThroughLessons> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchThroughLessons> {
  final TextEditingController _controller = TextEditingController();

  int countLetters(String word) {
    int letterCount = 0;

    for (int i = 0; i < word.length; i++) {
      int codeUnit = word.codeUnitAt(i);

      if (codeUnit >= 0xAC00 && codeUnit <= 0xD7A3) {
        int jongseongIndex = (codeUnit - 0xAC00) % 28;

        letterCount += 2;
        if (jongseongIndex != 0) {
          letterCount += 1;
        }
      } else {
        return word.length;
      }
    }

    return letterCount;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Lesson> filteredLessons = lessons
        .where((element) => element.text.contains(_controller.text))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search through lessons",
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
                setState(() {
              
                });
              },
            ),
          ),
          _controller.text.isNotEmpty && filteredLessons.length == 0
              ? Column(
                  children: [
                    const Text("No results found for:"),
                    SelectableText(_controller.text),
                  ],
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: filteredLessons.length,
                      itemBuilder: (context, index) {
                        Lesson item = filteredLessons[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ButtonToLesson(
                              lesson: item,
                              wordsToHighLight: _controller.text.trim().isEmpty
                                  ? ""
                                  : _controller.text,
                            ),
                            if (countLetters(
                                    _controller.text.trim()) >=
                                3)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      "Number of occurences: ${RegExp(_controller.text).allMatches(item.text).length}"),
                                ),
                              ),
                            const Divider(),
                          ],
                        );
                      }),
                )
        ],
      ),
    );
  }
}

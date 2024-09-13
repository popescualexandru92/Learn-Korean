


import "package:flutter/material.dart";
import 'package:learnkorean/Screens/known_words_page.dart';
import 'package:learnkorean/Screens/lessons_page.dart';
import 'package:learnkorean/Screens/search_page.dart';
import 'package:learnkorean/providers/flash_card_provider.dart';

import 'package:provider/provider.dart';


import '../Widgets/main_drawer.dart';
import '../Widgets/homepage_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  static String routeName = '/flashcards';

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isInit = true;
  int index = 0;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<FlashCard>(context, listen: false).fetchData();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<FlashCard>(
        builder: (context, flashCardProvider, child) {
          if (flashCardProvider.words.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HomePageButton(
                      text: "Lessons",
                      route: () {
                        Navigator.of(context).pushNamed(LessonsPage.routeName);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  HomePageButton(
                    text: "Search words",
                    route: () {
                      Navigator.of(context).pushNamed(SearchWordPage.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HomePageButton(
                    text: "Known Words",
                    route: () {
                      Navigator.of(context)
                          .pushNamed(KnowWordsPage.routeName)
                          .then((value) {
                        setState(() {
                          Provider.of<FlashCard>(context, listen: false)
                              .fetchData();
                        });
                      });
                    },
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Provider.of<FlashCard>(context, listen: false).insert();
                  //     },
                  //     child: Text(" to update"))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

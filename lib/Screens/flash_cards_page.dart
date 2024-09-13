import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import '../Widgets/flip_card_widget.dart';

import '../providers/flash_card_provider.dart';
import 'package:provider/provider.dart';

class FlashCardsPage extends StatefulWidget {
  const FlashCardsPage({
    super.key,
  });

  static String routeName = '/flash_cards_page';

  @override
  State<FlashCardsPage> createState() => _FlashCardsPageState();
}

class _FlashCardsPageState extends State<FlashCardsPage> {
  late FlashCardItem word;
  late String pos;
  late String title;
  late List<String> category;
  int index = 0;

  var _isInit = true;
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    // Lock the screen in portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Reset the preferred orientations when the widget is disposed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void updateToKnown(String eng, String pos) {
    Provider.of<FlashCard>(
      context,
      listen: false,
    ).updateToKnown(eng, pos, true);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final Map<String, dynamic>? args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      title = args?['title'];
      pos = args?['pos'];
      category = args?['category'];
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    FlashCardItem getFilteredWords(String pos, int index, List<String> category,
        [bool needToFilter = false]) {
      return Provider.of<FlashCard>(
        context,
        listen: false,
      ).getFilteredWords(index, pos, category, needToFilter);
    }

    word = getFilteredWords(pos, index, category, true);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Provider.of<FlashCard>(
                  context,
                  listen: false,
                ).filteredWordsCount ==
                0
            ? const Text("No words to display")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("In order "),
                      Switch(
                        value: _isSwitched,
                        onChanged: (value) {
                          setState(() {
                            _isSwitched = value;
                            _isSwitched ? index = -1 : index = 0;
                          });
                        },
                      ),
                      const Text(" Random")
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FlipCard(
                    flashCard: word,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  !_isSwitched
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: index == 0
                                    ? null
                                    : () {
                                        setState(() {
                                          index--;
                                        });
                                      },
                                child: const Row(
                                  children: [
                                    Icon(Icons.skip_previous_rounded),
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        "Back",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromRGBO(
                                                255, 220, 127, 0.9)),
                                      ),
                                    ),
                                  ],
                                )),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  index++;
                                });
                              },
                              child: const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromRGBO(
                                              255, 220, 127, 0.9)),
                                    ),
                                  ),
                                  Icon(Icons.skip_next_rounded),
                                ],
                              ),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              index = -1;
                            });
                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.shuffle_rounded),
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "Random",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromRGBO(
                                              255, 220, 127, 0.9)),
                                    ),
                                  ),
                                ],
                              ))),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      updateToKnown(word.eng, word.pos);
                      setState(() {});
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Known word.\n Do not show again.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 220, 127, 0.9)),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

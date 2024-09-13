import 'package:flutter/material.dart';
import 'package:learnkorean/Screens/search_page.dart';
import '../providers/lesson_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  static String routeName = '/lessonPage';

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int fontSize = 17;
  bool showSizeAdjust = false;

  Future<void> _launchUrl(String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    Lesson lesson = args?['lesson'];
    String wordsToHighlight = args?['words'];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  showSizeAdjust = !showSizeAdjust;
                });
              },
              icon: const Icon(
                Icons.info,
                color: Colors.white,
              ))
        ],
        title: Text(lesson.title),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: wordsToHighlight.isEmpty 
                      ? SelectableText(
                          textAlign: TextAlign.left,
                          lesson.text,
                          style: TextStyle(fontSize: fontSize.toDouble()),
                        )
                      : SelectableHighlightedText(
                          text: lesson.text,
                          query: wordsToHighlight,
                          textStyle: TextStyle(fontSize: fontSize.toDouble()),
                          highlightStyle:
                              const TextStyle(backgroundColor: Colors.yellow),
                        ),
                ),
                Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => _launchUrl(lesson.link),
                      child: Text(
                        "More info: ${lesson.link}",
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showSizeAdjust)
            Positioned(
              top: 16.0,
              right: 16.0,
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        fontSize++;
                      });
                    },
                    child: const Icon(Icons.text_increase),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FloatingActionButton(
                    onPressed: fontSize > 15
                        ? () {
                            setState(() {
                              fontSize--;
                            });
                          }
                        : null,
                    child: const Icon(Icons.text_decrease),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SearchWordPage.routeName);
                    },
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class SelectableHighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle? textStyle;
  final TextStyle? highlightStyle;

  const SelectableHighlightedText({
    super.key,
    required this.text,
    required this.query,
    this.textStyle,
    this.highlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;

    while ((indexOfHighlight =
            text.toLowerCase().indexOf(query.toLowerCase(), start)) !=
        -1) {
      if (indexOfHighlight > start) {
        spans.add(TextSpan(
            text: text.substring(start, indexOfHighlight), style: textStyle));
      }
      spans.add(TextSpan(
        text: text.substring(indexOfHighlight, indexOfHighlight + query.length),
        style:
            highlightStyle ?? const TextStyle(backgroundColor: Colors.yellow),
      ));
      start = indexOfHighlight + query.length;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: textStyle));
    }

    return SelectableText.rich(
      TextSpan(children: spans),
      style: textStyle,
    );
  }
}

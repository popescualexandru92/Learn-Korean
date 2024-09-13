// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:learnkorean/providers/flash_card_provider.dart';
import 'package:provider/provider.dart';
import '../services/googleTTS.dart';

class SearchWordPage extends StatefulWidget {
  const SearchWordPage({super.key});
  static String routeName = '/searchpage';

  @override
  State<SearchWordPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchWordPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<FlashCardItem> words = Provider.of<FlashCard>(
      context,
      listen: false,
    )
        .words
        .where((element) =>
            element.eng
                .toLowerCase()
                .contains(_controller.text.toLowerCase()) ||
            element.kor.contains(_controller.text))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search for words",
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
          _controller.text.isNotEmpty && words.length == 0
              ? Column(
                children: [
                  const Text("No results found for:"),
                  SelectableText(_controller.text),
                ],
              )
              : Expanded(
                  child: ListView.builder(
                      itemCount: words.length,
                      itemBuilder: (context, index) {
                        FlashCardItem item = words[index];
                        return Column(
                          children: [
                            ListTile(
                              title: SelectableText(
                                item.kor,
                              ),
                              subtitle: SelectableText(
                                item.eng,
                              ),
                              trailing: InkWell(
                                onTap: () =>
                                    GoogleTTS().speakWithGoogleTTS(item.kor),
                                child: const Icon(Icons.volume_up),
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

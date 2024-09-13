

import 'package:flutter/material.dart';
import 'package:learnkorean/providers/flash_card_provider.dart';

import 'package:provider/provider.dart';

class KnowWordsPage extends StatefulWidget {
  const KnowWordsPage({super.key});
  static String routeName = '/knownwordspage';

  @override
  State<KnowWordsPage> createState() => _KnowWordsPageState();
}

class _KnowWordsPageState extends State<KnowWordsPage> {
  var _isInit = true;

  void updateToUnKnown(String eng, String pos) {
    Provider.of<FlashCard>(
      context,
      listen: false,
    ).updateToKnown(eng, pos, false);
  }



  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<FlashCard>(context).fetchKnownWordsData();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Known words:",
                style: TextStyle(color: Colors.white),
              ),
              Text(Provider.of<FlashCard>(
                context,
                listen: false,
              ).knownWords.length.toString(),style: const TextStyle(color: Colors.white),),
            ],
          ),
        ),
        body: Consumer<FlashCard>(builder: (context, flashCardProvider, child) {
          if (flashCardProvider.knownWords.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: flashCardProvider.knownWords.length,
              itemBuilder: (context, index) {
                FlashCardItem item = flashCardProvider.knownWords[index];
                return Dismissible(
                  key: Key(item.eng),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      flashCardProvider.knownWords.removeAt(index);
                    });
                    updateToUnKnown(item.eng, item.pos);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.kor} set to unkown')),
                    );
                  },
                  child: ListTile(
                    title: Text(item.kor),
                    subtitle: Text(item.eng),
                  ),
                );
              },
            );
          }
        }));
  }
}

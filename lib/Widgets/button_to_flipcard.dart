import 'package:flutter/material.dart';
import '../Screens/flash_cards_page.dart';

class ButtonToFlashCard extends StatelessWidget {
  final String buttonName;
  final String pageTitle;
  final String pos;
  final List<String> category;

  const ButtonToFlashCard({
    super.key,
    required this.buttonName,
    required this.pos,
    required this.pageTitle,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(FlashCardsPage.routeName, arguments: {
          "title": pageTitle,
          "pos": pos,
          "category": category,
        });
      },
      child: Text(buttonName,textAlign: TextAlign.center,),
    );
  }
}

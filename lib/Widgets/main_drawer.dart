import 'package:flutter/material.dart';

import './button_to_flipcard.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 33, 72, 58),
              alignment: Alignment.bottomCenter,
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  "Categories",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          const Flexible(
              flex: 9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Nouns(),
                    SizedBox(
                      height: 10,
                    ),
                    Verbs(),
                    SizedBox(
                      height: 10,
                    ),
                    Adjectives(),
                    SizedBox(
                      height: 10,
                    ),
                    Adverbs(),
                    SizedBox(
                      height: 10,
                    ),
                    Numerals(),
                    SizedBox(
                      height: 10,
                    ),
                    Miscellaneous(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class Miscellaneous extends StatelessWidget {
  const Miscellaneous({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Miscellaneous",
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 20),
      ),
      children: const [
        ButtonToFlashCard(
            buttonName: "All",
            pos: "Pos.others",
            pageTitle: "Miscellaneous",
            category: []),
        ButtonToFlashCard(
            buttonName: "Basic Directions",
            pos: "Pos.others",
            pageTitle: "Miscellaneous",
            category: ["Basic Directions"]),
        ButtonToFlashCard(
            buttonName: "Location and Position",
            pos: "Pos.others",
            pageTitle: "Miscellaneous",
            category: ["Location and Position"]),
        ButtonToFlashCard(
            buttonName: "Basic Korean Greetings and Courtesies",
            pos: "Pos.others",
            pageTitle: "Miscellaneous",
            category: ["Basic Korean Greetings and Courtesies"]),
        ButtonToFlashCard(
            buttonName: "Basic Phrases",
            pos: "Pos.others",
            pageTitle: "Miscellaneous",
            category: ["Basic Phrases"]),
      ],
    );
  }
}

class Numerals extends StatelessWidget {
  const Numerals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Numerals",
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 20),
      ),
      children: const [
        ButtonToFlashCard(
            buttonName: "All",
            pos: "Pos.num",
            pageTitle: "Numerals",
            category: []),
        ButtonToFlashCard(
            buttonName: "Sino numbers",
            pos: "Pos.num",
            pageTitle: "Numerals",
            category: ["Sino"]),
        ButtonToFlashCard(
            buttonName: "Korean numbers",
            pos: "Pos.num",
            pageTitle: "Numerals",
            category: ["Korean"]),
        ButtonToFlashCard(
            buttonName: "Counters",
            pos: "Pos.num",
            pageTitle: "Numerals",
            category: ["Counters"]),
      ],
    );
  }
}

class Adverbs extends StatelessWidget {
  const Adverbs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Adverbs",
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 20),
      ),
      children: const [
        ButtonToFlashCard(
            buttonName: "All",
            pos: "Pos.adv",
            pageTitle: "Adverbs",
            category: ["Others"]),
      ],
    );
  }
}

class Adjectives extends StatelessWidget {
  const Adjectives({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Adjectives",
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 20),
      ),
      children: const [
        ButtonToFlashCard(
            buttonName: "All",
            pos: "Pos.adj",
            pageTitle: "Adjectives",
            category: []),
        ButtonToFlashCard(
            buttonName: "About a Person’s Trait or State",
            pos: "Pos.adj",
            pageTitle: "Adjectives",
            category: ["About a Person’s Trait or State"]),
        ButtonToFlashCard(
            buttonName: "Looks & Appearance",
            pos: "Pos.adj",
            pageTitle: "Adjectives",
            category: ["Looks & Appearance"]),
        ButtonToFlashCard(
            buttonName: "Weather",
            pos: "Pos.adj",
            pageTitle: "Adjectives",
            category: ["Weather"]),
        ButtonToFlashCard(
            buttonName: "Emotions",
            pos: "Pos.adj",
            pageTitle: "Adjectives",
            category: ["Emotion"]),
        ButtonToFlashCard(
            buttonName: "Taste",
            pos: "Pos.adj",
            pageTitle: "Adjectives",
            category: ["Taste"]),
        ButtonToFlashCard(
            buttonName: "Others",
            pos: "Pos.adj",
            pageTitle: "Adjectives",
            category: ["Others"]),
      ],
    );
  }
}

class Verbs extends StatelessWidget {
  const Verbs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Verbs",
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 20),
      ),
      children: const [
        ButtonToFlashCard(
          buttonName: "All",
          pos: "Pos.verb",
          pageTitle: "Verbs",
          category: [],
        ),
        ButtonToFlashCard(
          buttonName: "Movement Verbs",
          pos: "Pos.verb",
          pageTitle: "Verbs",
          category: ["Movement Verbs"],
        ),
        ButtonToFlashCard(
          buttonName: "Action Verbs for daily routines",
          pos: "Pos.verb",
          pageTitle: "Verbs",
          category: ["Action Verbs for daily routines"],
        ),
        ButtonToFlashCard(
          buttonName: "Action Verbs for classroom",
          pos: "Pos.verb",
          pageTitle: "Verbs",
          category: ["Action Verbs for classroom"],
        ),
        ButtonToFlashCard(
          buttonName: "Action Verbs for activities",
          pos: "Pos.verb",
          pageTitle: "Verbs",
          category: ["Action Verbs for activities"],
        ),
        ButtonToFlashCard(
          buttonName: "Verbs for emotions & relationships",
          pos: "Pos.verb",
          pageTitle: "Verbs",
          category: ["Verbs for emotion & relationships"],
        ),
      ],
    );
  }
}

class Nouns extends StatelessWidget {
  const Nouns({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Nouns",
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 20),
      ),
      children: const [
        ButtonToFlashCard(
          buttonName: "All",
          pos: "Pos.noun",
          pageTitle: "Nouns",
          category: [],
        ),
        ButtonToFlashCard(
          buttonName: "Persons",
          pos: "Pos.noun",
          pageTitle: "Nouns",
          category: ["Persons"],
        ),
        ButtonToFlashCard(
          buttonName: "Countries",
          pos: "Pos.noun",
          pageTitle: "Nouns",
          category: ["Countries"],
        ),
        ButtonToFlashCard(
          buttonName: "Places",
          pos: "Pos.noun",
          pageTitle: "Nouns",
          category: ["Places"],
        ),
        ButtonToFlashCard(
          buttonName: "Transportation",
          pos: "Pos.noun",
          pageTitle: "Nouns",
          category: ["Transportation"],
        ),
        ButtonToFlashCard(
          buttonName: "Face, Body, Clothing",
          pos: "Pos.noun",
          pageTitle: "Nouns",
          category: ["Face, Body, Clothing"],
        ),
        ButtonToFlashCard(
          buttonName: "Studying",
          pos: "Pos.noun",
          pageTitle: "Nouns",
          category: ["Studying"],
        ),
        ButtonToFlashCard(
          buttonName: "Days",
          pos: "Pos.noun",
          pageTitle: "Nouns",
          category: ["Days"],
        ),
        ButtonToFlashCard(
          buttonName: "Others",
          pos: "Pos.noun",
          pageTitle: "Nouns",
          category: ["Others"],
        ),
      ],
    );
  }
}

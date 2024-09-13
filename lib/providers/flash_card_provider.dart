// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import '../services/mongoservice.dart';
import '../toUpdate/flascardstoupdate.dart';

class FlashCardItem {
  final String eng;
  final String kor;
  final String pos;
  final List<String> category;
  final bool known;

  FlashCardItem(
      {required this.eng,
      required this.kor,
      required this.pos,
      this.category = const [],
      this.known = false});
}

class FlashCard with ChangeNotifier {
  List<FlashCardItem> words = [];
  List<FlashCardItem> filteredWords = [];
  List<FlashCardItem> knownWords = [];

  FlashCardItem getFilteredWords(int index, String pos, List<String> category,
      [bool needsToFilter = false]) {
    print([...category]);
    if (needsToFilter) {
      filteredWords = [
        ...words.where((element) {
          return element.pos == pos &&
              element.known == false &&
              category.every((cat) => element.category.contains(cat));
        })
      ];
    }

    if (filteredWords.isEmpty) {
      return FlashCardItem(eng: "", kor: "", pos: pos);
    }

    return index != -1
        ? [...filteredWords][index % filteredWords.length]
        : [...filteredWords][Random().nextInt(filteredWords.length)];
  }

  final MongoDBService _mongoDBService = MongoDBService();
  Future<void> fetchData() async {
    words.clear();
    await _mongoDBService.connect();
    final data = await _mongoDBService.fetchData();
    print("API CALLED");

    for (var element in data) {
      words.add(FlashCardItem(
        eng: element['eng'],
        kor: element['kor'],
        pos: element['pos'],
        category: (element['category'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        known: element['known'],
      ));
    }

    notifyListeners();
    await _mongoDBService.close();
  }

  Future<void> fetchKnownWordsData() async {
    knownWords.clear();
    await _mongoDBService.connect();
    final data = await _mongoDBService.fetchKnownData();
    print("API CALLED KNOWN");

    for (var element in data) {
      knownWords.add(FlashCardItem(
        eng: element['eng'],
        kor: element['kor'],
        pos: element['pos'],
        category: (element['category'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        known: element['known'],
      ));
    }

    notifyListeners();
    await _mongoDBService.close();
  }

  get filteredWordsCount {
    return filteredWords.length;
  }

  Future<void> updateToKnown(String eng, String pos, bool bool) async {
    words.removeWhere((element) => element.eng == eng);
    await _mongoDBService.connect();
    try {
      await _mongoDBService.updateWord(eng, pos, bool);
    } catch (e) {
      print(e);
    }

    notifyListeners();
    await _mongoDBService.close();
  }

  Future<void> insert() async {
    await _mongoDBService.connect();
    try {
      for (var item in listToUpload) {
        await _mongoDBService.updateOneDocument(item);
      }
    } catch (e) {
      print(e);
    }
    await _mongoDBService.close();
  }
}
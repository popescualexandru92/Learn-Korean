// ignore_for_file: constant_identifier_names, avoid_print

import 'package:mongo_dart/mongo_dart.dart';
import '../constants/constants.dart' as consts;
import '../providers/flash_card_provider.dart';

class MongoDBService {
  static const String MONGO_URL = consts.MONGO_URL;
  static const String COLLECTION_NAME = consts.COLLECTION_NAME;

  late Db _db;
  late DbCollection _collection;

  Future<void> connect() async {
    _db = await Db.create(MONGO_URL);

    await _db.open();

    _collection = _db.collection(COLLECTION_NAME);
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final data = await _collection.find().toList();
      print("Retrieved ${data.length} documents from the collection");
      return data;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchKnownData() async {
    try {
      final data = await _collection.find({"known": true}).toList();
      print("Retrieved ${data.length} documents from the collection");
      return data;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

 

  Future<void> close() async {
    await _db.close();
  }

  Future<void> updateOneDocument(FlashCardItem item) async {
    try {
      await _collection.insertOne({
        "eng": item.eng,
        "kor": item.kor,
        "pos": item.pos.toString(),
        "category": item.category,
        "known": false,
      }).then((value) {
        print(value.toString());
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateWord(String eng, String pos, bool bool) async {
    try {
      await _collection.updateOne(
        where.eq('eng', eng).eq('pos', pos),
        modify.set('known', bool),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}

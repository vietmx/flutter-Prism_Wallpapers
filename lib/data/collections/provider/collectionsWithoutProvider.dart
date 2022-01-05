import 'package:Prism/logger/logger.dart';
import 'package:Prism/routes/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore databaseReference = FirebaseFirestore.instance;
List? collections;
List<QueryDocumentSnapshot>? anyCollectionWalls;
String? currentCollectionName;

Future<List?> getCollections() async {
  if (navStack.last == "Home") {
    logger.d("Fetching collections!");
    collections = [];
    await databaseReference
        .collection("collections")
        .orderBy("lastEditTime", descending: true)
        .get()
        .then((value) {
      for (final doc in value.docs) {
        collections!.add(doc.data());
      }
    }).catchError((e) {
      logger.d(e.toString());
      logger.d("data done with error");
    });
  } else {
    logger.d("Refresh blocked");
  }
  return collections;
}

Future<bool> getCollectionWithName(String name) async {
  logger.d("Fetching $name collection's first 24 walls");
  currentCollectionName = name;
  anyCollectionWalls = [];
  await databaseReference
      .collection("walls")
      .where('review', isEqualTo: true)
      .where('collections', arrayContains: name)
      .orderBy("createdAt", descending: true)
      .limit(24)
      .get()
      .then((value) {
    anyCollectionWalls = value.docs;
  });
  return true;
}

Future<bool> seeMoreCollectionWithName() async {
  logger.d("Fetching $currentCollectionName collection's more walls");
  await databaseReference
      .collection("walls")
      .where('review', isEqualTo: true)
      .where('collections', arrayContains: currentCollectionName)
      .orderBy("createdAt", descending: true)
      .startAfterDocument(anyCollectionWalls![anyCollectionWalls!.length - 1])
      .limit(24)
      .get()
      .then((value) {
    for (final doc in value.docs) {
      anyCollectionWalls!.add(doc);
    }
  });
  return true;
}

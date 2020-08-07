import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../AppHelper.dart';

class DetailViewModel extends ChangeNotifier {
  String title = 'COMPLETED';
  List items = new List();
  Map<String, List<dynamic>> tags = new Map<String, List<dynamic>>();

  final Firestore db = Firestore.instance;

  void initialise(String title) {
    Query query = db.collection(title);
    items.clear();
    // Map the documents to the data payload
    Stream slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
    slides.listen((snap) {
      items = snap.toList();
      notifyListeners();
    });

    query = db.collection(title + "_tags");
    tags.clear();
    // Map the documents to the data payload
    Stream tagsStream = query.snapshots().map((list) => list.documents);
    tagsStream.listen((snap) {
      for (int i = 0; i < snap.length; i++) {
        tags.putIfAbsent(snap[i].documentID, () => null);
        tags[snap[i].documentID] = snap[i].data.keys.toList();
        ;
      }
      notifyListeners();
    });
  }

  void applyFilter(String title, List<String> tags) {
    List slideList = new List();
    Query query = tags.length > 0
        ? db
            .collection(title.toLowerCase())
            .where('tags', arrayContainsAny: tags)
        : db.collection(title.toLowerCase());
    Stream slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
    slides.listen((snap) {
      items = new List();
      slideList = snap.toList();
      for (int i = 0; i < slideList.length; i++) {
        if (compareArrays(slideList[i]['tags'],tags.toList())) {
          items.add(slideList[i]);
        }
      }

      notifyListeners();
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String title = 'COMPLETED';

  List<String> collections = new List();
  Map<String, List<dynamic>> items = new Map<String, List<dynamic>>();

  final Firestore db = Firestore.instance;


  void initialise() {
    Query collection = db.collection('collection');

    collections.clear();

    Stream collectionSlides = collection.snapshots().map((list) =>
    list.documents);
    collectionSlides.listen((snap) {
      for (int i = 0; i < snap.length; i++) {
        collections.add(snap[i].documentID);
      }

      for (int i = 0; i < collections.length; i++) {
        Query query = db.collection(collections[i].toLowerCase());


        Stream slides = query
            .snapshots()
            .map((list) => list.documents.map((doc) => doc.data));
        slides.listen((snap) {

          List data = snap.toList();
          
          items.putIfAbsent(collections[i], () => null);
          items[collections[i]] = data;


          notifyListeners();
        });

      }

    });




//    query = db.collection('exercises');
//    exercises.clear();
//    // Map the documents to the data payload
//    Stream exercisesStreams = query
//        .snapshots()
//        .map((list) => list.documents.map((doc) => doc.data));
//    exercisesStreams.listen((snap) {
//      exercises = snap.toList();
//      notifyListeners();
//    });
//
//    query = db.collection('nutrition');
//    nutrition.clear();
//    // Map the documents to the data payload
//   Stream nutritionStream = query
//        .snapshots()
//        .map((list) => list.documents.map((doc) => doc.data));
//    nutritionStream.listen((snap) {
//      nutrition = snap.toList();
//      notifyListeners();
//    });
//
//
//    query = db.collection('equipment');
//    equipment.clear();
//    // Map the documents to the data payload
//    Stream equipmentStream = query
//        .snapshots()
//        .map((list) => list.documents.map((doc) => doc.data));
//    equipmentStream.listen((snap) {
//      equipment = snap.toList();
//      notifyListeners();
//    });
//
//
//    query = db.collection('newsarticles');
//    articles.clear();
//    // Map the documents to the data payload
//    Stream articlesStream = query
//        .snapshots()
//        .map((list) => list.documents.map((doc) => doc.data));
//    articlesStream.listen((snap) {
//      articles = snap.toList();
//      notifyListeners();
//    });
  }


}
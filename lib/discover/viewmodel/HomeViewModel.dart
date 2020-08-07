import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String title = 'COMPLETED';
  List workouts = new List();
  List exercises = new List();
  List nutrition = new List();
  List equipment = new List();
  List articles = new List();

  final Firestore db = Firestore.instance;


  void initialise() {

    Query query = db.collection('workouts');
    workouts.clear();
    // Map the documents to the data payload
    Stream slides = query
        .snapshots()
        .map((list) => list.documents.map((doc) => doc.data));
    slides.listen((snap) {
      workouts = snap.toList();
      notifyListeners();
  });

    query = db.collection('exercises');
    exercises.clear();
    // Map the documents to the data payload
    Stream exercisesStreams = query
        .snapshots()
        .map((list) => list.documents.map((doc) => doc.data));
    exercisesStreams.listen((snap) {
      exercises = snap.toList();
      notifyListeners();
    });

    query = db.collection('nutrition');
    nutrition.clear();
    // Map the documents to the data payload
   Stream nutritionStream = query
        .snapshots()
        .map((list) => list.documents.map((doc) => doc.data));
    nutritionStream.listen((snap) {
      nutrition = snap.toList();
      notifyListeners();
    });


    query = db.collection('equipment');
    equipment.clear();
    // Map the documents to the data payload
    Stream equipmentStream = query
        .snapshots()
        .map((list) => list.documents.map((doc) => doc.data));
    equipmentStream.listen((snap) {
      equipment = snap.toList();
      notifyListeners();
    });


    query = db.collection('newsarticles');
    articles.clear();
    // Map the documents to the data payload
    Stream articlesStream = query
        .snapshots()
        .map((list) => list.documents.map((doc) => doc.data));
    articlesStream.listen((snap) {
      articles = snap.toList();
      notifyListeners();
    });
  }


}
import 'package:cloud_firestore/cloud_firestore.dart';

class GamesModel {
  String name;
  String image;
  String description;
  int followers;
  GamesModel({
    required this.name,
    required this.image,
    required this.description,
    required this.followers,
  });

  factory GamesModel.fromJsom(DocumentSnapshot snapshot) {
    return GamesModel(
        name: snapshot['name'],
        image: snapshot['image'],
        description: snapshot['description'],
        followers: snapshot['followers']);
  }
}

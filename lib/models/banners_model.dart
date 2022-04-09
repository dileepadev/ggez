import 'package:cloud_firestore/cloud_firestore.dart';

class BannersModel {
  String title;
  String image;
  String body;
  String description;

  BannersModel({
    required this.title,
    required this.image,
    required this.body,
    required this.description,
  });

  factory BannersModel.fromJsom(DocumentSnapshot snapshot) {
    return BannersModel(
        title: snapshot['title'],
        image: snapshot['image'],
        body: snapshot['body'],
        description: snapshot['description']);
  }
}

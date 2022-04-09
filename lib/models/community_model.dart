import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityModel {
  String id;
  String name;
  String image;
  String category;
  int followers;
  CommunityModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.followers,
  });

  factory CommunityModel.fromJsom(DocumentSnapshot snapshot) {
    return CommunityModel(
        id: snapshot['id'],
        name: snapshot['name'],
        image: snapshot['image'],
        category: snapshot['category'],
        followers: snapshot['followers']);
  }
}

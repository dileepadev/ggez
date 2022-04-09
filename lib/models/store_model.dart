import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String id;
  String name;
  String image;
  String type;
  int priceLKR;

  StoreModel({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.priceLKR,
  });

  factory StoreModel.fromJsom(DocumentSnapshot snapshot) {
    return StoreModel(
        id: snapshot['id'],
        name: snapshot['name'],
        image: snapshot['image'],
        type: snapshot['type'],
        priceLKR: snapshot['priceLKR']);
  }
}

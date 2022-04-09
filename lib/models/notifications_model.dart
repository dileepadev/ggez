import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsModel {
  String id;
  String title;
  String description;
  String image;
  String date;

  NotificationsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
  });

  factory NotificationsModel.fromJsom(DocumentSnapshot snapshot) {
    return NotificationsModel(
        id: snapshot['id'],
        title: snapshot['title'],
        description: snapshot['description'],
        image: snapshot['image'],
        date: snapshot['date']);
  }
}

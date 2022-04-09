import 'package:cloud_firestore/cloud_firestore.dart';

class EventsModel {
  String id;
  String name;
  String image;
  String location;
  String time;
  String date;
  String description;

  EventsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.time,
    required this.date,
    required this.description,
  });

  factory EventsModel.fromJsom(DocumentSnapshot snapshot) {
    return EventsModel(
        id: snapshot['id'],
        name: snapshot['name'],
        image: snapshot['image'],
        location: snapshot['location'],
        time: snapshot['time'],
        date: snapshot['date'],
        description: snapshot['description']);
  }
}
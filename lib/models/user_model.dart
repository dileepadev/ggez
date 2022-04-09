import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uuid;
  String accountType;
  String name;
  String email;
  String ggezId;
  String contactNumber;
  String address;
  String password;
  String lastAppeared;
  double coins;
  bool verified;
  String accountCreated;
  String profileImage;
  String about;

  UserModel({
    required this.uuid,
    required this.accountType,
    required this.name,
    required this.email,
    required this.ggezId,
    required this.contactNumber,
    required this.address,
    required this.password,
    required this.lastAppeared,
    required this.coins,
    required this.verified,
    required this.accountCreated,
    required this.profileImage,
    required this.about,
  });

  factory UserModel.fromJsom(DocumentSnapshot snapshot) {
    return UserModel(
      uuid: snapshot.id,
      accountType: snapshot['accountType'],
      name: snapshot['name'],
      email: snapshot['email'],
      ggezId: snapshot['ggezId'],
      contactNumber: snapshot['contactNumber'],
      address: snapshot['address'],
      password: snapshot['password'],
      lastAppeared: snapshot['lastAppeared'],
      coins: snapshot['coins'],
      verified: snapshot['verified'],
      accountCreated: snapshot['accountCreated'],
      profileImage: snapshot['profileImage'],
      about: snapshot['about'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserFollowingModel {
  String followCategory;
  String followID;
  String followName;
  String followType;
  String startToFollowDate;
  String uuid;

  UserFollowingModel({
    required this.followCategory,
    required this.followID,
    required this.followName,
    required this.followType,
    required this.startToFollowDate,
    required this.uuid,
  });

  factory UserFollowingModel.fromJsom(DocumentSnapshot snapshot) {
    return UserFollowingModel(
        followCategory: snapshot['followCategory'],
        followID: snapshot['followID'],
        followName: snapshot['followName'],
        followType: snapshot['followType'],
        startToFollowDate: snapshot['startToFollowDate'],
        uuid: snapshot['uuid']);
  }
}

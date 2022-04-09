import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ggez/models/community_model.dart';

import '../../theme/widgets/cw_circular_progress_indicator.dart';

class FindFollowingByID extends StatefulWidget {
  const FindFollowingByID({Key? key, required this.followingID})
      : super(key: key);

  final String followingID;

  @override
  _FindFollowingByIDState createState() => _FindFollowingByIDState();
}

class _FindFollowingByIDState extends State<FindFollowingByID> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.blue,
      height: 150.0,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("community")
              .doc(widget.followingID)
              .collection("following")
              //.where('followID', isEqualTo: 'RfzRU5y3frv3V4lIGGzx')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CWCircularProgressIndicator());
            }
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    //shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      CommunityModel communityModel =
                          CommunityModel.fromJsom(snapshot.data!.docs[index]);
                      return Column(
                        children: [
                          Text(communityModel.name),
                        ],
                      );
                    });
              }
            }
            return const Center(child: CWCircularProgressIndicator());
          }),
    );
  }
}

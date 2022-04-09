import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ggez/models/banners_model.dart';
import 'package:ggez/services/page_navigation.dart';

import '../../theme/widgets/cw_card_home_banner.dart';
import '../../theme/widgets/cw_circular_progress_indicator.dart';

class GetHomeBanners extends StatefulWidget {
  const GetHomeBanners({Key? key}) : super(key: key);

  @override
  _GetHomeBannersState createState() => _GetHomeBannersState();
}

class _GetHomeBannersState extends State<GetHomeBanners> {
  final Stream<QuerySnapshot> _bannersStream =
      FirebaseFirestore.instance.collection('banners').snapshots();

  _banners() {
    return SizedBox(
      //color: Colors.blue,
      height: 200.0,
      child: StreamBuilder(
          stream: _bannersStream,
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
                      BannersModel bannersModel =
                          BannersModel.fromJsom(snapshot.data!.docs[index]);
                      return CWCardHomeBanner(
                          bannersModel: bannersModel,
                          onPressed: () => PageNavigation(context)
                              .goToAboutBannerPage(bannersModel));
                    });
              }
            }
            return const Center(child: CWCircularProgressIndicator());
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _banners(),
      ],
    );
  }
}

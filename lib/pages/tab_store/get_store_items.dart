import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ggez/models/store_model.dart';
import 'package:ggez/services/page_navigation.dart';

import '../../theme/widgets/cw_card_store_items.dart';
import '../../theme/widgets/cw_circular_progress_indicator.dart';

class GetStoreItems extends StatefulWidget {
  const GetStoreItems({Key? key}) : super(key: key);

  @override
  _GetStoreItemsState createState() => _GetStoreItemsState();
}

class _GetStoreItemsState extends State<GetStoreItems> {
  final Stream<QuerySnapshot> _storeStream =
      FirebaseFirestore.instance.collection('store').orderBy('type', descending: false).snapshots();

  _storeItems() {
    return SizedBox(
      //color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
          stream: _storeStream,
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
                return GridView.count(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 2),
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    StoreModel storeModel =
                        StoreModel.fromJsom(snapshot.data!.docs[index]);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CWCardStoreItems(
                          name: storeModel.name,
                          image: storeModel.image,
                          priceLKR: storeModel.priceLKR,
                          onPressed: () =>
                              PageNavigation(context).goToAboutStoreItemPage(storeModel)),
                    );
                  }),
                );
              }
            }
            return const Center(child: CWCircularProgressIndicator());
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _storeItems();
  }
}

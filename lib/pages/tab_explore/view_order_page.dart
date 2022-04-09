import 'package:flutter/material.dart';
import 'package:ggez/models/order_model.dart';

import '../../models/store_model.dart';
import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_message_popups.dart';
import '../../theme/widgets/cw_text.dart';

class ViewOrderPage extends StatefulWidget {
  const ViewOrderPage(
      {Key? key,
        required this.orderModel,
        required this.storeModel})
      : super(key: key);

  final OrderModel orderModel;
  final StoreModel storeModel;

  @override
  _ViewOrderPageState createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  String errorMessage = 'No error';
  bool isLoading = false;

  // This paymentStatus is for future use
  String? paymentStatus;

  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    // _data.clear();
    // _data.addAll(generateWordPairs().take(20));
    //
    // setState(() {});
    CWMessagePopups(message: 'Payment page refreshed').cwSnackbar(context);
    debugPrint(
        "////////////// ----------- REFRESH PAGE ----------- //////////////");
  }

  Chip _itemChip(String label, String avatar) {
    return Chip(
      label: Text(label,
          style: const TextStyle(color: AppThemeData.appColorWhite)),
      avatar: Image.asset(
        avatar,
        height: 16.0,
        width: 16.0,
      ),
      elevation: 10,
      padding: const EdgeInsets.all(8),
      shadowColor: AppThemeData.appColorDarkGrey,
      backgroundColor: AppThemeData.appColorDarkGrey,
    );
  }

  Widget _itemDetailsRight() {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CWText(
              textName: widget.storeModel.name,
              textStyle: 'subtitle2SemiBold',
              textColor: AppThemeData.appColorWhite),
          CWText(
              textName: "LKR ${widget.storeModel.priceLKR}",
              textStyle: 'subtitle2',
              textColor: AppThemeData.appColorWhite),
          Row(
            children: [
              _itemChip(
                  widget.orderModel.itemSize, 'assets/icons/icons8_t-shirt_28px.png'),
              const SizedBox(
                width: 5.0,
              ),
              _itemChip(widget.orderModel.itemQuantity.toString(),
                  'assets/icons/icons8_multiply_28px.png'),
            ],
          ),
          Container(
              decoration: const BoxDecoration(
                  color: AppThemeData.appColorRed,
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppThemeData.appCornerRadius))),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                child: CWText(
                    textName:
                    "Total LKR ${widget.storeModel.priceLKR * widget.orderModel.itemQuantity}/=",
                    textStyle: "body1SemiBold",
                    textColor: AppThemeData.appColorWhite),
              ))
        ],
      ),
    );
  }

  Widget _itemDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
          child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                widget.storeModel.image,
                fit: BoxFit.cover,
              )),
        ),
        const SizedBox(
          width: 5.0,
        ),
        _itemDetailsRight()
      ],
    );
  }

  Widget _contactDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CWText(
            textName: "First Name",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.orderModel.contactFirstName,
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Last Name",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.orderModel.contactLastName,
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Contact Email",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.orderModel.contactEmail,
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Contact Phone",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.orderModel.contactNumber,
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Contact Address",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.orderModel.contactAddress,
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Contact City",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.orderModel.contactCity,
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
      ],
    );
  }

  Widget _deliveryDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CWText(
            textName: "Delivery Address",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.orderModel.deliveryAddress,
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Delivery City",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.orderModel.deliveryCity,
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
      ],
    );
  }

  _paymentDetails(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: CWText(
              textName: "Your Shipping Details",
              textStyle: 'subtitle2SemiBold',
              textColor: AppThemeData.appColorWhite),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: const [
            Icon(Icons.phone),
            SizedBox(
              width: 10.0,
            ),
            CWText(
                textName: "Enter your Contact Details",
                textStyle: 'subtitle2SemiBold',
                textColor: AppThemeData.appColorWhite),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        _contactDetails(),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          children: const [
            Icon(Icons.location_on_rounded),
            SizedBox(
              width: 10.0,
            ),
            CWText(
                textName: "Enter your Delivery Details",
                textStyle: 'subtitle2SemiBold',
                textColor: AppThemeData.appColorWhite),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        _deliveryDetails(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CWAppBarPages(appBarName: "Order", context: context)
          .appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          color: AppThemeData.appColorRed,
          backgroundColor: AppThemeData.appColorDark,
          child: ListView(physics: const BouncingScrollPhysics(), children: [
            _itemDetails(),
            const SizedBox(
              height: 10.0,
            ),
            _paymentDetails(),
            const SizedBox(
              height: 40.0,
            ),
          ]),
        ),
      ),
    );
  }
}


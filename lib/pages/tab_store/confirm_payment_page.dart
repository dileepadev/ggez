import 'package:flutter/material.dart';
import 'package:ggez/models/store_model.dart';
import 'package:ggez/services/firebase_firestore_service.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

import '../../const/payhere_account_credentials.dart';
import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_elevatedbutton.dart';
import '../../theme/widgets/cw_message_popups.dart';
import '../../theme/widgets/cw_text.dart';

class ConfirmPaymentPage extends StatefulWidget {
  const ConfirmPaymentPage(
      {Key? key,
      required this.orderID,
      required this.sizeName,
      required this.itemCount,
      required this.storeModel,
      required this.shippingDetails})
      : super(key: key);

  final String orderID;
  final String sizeName;
  final int itemCount;
  final StoreModel storeModel;
  final List shippingDetails;

  @override
  _ConfirmPaymentPageState createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {

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
                  widget.sizeName, 'assets/icons/icons8_t-shirt_28px.png'),
              const SizedBox(
                width: 5.0,
              ),
              _itemChip(widget.itemCount.toString(),
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
                    "Total LKR ${widget.storeModel.priceLKR * widget.itemCount}/=",
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



  Map setOrderPaymentObjectOneTime(String orderId, List shippingDetails, StoreModel storeModel, int itemCount){
    Map paymentObjectOneTime = {
      // true if using Sandbox Merchant ID
      "sandbox": true,
      // Replace your Merchant ID
      "merchant_id": PayHereAccountCredentials().merchantId,
      // See step 4e
      "merchant_secret": PayHereAccountCredentials().merchantSecret,
      "notify_url": "http://sample.com/notify",
      "order_id": orderId,
      "item_number_1": "001",
      "item_name_1": storeModel.name,
      "amount_1": "${storeModel.priceLKR}",
      "quantity_1": "$itemCount",
      "items": "One Time Payment",
      //"amount": "${storeModel.priceLKR * itemCount}",
      "amount": "30",
      "currency": "LKR",
      "first_name": shippingDetails[0],
      "last_name": shippingDetails[1],
      "email": shippingDetails[2],
      "phone": shippingDetails[3],
      "address": shippingDetails[4],
      "city": shippingDetails[5],
      "country": "Sri Lanka",
      "delivery_address": shippingDetails[6],
      "delivery_city": shippingDetails[7],
      "delivery_country": "Sri Lanka",
    };

    return paymentObjectOneTime;
  }


  // --------------------------- Add order details to firestore ---------------------------
  Future _addOrderDetailsToFirestore(String paymentID) async {
    setState(() {
      isLoading = true;
      CWMessagePopups(message: "Creating your order")
          .cwAlertDialogLoading(context, isLoading, "", () {
        //Navigator.pop(context);
      }, 'assets/icons/icons8_info_50px.png');
    });

    await FirebaseFirestoreService().firebaseAddOrderDetailsToFirestore(
        widget.sizeName,
        widget.itemCount,
        widget.storeModel,
        widget.shippingDetails,
        widget.orderID,
        paymentID,
        context);
  }

  _payNowOneTimePayment(){
    PayHere.startPayment(
        setOrderPaymentObjectOneTime(widget.orderID, widget.shippingDetails,
                widget.storeModel, widget.itemCount), (paymentId) {
      //ON SUCCESS
      _addOrderDetailsToFirestore(paymentId);
      setState(() {
        debugPrint("One Time Payment Success. Payment Id: $paymentId");
        isLoading = false;
        errorMessage = "";
      });
    }, (error) {
      // ON ERROR
      setState(() {
        debugPrint("One Time Payment Failed. Error: $error");
        isLoading = false;
        errorMessage = "Failed: $error";
        CWMessagePopups(message: 'Payment Failed').cwAlertDialogLoading(
            context, false, errorMessage, () {
          Navigator.of(context).pop();
        }, 'assets/icons/icons8_high_priority_50px.png');
      });
    }, () {
      //ON DISMISSED
      debugPrint("One Time Payment Dismissed");
      isLoading = false;
      errorMessage = "Your payment is dismissed";
      CWMessagePopups(message: 'Payment Dismissed').cwAlertDialogLoading(
          context, false, errorMessage, () {
        Navigator.of(context).pop();
      }, 'assets/icons/icons8_high_priority_50px.png');
    });
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
            textName: widget.shippingDetails[0],
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Last Name",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.shippingDetails[1],
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Contact Email",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.shippingDetails[2],
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Contact Phone",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.shippingDetails[3],
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Contact Address",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.shippingDetails[4],
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Contact City",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.shippingDetails[5],
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
            textName: widget.shippingDetails[6],
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
        const CWText(
            textName: "Delivery City",
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        CWText(
            textName: widget.shippingDetails[7],
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
      appBar: CWAppBarPages(appBarName: 'Confirm Payment', context: context)
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
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CWElevatedButton(
                    buttonName: 'Pay Now',
                    onPressed: _payNowOneTimePayment,
                    // onPressed: _TESTPayment,
                    buttonBackgroundColor: AppThemeData.appColorRed),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
          ]),
        ),
      ),
    );
  }
}

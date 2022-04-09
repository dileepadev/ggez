import 'package:flutter/material.dart';
import 'package:ggez/models/store_model.dart';

import '../../const/generate_order_id.dart';
import '../../services/page_navigation.dart';
import '../../services/validation.dart';
import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_elevatedbutton.dart';
import '../../theme/widgets/cw_message_popups.dart';
import '../../theme/widgets/cw_text.dart';
import '../../theme/widgets/cw_textfield_shipping.dart';

class ShippingDetailsPage extends StatefulWidget {
  const ShippingDetailsPage(
      {Key? key,
      required this.storeModel,
      required this.sizeName,
      required this.itemCount})
      : super(key: key);

  final StoreModel storeModel;
  final String sizeName;
  final int itemCount;

  @override
  _ShippingDetailsPageState createState() => _ShippingDetailsPageState();
}

class _ShippingDetailsPageState extends State<ShippingDetailsPage> {

  final TextEditingController _firstNameEditingController =
      TextEditingController();

  final TextEditingController _lastNameEditingController =
      TextEditingController();

  final TextEditingController _contactEmailEditingController =
      TextEditingController();

  final TextEditingController _contactPhoneEditingController =
      TextEditingController();

  final TextEditingController _contactAddressEditingController =
      TextEditingController();

  final TextEditingController _contactCityEditingController =
      TextEditingController();

  final TextEditingController _deliveryAddressEditingController =
      TextEditingController();

  final TextEditingController _deliveryCityEditingController =
      TextEditingController();

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

  Widget _contactDetailsForm() {
    return Column(
      children: [
        CWTextFieldShipping(
            labelText: 'First Name',
            hintText: 'Enter your first name',
            icon: Icons.person_rounded,
            textEditingController: _firstNameEditingController,
            keyboardType: TextInputType.text),
        CWTextFieldShipping(
            labelText: 'Last Name',
            hintText: 'Enter your last name',
            icon: Icons.person_rounded,
            textEditingController: _lastNameEditingController,
            keyboardType: TextInputType.text),
        CWTextFieldShipping(
            labelText: 'Contact Email',
            hintText: 'Enter your contact email',
            icon: Icons.email_rounded,
            textEditingController: _contactEmailEditingController,
            keyboardType: TextInputType.text),
        CWTextFieldShipping(
            labelText: 'Contact Phone',
            hintText: 'Enter your contact phone',
            icon: Icons.phone_android_rounded,
            textEditingController: _contactPhoneEditingController,
            keyboardType: TextInputType.text),
        CWTextFieldShipping(
            labelText: 'Contact Address',
            hintText: 'Enter your contact address',
            icon: Icons.location_on_rounded,
            textEditingController: _contactAddressEditingController,
            keyboardType: TextInputType.text),
        CWTextFieldShipping(
            labelText: 'Contact City',
            hintText: 'Enter your contact city',
            icon: Icons.location_on_rounded,
            textEditingController: _contactCityEditingController,
            keyboardType: TextInputType.text),
      ],
    );
  }

  Widget _deliveryDetailsForm() {
    return Column(
      children: [
        CWTextFieldShipping(
            labelText: 'Delivery Address',
            hintText: 'Enter your delivery address',
            icon: Icons.location_on_rounded,
            textEditingController: _deliveryAddressEditingController,
            keyboardType: TextInputType.text),
        CWTextFieldShipping(
            labelText: 'Delivery City',
            hintText: 'Enter your delivery city',
            icon: Icons.location_on_rounded,
            textEditingController: _deliveryCityEditingController,
            keyboardType: TextInputType.text),
      ],
    );
  }

  _buttonContinueToPay() {
    if (Validation().isShippingDetailsOK(
        _firstNameEditingController.text,
        _lastNameEditingController.text,
        _contactEmailEditingController.text,
        _contactPhoneEditingController.text,
        _contactAddressEditingController.text,
        _contactCityEditingController.text,
        _deliveryAddressEditingController.text,
        _deliveryCityEditingController.text,
        context)) {
      debugPrint("------------------- Items Details -------------------");
      debugPrint("--- Item Id: ${widget.storeModel.id} ");
      debugPrint("--- Item Name: ${widget.storeModel.name} ");
      debugPrint("--- Item Type: ${widget.storeModel.type} ");
      debugPrint("--- Item Size: ${widget.sizeName} ");
      debugPrint("--- Item Unit Price: ${widget.storeModel.priceLKR} ");
      debugPrint("--- Item Quantity: ${widget.itemCount} ");
      debugPrint("--- Total Amount: ${widget.itemCount * widget.storeModel.priceLKR} ");

      debugPrint("------------------- Shipping Details -------------------");
      debugPrint("--- First Name: ${_firstNameEditingController.text} ");
      debugPrint("--- Last Name: ${_lastNameEditingController.text} ");
      debugPrint("--- Contact Email: ${_contactEmailEditingController.text} ");
      debugPrint("--- Contact Phone: ${_contactPhoneEditingController.text} ");
      debugPrint(
          "--- Contact Address: ${_contactAddressEditingController.text} ");
      debugPrint("--- Contact City: ${_contactCityEditingController.text} ");
      debugPrint(
          "--- Delivery Address: ${_deliveryAddressEditingController.text} ");
      debugPrint("--- Delivery City: ${_deliveryCityEditingController.text} ");

      List shippingDetails = [
        _firstNameEditingController.text,
        _lastNameEditingController.text,
        _contactEmailEditingController.text,
        _contactPhoneEditingController.text,
        _contactAddressEditingController.text,
        _contactCityEditingController.text,
        _deliveryAddressEditingController.text,
        _deliveryCityEditingController.text,
      ];

      PageNavigation(context).goToConfirmPaymentPage(
          widget.sizeName,
          widget.itemCount,
          widget.storeModel,
          shippingDetails,
          GenerateOrderId().ggezOrderId());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CWAppBarPages(appBarName: 'Shopping Details', context: context)
          .appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: RefreshIndicator(
            onRefresh: _refreshData,
            color: AppThemeData.appColorRed,
            backgroundColor: AppThemeData.appColorDark,
            child: ListView(physics: const BouncingScrollPhysics(), children: [
              _itemDetails(),
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
              _contactDetailsForm(),
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
              _deliveryDetailsForm(),
              const SizedBox(
                height: 40.0,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CWElevatedButton(
                      buttonName: 'Continue to Pay',
                      onPressed: _buttonContinueToPay,
                      buttonBackgroundColor: AppThemeData.appColorRed),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ggez/const/string_notes.dart';
import 'package:ggez/services/page_navigation.dart';
import 'package:ggez/services/validation.dart';
import 'package:ggez/theme/app_theme.dart';
import 'package:ggez/theme/widgets/cw_appbar.dart';
import 'package:ggez/theme/widgets/cw_elevatedbutton.dart';
import 'package:ggez/theme/widgets/cw_text.dart';

import '../../models/store_model.dart';
import '../../theme/widgets/cw_message_popups.dart';

class AboutStoreItem extends StatefulWidget {
  const AboutStoreItem({Key? key, required this.storeModel}) : super(key: key);

  final StoreModel storeModel;

  @override
  _AboutStoreItemState createState() => _AboutStoreItemState();
}

class _AboutStoreItemState extends State<AboutStoreItem> {
  int? _selectedSize;
  final List<String> _options = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
  String sizeName = "Not Selected";

  int _itemCount = 0;

  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    // _data.clear();
    // _data.addAll(generateWordPairs().take(20));
    //
    // setState(() {});
    CWMessagePopups(message: 'Item page refreshed').cwSnackbar(context);
    debugPrint(
        "////////////// ----------- REFRESH PAGE ----------- //////////////");
  }

  // ----------------------------------- IMAGE ----------------------------------- \\
  Widget _itemImage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.1,
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
    );
  }

  // ----------------------------------- SUMMERY ----------------------------------- \\
  Widget _itemChips() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        color: AppThemeData.appColorRed,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: CWText(
              textName: 'New Item',
              textStyle: "body2Bold",
              textColor: AppThemeData.appColorWhite),
        ),
      ),
    );
  }

  Widget itemSummery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _itemChips(),
        const SizedBox(
          height: 5.0,
        ),
        CWText(
            textName: widget.storeModel.name,
            textStyle: 'headline3SemiBold',
            textColor: AppThemeData.appColorWhite),
        const SizedBox(
          height: 5.0,
        ),
        CWText(
            textName: 'LKR ${widget.storeModel.priceLKR}',
            textStyle: 'headline5SemiBold',
            textColor: AppThemeData.appColorWhite),
      ],
    );
  }

  // ----------------------------------- FEATURES ----------------------------------- \\
  Widget _itemFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CWText(
            textName: 'Item Feature',
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        const SizedBox(
          height: 5.0,
        ),
        CWText(
            textName: StringNotes().sampleItemFeatures,
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
      ],
    );
  }

  // ----------------------------------- NOTICE ----------------------------------- \\
  Widget _itemNotice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CWText(
            textName: 'PLEASE NOTICE',
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        const SizedBox(
          height: 5.0,
        ),
        CWText(
            textName: StringNotes().shoppingNotice,
            textStyle: 'body1',
            textColor: AppThemeData.appColorWhite),
      ],
    );
  }

  // ----------------------------------- SELECTION ----------------------------------- \\

  Widget _sizeSelectChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip sizeChoiceChips = ChoiceChip(
        selected: _selectedSize == i,
        label: Text(_options[i],
            style: const TextStyle(color: AppThemeData.appColorWhite)),
        avatar: Image.asset(
          'assets/icons/icons8_t-shirt_28px.png',
          height: 16.0,
          width: 16.0,
        ),
        elevation: 10,
        pressElevation: 5,
        shadowColor: AppThemeData.appColorDarkGrey,
        backgroundColor: AppThemeData.appColorDarkGrey,
        selectedColor: AppThemeData.appColorRed,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedSize = i;
              sizeName = _options[i];
              debugPrint("Selected Size: $sizeName");
            }
          });
        },
      );
      chips.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: sizeChoiceChips,
      ));
    }
    return SizedBox(
      height: 40.0,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: chips,
      ),
    );
  }

  Widget _itemCounter() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            _itemCount != 0
                ? IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => setState(() => _itemCount--),
                  )
                : const IconButton(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      Icons.remove,
                      color: AppThemeData.appColorRed,
                    ),
                    onPressed: null,
                  ),
            CWText(
                textName: _itemCount.toString(),
                textStyle: 'subtitle2',
                textColor: AppThemeData.appColorWhite),
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() => _itemCount++))
          ],
        ),
        Row(
          children: [
            const CWText(
                textName: 'Total',
                textStyle: 'headline5SemiBold',
                textColor: AppThemeData.appColorWhite),
            const SizedBox(width: 10.0),
            CWText(
                textName: 'LKR ${_itemCount * widget.storeModel.priceLKR}',
                textStyle: 'headline5',
                textColor: AppThemeData.appColorWhite),
          ],
        ),
      ],
    );
  }

  Widget buyItemArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CWText(
            textName: 'What size are you looking for?',
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        const SizedBox(
          height: 5.0,
        ),
        _sizeSelectChips(),
        const SizedBox(
          height: 15.0,
        ),
        const CWText(
            textName: 'How much do you need?',
            textStyle: 'subtitle2SemiBold',
            textColor: AppThemeData.appColorWhite),
        const SizedBox(
          height: 5.0,
        ),
        _itemCounter(),
        const SizedBox(
          height: 10.0,
        ),
        _itemNotice(),
        const SizedBox(
          height: 15.0,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CWElevatedButton(
                buttonName: 'Pre Order Now',
                onPressed: _buttonPreOrder,
                buttonBackgroundColor: AppThemeData.appColorRed),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }

  // ----------------------------------- PRE ORDER ----------------------------------- \\
  _buttonPreOrder() {
    if (Validation().isSelectedItemCanProceed(
        widget.storeModel.id, sizeName, _itemCount, context)) {
      debugPrint("------------------- Pre Order Details -------------------");
      debugPrint("--- Item ID: ${widget.storeModel.id} ");
      debugPrint("--- Selected Size: $sizeName");
      debugPrint("--- Quantity: ${_itemCount.toString()}");


      PageNavigation(context).goToPaymentPage(widget.storeModel, sizeName, _itemCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CWAppBarPages(appBarName: 'About', context: context).appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: RefreshIndicator(
            onRefresh: _refreshData,
            color: AppThemeData.appColorRed,
            backgroundColor: AppThemeData.appColorDark,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _itemImage(),
                const SizedBox(
                  height: 10.0,
                ),
                itemSummery(),
                const SizedBox(
                  height: 10.0,
                ),
                _itemFeatures(),
                const SizedBox(
                  height: 5.0,
                ),
                buyItemArea()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

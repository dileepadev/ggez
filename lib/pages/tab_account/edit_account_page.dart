import 'package:flutter/material.dart';
import 'package:ggez/models/user_model.dart';
import 'package:ggez/theme/widgets/cw_elevatedbutton.dart';
import 'package:ggez/theme/widgets/cw_text.dart';
import 'package:ggez/theme/widgets/cw_textfield_account.dart';
import 'package:ggez/theme/widgets/ggez_logo.dart';

import '../../services/firebase_auth_service.dart';
import '../../services/firebase_firestore_service.dart';
import '../../services/validation.dart';
import '../../theme/app_theme.dart';
import '../../theme/widgets/cw_appbar.dart';
import '../../theme/widgets/cw_circle_image.dart';
import '../../theme/widgets/cw_message_popups.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _addressEditingController =
      TextEditingController();
  final TextEditingController _contactNumberEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _aboutEditingController = TextEditingController();

  String errorMessage = 'No Error Message';
  bool isLoading = false;

  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    // _data.clear();
    // _data.addAll(generateWordPairs().take(20));
    //
    // setState(() {});
    CWMessagePopups(message: 'Edit Account page refreshed').cwSnackbar(context);
    debugPrint(
        "////////////// ----------- REFRESH PAGE ----------- //////////////");
  }

  Widget _changeProfilePicture() {
    return Column(
      children: [
        Center(
          child: CWCircleImage(
              image: widget.userModel.profileImage,
              onPressed: () {
                debugPrint("Hello Profile");
              }),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Center(
          child: Container(
            decoration: const BoxDecoration(
                color: AppThemeData.appColorDarkGrey,
                borderRadius: BorderRadius.all(
                    Radius.circular(AppThemeData.appCornerRadius))),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              child: CWText(
                  textName: 'Change Picture',
                  textStyle: "body2SemiBold",
                  textColor: AppThemeData.appColorWhite),
            ),
          ),
        ),
      ],
    );
  }

  Widget _ggezID() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CWText(
              textName: 'Ggez ID (Editing is not allowed)',
              textStyle: 'body2SemiBold',
              textColor: AppThemeData.appColorWhite),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              const SizedBox(
                  width: 60.0,
                  child: GgezLogoImage()),
              const SizedBox(
                width: 10.0,
              ),
              const Icon(
                Icons.sports_esports_rounded,
                color: AppThemeData.appColorWhite,
              ),
              const SizedBox(
                width: 5.0,
              ),
              CWText(
                  textName: widget.userModel.ggezId.toString(),
                  textStyle: 'body1SemiBold',
                  textColor: AppThemeData.appColorWhite),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------- Update User Account ---------------------------
  Future _firebaseUpdateUserAccount() async {
    setState(() {
      isLoading = true;
      CWMessagePopups(message: "Updating account")
          .cwAlertDialogLoading(context, isLoading, "", () {
        //Navigator.pop(context);
      }, 'assets/icons/icons8_info_50px.png');
    });

    await FirebaseFirestoreService()
        .firebaseUpdateUserProfileToFirestore(
            _nameEditingController.text.toString(),
            _addressEditingController.text.toString(),
            _contactNumberEditingController.text.toString(),
        _aboutEditingController.text.toString(),
            context);
  }

  @override
  Widget build(BuildContext context) {
    void updateButton() async {
      if (Validation().isUpdateAccountValidated(context, _nameEditingController,
          _addressEditingController, _contactNumberEditingController, _aboutEditingController)) {
        debugPrint("Update Pressed!!!");
        debugPrint("Name: ${_nameEditingController.text}");
        debugPrint("About Me: ${_aboutEditingController.text}");
        debugPrint("Address: ${_addressEditingController.text}");
        debugPrint("Contact Number: ${_contactNumberEditingController.text}");

        debugPrint("------------ ... Start to Update User ------------");
        await _firebaseUpdateUserAccount();
      }
    }

    return Scaffold(
      appBar:
          CWAppBarPages(appBarName: 'Edit Account', context: context).appBar(),
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
                _changeProfilePicture(),
                CWText(
                    textName: FirebaseAuthService().isUserEmailVerified().toString(),
                    textStyle: 'body2SemiBold',
                    textColor: AppThemeData.appColorRed),
                CWTextFieldAccount(
                    labelText: 'Edit Name',
                    hintText: "Enter your name",
                    initialValue: widget.userModel.name.toString(),
                    icon: Icons.person_rounded,
                    textEditingController: _nameEditingController,
                    keyboardType: TextInputType.text),
                CWTextFieldAccount(
                    labelText: 'About Me',
                    hintText: "Enter your about me",
                    initialValue: widget.userModel.about.toString(),
                    icon: Icons.person_rounded,
                    textEditingController: _aboutEditingController,
                    keyboardType: TextInputType.text),
                CWTextFieldAccount(
                    labelText: 'Edit Address',
                    hintText: "Enter your address",
                    initialValue: widget.userModel.address.toString(),
                    icon: Icons.location_on_rounded,
                    textEditingController: _addressEditingController,
                    keyboardType: TextInputType.text),
                CWTextFieldAccount(
                    labelText: 'Edit Contact Number',
                    hintText: "Enter your contact number",
                    initialValue: widget.userModel.contactNumber.toString(),
                    icon: Icons.phone_android_rounded,
                    textEditingController: _contactNumberEditingController,
                    keyboardType: TextInputType.number),
                CWTextFieldAccount(
                    labelText: 'Edit Email Address',
                    hintText: "Enter your email address",
                    initialValue: widget.userModel.email.toString(),
                    icon: Icons.email_rounded,
                    textEditingController: _emailEditingController,
                    keyboardType: TextInputType.number),
                const CWText(
                    textName: 'Email cannot edit in this beta release.',
                    textStyle: 'body2SemiBold',
                    textColor: AppThemeData.appColorRed),
                _ggezID(),
                const SizedBox(
                  height: 20.0,
                ),
                CWElevatedButton(
                    buttonName: 'Update',
                    onPressed: () => updateButton(),
                    buttonBackgroundColor: AppThemeData.appColorRed),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

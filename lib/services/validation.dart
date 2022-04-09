import 'package:flutter/material.dart';

import '../const/custom_error_messages.dart';
import '../theme/widgets/cw_message_popups.dart';

class Validation {
  static const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  bool isSignUpValidated(
      BuildContext context,
      TextEditingController _emailEditingController,
      TextEditingController _passwordEditingController,
      TextEditingController _confirmPasswordEditingController) {
    if (_emailEditingController.text.isEmpty &&
        _passwordEditingController.text.isEmpty &&
        _confirmPasswordEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorAllFill);
      CWMessagePopups(message: CustomErrorMessages.errorAllFill)
          .cwSnackbar(context);
      return false;
    } else if (_emailEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorEmailFill);
      CWMessagePopups(message: CustomErrorMessages.errorEmailFill)
          .cwSnackbar(context);
      return false;
    } else if (!regExp.hasMatch(_emailEditingController.text)) {
      debugPrint(CustomErrorMessages.errorEmailPatternFill);
      CWMessagePopups(message: CustomErrorMessages.errorEmailPatternFill)
          .cwSnackbar(context);
      return false;
    } else if (_passwordEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorPasswordFill);
      CWMessagePopups(message: CustomErrorMessages.errorPasswordFill)
          .cwSnackbar(context);
      return false;
    } else if (_passwordEditingController.text.length < 6) {
      debugPrint(CustomErrorMessages.errorPasswordLengthFill);
      CWMessagePopups(message: CustomErrorMessages.errorPasswordLengthFill)
          .cwSnackbar(context);
      return false;
    } else if (_confirmPasswordEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorConfirmPasswordFill);
      CWMessagePopups(message: CustomErrorMessages.errorConfirmPasswordFill)
          .cwSnackbar(context);
      return false;
    } else if (_passwordEditingController.text !=
        _confirmPasswordEditingController.text) {
      debugPrint(CustomErrorMessages.errorPasswordNotMatchFill);
      CWMessagePopups(message: CustomErrorMessages.errorPasswordNotMatchFill)
          .cwSnackbar(context);
      return false;
    } else {
      return true;
    }
  }

  bool isSignInValidated(
      BuildContext context,
      TextEditingController _emailEditingController,
      TextEditingController _passwordEditingController) {
    if (_emailEditingController.text.isEmpty &&
        _passwordEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorAllFill);
      CWMessagePopups(message: CustomErrorMessages.errorAllFill)
          .cwSnackbar(context);
      return false;
    } else if (_emailEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorEmailFill);
      CWMessagePopups(message: CustomErrorMessages.errorEmailFill)
          .cwSnackbar(context);
      return false;
    } else if (!regExp.hasMatch(_emailEditingController.text)) {
      debugPrint(CustomErrorMessages.errorEmailPatternFill);
      CWMessagePopups(message: CustomErrorMessages.errorEmailPatternFill)
          .cwSnackbar(context);
      return false;
    } else if (_passwordEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorPasswordFill);
      CWMessagePopups(message: CustomErrorMessages.errorPasswordFill)
          .cwSnackbar(context);
      return false;
    } else {
      return true;
    }
  }

  bool isUpdateAccountValidated(
      BuildContext context,
      TextEditingController _nameEditingController,
      TextEditingController _addressEditingController,
      _contactNumberEditingController, _aboutEditingController) {
    if (_nameEditingController.text.isEmpty &&
        _addressEditingController.text.isEmpty &&
        _contactNumberEditingController.text.isEmpty &&
        _aboutEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorAllFill);
      CWMessagePopups(message: CustomErrorMessages.errorAllFill)
          .cwSnackbar(context);
      return false;
    } else if (_nameEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorNameFill);
      CWMessagePopups(message: CustomErrorMessages.errorNameFill)
          .cwSnackbar(context);
      return false;
    }  else if (_aboutEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorAboutMeFill);
      CWMessagePopups(message: CustomErrorMessages.errorAboutMeFill)
          .cwSnackbar(context);
      return false;
    } else if (_addressEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorAddressFill);
      CWMessagePopups(message: CustomErrorMessages.errorAddressFill)
          .cwSnackbar(context);
      return false;
    } else if (_contactNumberEditingController.text.isEmpty) {
      debugPrint(CustomErrorMessages.errorContactNumberFill);
      CWMessagePopups(message: CustomErrorMessages.errorContactNumberFill)
          .cwSnackbar(context);
      return false;
    } else {
      return true;
    }
  }

  bool isSelectedItemCanProceed(
      String itemID, String itemSize, int itemQuantity, BuildContext context) {
    if (itemID.isEmpty && itemSize == "Not Selected" && itemQuantity < 1) {
      debugPrint(CustomErrorMessages.errorAllSelected);
      CWMessagePopups(message: CustomErrorMessages.errorAllSelected)
          .cwSnackbar(context);
      return false;
    } else if (itemID.isEmpty) {
      debugPrint(CustomErrorMessages.errorItemNotFound);
      CWMessagePopups(message: CustomErrorMessages.errorItemNotFound)
          .cwSnackbar(context);
      return false;
    } else if (itemSize == "Not Selected") {
      debugPrint(CustomErrorMessages.errorItemSizeNotFound);
      CWMessagePopups(message: CustomErrorMessages.errorItemSizeNotFound)
          .cwSnackbar(context);
      return false;
    } else if (itemQuantity < 1) {
      debugPrint(CustomErrorMessages.errorItemQuantity);
      CWMessagePopups(message: CustomErrorMessages.errorItemQuantity)
          .cwSnackbar(context);
      return false;
    } else {
      return true;
    }
  }

  bool isShippingDetailsOK(
      String firstName,
      String lastName,
      String contactEmail,
      String contactPhone,
      String contactAddress,
      String contactCity,
      String deliveryAddress,
      String deliverCity,
      BuildContext context) {
    if (firstName.isEmpty &&
        lastName.isEmpty &&
        contactEmail.isEmpty &&
        contactPhone.isEmpty &&
        contactAddress.isEmpty &&
        contactCity.isEmpty &&
        deliveryAddress.isEmpty &&
        deliverCity.isEmpty) {
      debugPrint(CustomErrorMessages.errorAllSForms);
      CWMessagePopups(message: CustomErrorMessages.errorAllSForms)
          .cwSnackbar(context);
      return false;
    } else if (firstName.isEmpty) {
      debugPrint(CustomErrorMessages.errorFNameForm);
      CWMessagePopups(message: CustomErrorMessages.errorFNameForm)
          .cwSnackbar(context);
      return false;
    } else if (lastName.isEmpty) {
      debugPrint(CustomErrorMessages.errorLNameForm);
      CWMessagePopups(message: CustomErrorMessages.errorLNameForm)
          .cwSnackbar(context);
      return false;
    } else if (contactEmail.isEmpty) {
      debugPrint(CustomErrorMessages.errorCEmailForm);
      CWMessagePopups(message: CustomErrorMessages.errorCEmailForm)
          .cwSnackbar(context);
      return false;
    } else if (contactPhone.isEmpty) {
      debugPrint(CustomErrorMessages.errorCPhoneForm);
      CWMessagePopups(message: CustomErrorMessages.errorCPhoneForm)
          .cwSnackbar(context);
      return false;
    } else if (contactAddress.isEmpty) {
      debugPrint(CustomErrorMessages.errorCAddressForm);
      CWMessagePopups(message: CustomErrorMessages.errorCAddressForm)
          .cwSnackbar(context);
      return false;
    } else if (contactCity.isEmpty) {
      debugPrint(CustomErrorMessages.errorCCityForm);
      CWMessagePopups(message: CustomErrorMessages.errorCCityForm)
          .cwSnackbar(context);
      return false;
    } else if (deliveryAddress.isEmpty) {
      debugPrint(CustomErrorMessages.errorDAddressForm);
      CWMessagePopups(message: CustomErrorMessages.errorDAddressForm)
          .cwSnackbar(context);
      return false;
    } else if (deliverCity.isEmpty) {
      debugPrint(CustomErrorMessages.errorDCityForm);
      CWMessagePopups(message: CustomErrorMessages.errorDCityForm)
          .cwSnackbar(context);
      return false;
    } else {
      return true;
    }
  }
}

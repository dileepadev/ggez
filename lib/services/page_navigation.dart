import 'package:flutter/material.dart';
import 'package:ggez/models/banners_model.dart';
import 'package:ggez/models/community_model.dart';
import 'package:ggez/models/events_model.dart';
import 'package:ggez/models/games_model.dart';
import 'package:ggez/models/notifications_model.dart';
import 'package:ggez/models/order_model.dart';
import 'package:ggez/models/store_model.dart';
import 'package:ggez/models/user_model.dart';
import 'package:ggez/pages/tab_account/edit_account_page.dart';
import 'package:ggez/pages/tab_explore/view_order_page.dart';
import 'package:ggez/pages/tab_home/about_community_page.dart';
import 'package:ggez/pages/tab_home/notifications_page.dart';
import 'package:ggez/pages/tab_store/about_store_item.dart';
import 'package:ggez/pages/tab_store/confirm_payment_page.dart';
import 'package:ggez/pages/tab_store/shipping_details_page.dart';

import '../pages/bottom_navigation_tab_page.dart';
import '../pages/intro_page.dart';
import '../pages/sign_in_page.dart';
import '../pages/sign_up_page.dart';
import '../pages/tab_games/about_game_page.dart';
import '../pages/tab_home/about_banner_page.dart';
import '../pages/tab_home/about_event_page.dart';
import '../pages/tab_home/about_notification_page.dart';

class PageNavigation {
  final BuildContext context;

  PageNavigation(this.context);

  void goToIntroPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const IntroPage(),
      ),
      (route) => false,
    );
  }

  void goToSignInPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const SignInPage(),
      ),
      (route) => false,
    );
  }

  void goToSignUpPage() async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const SignUpPage(),
      ),
      (route) => false,
    );
  }

  void goToBottomNavigationTabPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const BottomNavigationTabPage(),
      ),
      (route) => false,
    );
  }

  void goToAboutBannerPage(BannersModel bannersModel) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            AboutBannerPage(bannersModel: bannersModel),
      ),
      (route) => true,
    );
  }

  void goToAboutCommunityPage(CommunityModel communityModel) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            AboutCommunityPage(communityModel: communityModel),
      ),
      (route) => true,
    );
  }

  void goToAboutGamePage(GamesModel gamesModel) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            AboutGamePage(gamesModel: gamesModel),
      ),
      (route) => true,
    );
  }

  void goToAboutEventPage(EventsModel eventsModel) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            AboutEventPage(eventsModel: eventsModel),
      ),
      (route) => true,
    );
  }

  void goToAboutStoreItemPage(StoreModel storeModel) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            AboutStoreItem(storeModel: storeModel),
      ),
      (route) => true,
    );
  }

  void goToAboutNotificationPage(NotificationsModel notificationsModel) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            AboutNotificationPage(notificationsModel: notificationsModel),
      ),
      (route) => true,
    );
  }

  void goToPaymentPage(StoreModel storeModel, String sizeName, int _itemCount) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ShippingDetailsPage(
            storeModel: storeModel, sizeName: sizeName, itemCount: _itemCount),
      ),
      (route) => true,
    );
  }

  void goToConfirmPaymentPage(String sizeName, int itemCount,
      StoreModel storeModel, List shippingDetails, String orderID) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => ConfirmPaymentPage(
              orderID: orderID,
              sizeName: sizeName,
              itemCount: itemCount,
              storeModel: storeModel,
              shippingDetails: shippingDetails)),
      (route) => true,
    );
  }

  void goToNotificationPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const NotificationPage(),
      ),
      (route) => true,
    );
  }

  void goToViewOrderPage(OrderModel orderModel, StoreModel storeModel) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ViewOrderPage(orderModel: orderModel, storeModel: storeModel),
      ),
      (route) => true,
    );
  }

  void goToEditAccountPage(UserModel userModel) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            EditAccountPage(userModel: userModel),
      ),
      (route) => true,
    );
  }

  void goToLastPage() {
    Navigator.pop(context);
  }
}

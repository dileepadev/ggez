import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggez/models/user_model.dart';
import 'package:ggez/services/firebase_auth_service.dart';
import 'package:ggez/services/page_navigation.dart';
import 'package:ggez/theme/widgets/ggez_logo.dart';
import './/theme/widgets/cw_circle_image_appbar.dart';

import '../app_theme.dart';
import 'cw_text.dart';

class GetCWAppBarUserDetails {
  Widget _userIcon(String appBarName, BuildContext context) {
    Row _designRowLoaded(UserModel userModel) {
      return Row(
        children: [
          // CWText(
          //     textName: userModel.name,
          //     textStyle: 'body1SemiBold',
          //     textColor: AppThemeData.appColorWhite),
          // const SizedBox(
          //   width: 10.0,
          // ),
          appBarName != 'Notifications'
              ? appBarName == 'Account'
                  ? Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            debugPrint("Edit Account");
                            PageNavigation(context)
                                .goToEditAccountPage(userModel);
                          },
                          icon: const Icon(
                            Icons.edit_rounded,
                            size: 28.0,
                            color: AppThemeData.appColorWhite,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            debugPrint("Sign Out");
                            FirebaseAuthService().firebaseSignOut(context);
                          },
                          icon: const Icon(
                            Icons.logout_rounded,
                            size: 28.0,
                            color: AppThemeData.appColorWhite,
                          ),
                        ),
                      ],
                    )
                  : CWCircleImageAppbar(
                      image: userModel.profileImage,
                      onPressed: () {
                        debugPrint("Profile Picture");
                      })
              : Row(
                  children: const [
                    SizedBox(height: 15.0, child: GgezLogoImage()),
                    Icon(
                      Icons.notifications_rounded,
                      size: 28.0,
                      color: AppThemeData.appColorWhite,
                    ),
                  ],
                ),
          const SizedBox(
            width: 5.0,
          ),
          appBarName != 'Notifications'
              ? IconButton(
                  onPressed: () =>
                      PageNavigation(context).goToNotificationPage(),
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    size: 28.0,
                    color: AppThemeData.appColorWhite,
                  ),
                )
              : Container(),
        ],
      );
    }

    Row _designRowLoading() {
      return Row(
        children: [
          // CWText(
          //     textName: userModel.name,
          //     textStyle: 'body1SemiBold',
          //     textColor: AppThemeData.appColorWhite),
          // const SizedBox(
          //   width: 10.0,
          // ),
          Container(
              width: 28.0,
              height: 28.0,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppThemeData.appColorDark)),
          const SizedBox(
            width: 10.0,
          ),
          appBarName != 'Notifications'
              ? IconButton(
                  onPressed: () =>
                      PageNavigation(context).goToNotificationPage(),
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    size: 28.0,
                    color: AppThemeData.appColorWhite,
                  ),
                )
              : Container(),
        ],
      );
    }

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _designRowLoading();
          }
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              UserModel userModel = UserModel.fromJsom(snapshot.data!.docs[0]);
              return _designRowLoaded(userModel);
            }
          }
          return const Text('Loading');
        });
  }
}

class CWAppBarHomeTab {
  const CWAppBarHomeTab({Key? key, required this.appBarName});

  final String appBarName;

  Widget headRibbon() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              UserModel userModel = UserModel.fromJsom(snapshot.data!.docs[0]);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 15.0, child: GgezLogoImage()),
                  Row(
                    children: [
                      CWText(
                          textName: userModel.name,
                          textStyle: 'body1SemiBold',
                          textColor: AppThemeData.appColorWhite),
                      const SizedBox(
                        width: 10.0,
                      ),
                      CWCircleImageAppbar(
                          image: userModel.profileImage, onPressed: () {}),
                      const SizedBox(
                        width: 10.0,
                      ),
                      IconButton(
                        onPressed: () =>
                            PageNavigation(context).goToNotificationPage(),
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                          size: 28.0,
                          color: AppThemeData.appColorWhite,
                        ),
                      )
                    ],
                  ),
                ],
              );
            }
          }
          return const Text('Loading');
        });
  }

  PreferredSizeWidget? appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: headRibbon(),
      centerTitle: true,
      backgroundColor: AppThemeData.appColorDark,
      elevation: 0.0,
      //foregroundColor: const Color.fromRGBO(33, 33, 33, 1.0)
    );
  }
}

class CWAppBarOtherTabs {
  const CWAppBarOtherTabs(
      {Key? key,
      required this.appBarName,
      required this.iconName,
      required this.context});

  final String appBarName;
  final IconData iconName;
  final BuildContext context;

  Widget headRibbon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              iconName,
              size: 28.0,
              color: AppThemeData.appColorWhite,
            ),
            const SizedBox(
              width: 10.0,
            ),
            CWText(
                textName: appBarName,
                textStyle: "subtitle1Bold",
                textColor: AppThemeData.appColorWhite),
          ],
        ),
        GetCWAppBarUserDetails()._userIcon(appBarName, context),
      ],
    );
  }

  PreferredSizeWidget? appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: headRibbon(),
      centerTitle: true,
      backgroundColor: AppThemeData.appColorDark,
      elevation: 0.0,
      //foregroundColor: const Color.fromRGBO(33, 33, 33, 1.0)
    );
  }
}

class CWAppBarPages {
  const CWAppBarPages(
      {Key? key, required this.appBarName, required this.context});

  final String appBarName;
  final BuildContext context;

  Widget headRibbon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 20.0,
              ),
              color: AppThemeData.appColorWhite,
              onPressed: () {
                PageNavigation(context).goToLastPage();
              },
            ),
            const SizedBox(
              width: 10.0,
            ),
            CWText(
                textName: appBarName,
                textStyle: "subtitle1Bold",
                textColor: AppThemeData.appColorWhite),
          ],
        ),
        GetCWAppBarUserDetails()._userIcon(appBarName, context),
      ],
    );
  }

  Widget transparentAppBar() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20.0,
                ),
                color: AppThemeData.appColorWhite,
                onPressed: () {
                  PageNavigation(context).goToLastPage();
                },
              ),
              // const SizedBox(
              //   width: 10.0,
              // ),
              // CWText(
              //     textName: appBarName,
              //     textStyle: "subtitle1Bold",
              //     textColor: AppThemeData.appColorWhite),
            ],
          ),
          GetCWAppBarUserDetails()._userIcon(appBarName, context),
        ],
      ),
    );
  }

  PreferredSizeWidget? appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: headRibbon(),
      centerTitle: true,
      backgroundColor: AppThemeData.appColorDark,
      elevation: 0.0,
      //foregroundColor: const Color.fromRGBO(33, 33, 33, 1.0)
    );
  }
}

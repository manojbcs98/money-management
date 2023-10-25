import 'dart:core';
import 'dart:io' show Platform;

import 'package:money_management/home_screen.dart';
import 'package:money_management/project/app_pages/select_date_format.dart';
import 'package:money_management/project/app_pages/select_language.dart';
import 'package:money_management/project/auth_pages/user_account.dart';
import 'package:money_management/project/classes/alert_dialog.dart';
import 'package:money_management/project/classes/constants.dart';
import 'package:money_management/project/classes/custom_toast.dart';
import 'package:money_management/project/database_management/shared_preferences_services.dart';
import 'package:money_management/project/database_management/sqflite_services.dart';
import 'package:money_management/project/localization/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../my_page.dart';
import '../provider.dart';
import 'currency.dart';

class Other extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        primary: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            150.h,
          ),
          child: Container(
            color: blue3,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
            height: 200.h,
            child: Padding(
              padding: EdgeInsets.only(top: 30.w),
              child: Row(
                children: [
                  CircleAvatar(
                    child: CircleAvatar(
                        child: Icon(
                          FontAwesomeIcons.smileBeam,
                          color: Colors.black,
                          size: 71.sp,
                        ),
                        radius: 35.r,
                        backgroundColor: blue1),
                    radius: 40.r,
                    backgroundColor: Colors.orangeAccent,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Text(
                          'Hi' + " " + "${CurrentUserInfo.userName}",
                          style: TextStyle(fontSize: 30.sp),
                        ),
                        Text(
                          greetingMessage(),
                          style: TextStyle(fontSize: 30.sp),
                        ),
                      ],
                    ),
                  ),

                  // Spacer(),
                  // Icon(
                  //   Icons.notifications_rounded,
                  //   size: 25.sp,
                  // )
                ],
              ),
            ),
          ),
        ),
        body: ChangeNotifierProvider<OnSwitch>(
            create: (context) => OnSwitch(),
            builder: (context, widget) => Settings(providerContext: context)));
  }
}

class Settings extends StatefulWidget {
  final BuildContext providerContext;

  const Settings({required this.providerContext});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pageRoute = [
      UserAccount(),
      SelectLanguage(),
      Currency(),
    ];
    List<Widget> settingsIcons = [
      Icon(
        Icons.account_circle,
        size: 35,
        color: Colors.lightBlue,
      ),
      // Icon(
      //   Icons.settings,
      //   size: 32,
      //   color: Colors.blueGrey[800],
      // ),
      // Icon(
      //   Icons.feedback,
      //   size: 35.sp,
      //   color: Colors.black54,
      // ),
      Icon(
        Icons.language,
        size: 32.sp,
        color: Colors.lightBlue,
      ),
      Icon(
        Icons.monetization_on,
        size: 32.sp,
        color: Colors.lightBlue,
      ),
      Icon(Icons.power_settings_new_outlined,
          size: 32.sp, color: Colors.lightBlue),
      Icon(Icons.format_align_center, size: 32.sp, color: Colors.lightBlue),
      Icon(Icons.refresh, size: 32.sp, color: Colors.lightBlue),
      Icon(Icons.delete_forever, size: 32.sp, color: red),
      // Icon(Icons.lock, size: 32.sp, color: Colors.blueGrey),
      Icon(
        Icons.share,
        size: 28.sp,
        color: Colors.lightBlue,
      ),
      Icon(
        Icons.star,
        size: 32.sp,
        color: Colors.amber,
      ),
    ];
    List<String> settingsList = [
      //getTranslated(context, 'My Account')!,
      // getTranslated(context, 'General Settings')!,
      // getTranslated(context, 'Feedback')!,
      // getTranslated(context, 'Language') ?? 'Language',
      //getTranslated(context, 'Currency') ?? 'Currency',
      ('Date format') + ' (${DateFormat(sharedPrefs.dateFormat).format(now)})',
      //getTranslated(context, 'Reset All Categories') ?? 'Reset All Categories',
      'Delete All Data',
      // getTranslated(context, 'Enable Passcode') ?? 'Enable Passcode',
      'Share Friends',
      'Rate App',
      "Log out"
    ];

    return ListView.builder(
        itemCount: settingsList.length,
        itemBuilder: (context, int) {
          // void onPasscodeSwitched() {
          //   context.read<OnSwitch>().onSwitch();
          //   if (context.read<OnSwitch>().isPasscodeOn) {
          //     showDialog<void>(
          //         context: context,
          //         builder: (providerContext) =>
          //             OtherLockScreen(providerContext: this.providerContext));
          //   } else {
          //    customToast(context, 'Passcode has been disabled');
          //   }
          // }

          return GestureDetector(
            onTap: () async {
              if (int == 0) {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FormatDate()))
                    .then((value) => setState(() {}));
              } else if (int == 1) {
                await DB.deleteAll();
                customToast(context, 'All data has been deleted');
/*
                Platform.isIOS
                    ? await iosDialog(
                        context,
                        'Deleted data can not be recovered. Are you sure you want to delete all data?',
                        'Delete',
                        onDeletion)
                    : await androidDialog(
                        context,
                        'Deleted data can not be recovered. Are you sure you want to delete all data?',
                        'Delete',
                        onDeletion);*/
              }
              // else if (int == 4) {
              //   onPasscodeSwitched();
              // }
              else if (int == 2) {
                Share.share(
                    'https://apps.apple.com/us/app/mmas-money-tracker-bookkeeper/id1582638369');
              } else if (int == 3) {
                final InAppReview inAppReview = InAppReview.instance;
                await inAppReview.openStoreListing(
                  appStoreId: Platform.isIOS
                      ? '1582638369'
                      : 'com.mmas.money_assistant_2608',
                );
              } else {
                await Authentication.signOut(context: context);
                Navigator.of(context).pushReplacement(_routeToSignInScreen());
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 7.h),
                  child: SizedBox(
                    child: Center(
                        child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          '${settingsList[int]}',
                          style: TextStyle(fontSize: 18.5.sp),
                        ),
                      ),
                      leading: CircleAvatar(
                          radius: 24.r,
                          backgroundColor: Color.fromRGBO(229, 231, 234, 1),
                          child: settingsIcons[int]),
                      trailing:
                          // int == 4
                          // ? Switch(
                          //     value: context.watch<OnSwitch>().isPasscodeOn,
                          //     onChanged: (value) {
                          //       onPasscodeSwitched();
                          //     },
                          //     activeTrackColor: blue1,
                          //     activeColor: Color.fromRGBO(71, 131, 192, 1),
                          //   ) :
                          Icon(
                        Icons.arrow_forward_ios,
                        size: 20.sp,
                        color: Colors.blueGrey,
                      ),
                    )),
                  ),
                ),
                Divider(
                  indent: 78.w,
                  height: 0.1.h,
                  thickness: 0.4.h,
                  color: grey,
                ),
              ],
            ),
          );
        });
  }
}

String greetingMessage() {
  var currentTime = DateTime.now().hour;
  String message = '';
  if (currentTime < 12) {
    message = 'Good Morning';
  } else if ((currentTime >= 12) && (currentTime <= 16)) {
    message = 'Good Afternoon';
  } else if ((currentTime > 16) && (currentTime < 20)) {
    message = 'Good Evening';
  } else {
    message = 'GOod Night';
  }
  return message;
}
// class Upgrade extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: 165.h,
//           color: Color.fromRGBO(234, 234, 234, 1),
//         ),
//         Container(
//           alignment: Alignment.center,
//           height: 115.h,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   fit: BoxFit.fill, image: AssetImage('images/image13.jpg'))),
//         ),
//         Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               color: Color.fromRGBO(255, 255, 255, 1),
//               borderRadius: BorderRadius.circular(40),
//               border: Border.all(
//                 color: Colors.grey,
//                 width: 0.5.w,
//               )),
//           height: 55.h,
//           width: 260.w,
//           child: Text(
//             getTranslated(context, 'VIEW UPGRADE OPTIONS')!,
//             style: TextStyle(fontSize: 4.206, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }

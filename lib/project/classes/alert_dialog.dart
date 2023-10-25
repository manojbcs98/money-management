import 'package:money_management/project/database_management/shared_preferences_services.dart';
import 'package:money_management/project/localization/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> iosDialog(BuildContext context, String content, String action,
        Function onAction) =>
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Padding(
              padding: EdgeInsets.only(
                bottom: 8.h,
              ),
              child: Text(
                'Please Confirm',
                style: TextStyle(fontSize: 21.sp),
              ),
            ),
            content: Text(content, style: TextStyle(fontSize: 15.5.sp)),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
                  child: Text('Cancel',
                      style: TextStyle(
                          fontSize: 19.5.sp, fontWeight: FontWeight.w600)),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              ),
              CupertinoDialogAction(
                onPressed: () {
                  onAction();
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
                  child: Text(action,
                      style: TextStyle(
                          fontSize: 19.5.sp, fontWeight: FontWeight.w600)),
                ),
                isDefaultAction: true,
                isDestructiveAction: true,
              )
            ],
          );
        });

Future<void> androidDialog(BuildContext context, String content, String action,
        Function onAction) =>
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("please Confirm"),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    onAction();
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);

                    List<String> list = [
                      'parent expense item names',
                      'selectedDate'
                    ];
                    //SharedPrefs().clearAllExceptList(list);
                  },
                  child: Text(action))
            ],
          );
        });

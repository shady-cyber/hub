import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:hub/Admin/screens/Home/HomeScreenAdmin.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Common/screens/GlobalComponents/button_global.dart';
import 'package:hub/Data/provider/account_provider.dart';
import 'package:hub/Data/provider/attendance_provider.dart';
import 'package:hub/Data/provider/connection_string_provider.dart';
import 'package:hub/Employee/screens/Home/HomeScreenEmployee.dart';

class UtilsWidget extends ChangeNotifier {

  // Widget showCodeVerifyDialog({required BuildContext context, required TextEditingController CodeController}) {
  //   return Dialog(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //     ),
  //     // ignore: sized_box_for_whitespace
  //     child: SizedBox(
  //       height: 310.0,
  //       child: Column(
  //         children: [
  //           const SizedBox(
  //             height: 20.0,
  //           ),
  //           const Image(
  //             image: AssetImage('assets/images/warning.png'),
  //             width: 100,
  //             height: 100,
  //           ),
  //           const SizedBox(
  //             height: 20.0,
  //           ),
  //           Text(
  //             'Verify'.tr(),
  //             style: kTextStyle.copyWith(
  //                 fontSize: 20.0, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(
  //             height: 5.0,
  //           ),
  //           Text(
  //             'Enter Company Code'.tr(),
  //             style: kTextStyle.copyWith(
  //               fontSize: 18,
  //               color: kGreyTextColor,
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 5.0,
  //           ),
  //           AppTextField(
  //             textFieldType: TextFieldType.NAME,
  //             controller: CodeController,
  //             decoration: InputDecoration(
  //               labelText: 'Code'.tr(),
  //               labelStyle: kTextStyle,
  //               hintText: 'Enter code'.tr(),
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 20.0,
  //           ),
  //           Row(
  //             children: [
  //               ButtonGlobal(
  //                   buttontext: 'Confirm'.tr(),
  //                   buttonDecoration:
  //                   kButtonDecoration.copyWith(color: kMainColor),
  //                   loading: ,
  //                   onPressed: () {
  //                     Provider.of<ConnectStringProvider>(context, listen: false)
  //                         .getConnectionUrl(CodeController.text)
  //                         .then(
  //                           (value) => value
  //                           ? Navigator.pop(context)
  //                           : CodeController.text = "",
  //                     );
  //                   }),
  //               ButtonGlobal(
  //                 buttontext: 'Cancel'.tr(),
  //                 buttonDecoration:
  //                 kButtonDecoration.copyWith(color: kMainColor),
  //                 onPressed: () => exit(0),
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget ShowLocationPermissionAlert(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(2),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Padding(
                padding:
                EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Image.asset('assets/images/question.png'),
                        ),
                      ],
                    ),
                    Image.asset('assets/images/locationicon.png'),
                    SizedBox(
                      height: 30.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Use your location',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'To see maps for automatically tracked activities,',
                          style: TextStyle(fontSize: 13.0, color: Colors.black),
                        ),
                        Text(
                          'allow hub App to use your location all of the time.',
                          style: TextStyle(fontSize: 13.0, color: Colors.black),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          'hub App collects location data',
                          style: TextStyle(fontSize: 13.0, color: Colors.black),
                        ),
                        Text(
                          'to make sure you make attendance at the company,',
                          style: TextStyle(fontSize: 13.0, color: Colors.black),
                        ),
                        Text(
                          'According to the terms of the agreement,',
                          style: TextStyle(fontSize: 13.0, color: Colors.black),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'App will take location even when the app is closed',
                          style: TextStyle(fontSize: 13.0, color: Colors.black),
                        ),
                        Text(
                          'or not, As you approve',
                          style: TextStyle(fontSize: 13.0, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Image.asset(
                      'assets/images/maps.png',
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0.0,
                          ),
                          child: Text("DENY",
                              style: TextStyle(color: Colors.lightBlueAccent)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            // initPlatformState(context);
                          },
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0.0,
                          ),
                          child: Text("ACCEPT",
                              style: TextStyle(color: Colors.lightBlueAccent)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            initPlatformState(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  initPlatformState(BuildContext context) async {
    final detectLocation =
    await Provider.of<AccountProvider>(context, listen: false)
        .requestPermission(Permission.location);
    if (!detectLocation) {
      Navigator.pop(context);
    } else {
      await Provider.of<AccountProvider>(context, listen: false)
          .setCurrentLocation(context);
    }
  }

  Widget showDialogQrCardState(String title, String message) {
    return Consumer<AttendanceProvider>(
        builder: (context, attendanceProvider, child) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 160,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                color: Colors.white,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Wrap(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      color:
                      title == "success" ? Colors.green[400] : Colors.red[400],
                      child: Column(
                        children: <Widget>[
                          Container(height: 10),
                          Icon(Icons.verified_user, color: Colors.white, size: 80),
                          Container(height: 10),
                          title == "success"
                              ? Text("Attendance Success!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white))
                              : Text("Attendance Error!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white)),
                          Container(height: 10),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          title == "success"
                              ? Text(message,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.blueGrey))
                              : Text(message,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.blueGrey)),
                          Container(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: title == "success"
                                  ? Colors.green[500]
                                  : Colors.red[500],
                              elevation: 0,
                              padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0)),
                            ),
                            child:
                            Text("Done", style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget textFieldOTP({required bool first, last}) {
    return Consumer<AccountProvider>(
        builder: (context, accountProvider, child)
        {
          return SizedBox(
            height: 80,
            child: AspectRatio(
              aspectRatio: 0.6,
              child: TextField(
                autofocus: false,
                onChanged: (value) {
                    if (value.length == 1 && last == false) {
                      FocusScope.of(context).nextFocus();
                    }
                    if (value.isEmpty && first == false) {
                      FocusScope.of(context).previousFocus();
                    }
                    else {
                      accountProvider.codeController.add(value);
                      if (last == true) {
                        accountProvider.resultString = accountProvider.codeController.reduce((value, element) => value + element);
                        FocusScope.of(context).unfocus();
                      }
                    };
                 notifyListeners();
                },

                showCursor: false,
                readOnly: false,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: InputDecoration(
                  counter: const Offstage(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: kMainColor),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          );
        });
  }

  Widget textFieldOTP2({required bool first, last}) {
    TextEditingController _textEditingController = TextEditingController(text: '');

    return Consumer<AccountProvider>(
        builder: (context, accountProvider, child)
        {
          accountProvider.OtpValue = false;
          accountProvider.codeController.clear();
          return SizedBox(
            height: 80,
            child: AspectRatio(
              aspectRatio: 0.6,
              child: TextField(
                controller: _textEditingController,
                autofocus: false,
                showCursor: false,
                readOnly: false,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: InputDecoration(
                  counter: const Offstage(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: kMainColor),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          );
        });
  }



  Widget LanguageItemList(d, index, BuildContext context, authRepo) {
    return Column(
      children: [
        ListTile(

          leading: d == 'English'?
          Image.asset('assets/images/us.png', alignment: Alignment.center,height: 20,) :
          d == 'Arabic' ?
          Image.asset('assets/images/eg.png', alignment: Alignment.center,height: 20,) :
          Image.asset('assets/images/pk.png', alignment: Alignment.center,height: 20,),
          title: Text(d),
          onTap: () async {
            if (d == 'English') {
              context.setLocale(Locale('en'));
            } else if (d == 'Arabic') {
              context.setLocale(Locale('ar'));
            } else if (d == 'Urdu') {
              context.setLocale(Locale('ur'));
            }
            if (authRepo.isAdmin()) {
              HomeScreenAdmin().launch(context);
            } else {
              HomeScreenEmployee().launch(context);
            }
          },
        ),
        Divider(
          height: 3,
          color: Colors.grey[400],
        )
      ],
    );
  }

}
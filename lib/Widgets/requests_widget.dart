import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:hub/Admin/screens/Management/AttendanceLocationMap.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Common/screens/GlobalComponents/button_global.dart';
import 'package:hub/Common/screens/view/custom_snackbar.dart';
import 'package:hub/Data/provider/account_provider.dart';
import 'package:hub/Data/provider/attendance_provider.dart';
import 'package:hub/Data/provider/cash_provider.dart';
import 'package:hub/Data/provider/clearance_provider.dart';
import 'package:hub/Data/provider/employee_provider.dart';
import 'package:hub/Data/provider/general_req_provider.dart';
import 'package:hub/Data/provider/loan_delay_provider.dart';
import 'package:hub/Data/provider/loan_provider.dart';
import 'package:hub/Data/provider/penalty_provider.dart';

class RequestsWidget extends ChangeNotifier {

  Future<void> showSheet(BuildContext aContext, int index, int EmpCode) async {
    int return_shared = Provider.of<AccountProvider>(aContext, listen: false)
        .authRepo
        .getShared(EmpCode);

    int Config = 0;
    if (return_shared != 0) {
      Config = return_shared;
    } else {
      Config = 2;
    }

    showModalBottomSheet(
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: aContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Consumer<AttendanceProvider>(
            builder: (context, attendanceProvider, child) => Form(
              child: SafeArea(
                child: DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    maxChildSize: 1,
                    minChildSize: 0.4,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        padding: EdgeInsets.only(top: 20),
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            color: context.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(26),
                                topRight: Radius.circular(26))),
                        child: Column(
                          children: [
                            Container(
                                color: Color(0XFFB4BBC2), width: 50, height: 3),
                            SizedBox(height: 20),
                            Expanded(
                              child: Container(
                                //create confirm dialog with text box
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(
                                          "Select The Employee Attendance Config"
                                              .tr(),
                                          style: boldTextStyle(
                                              size: 18, color: kMainColor)),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: EdgeInsets.only(left: 25),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Radio(
                                                      value: 0,
                                                      groupValue: Config,
                                                      onChanged: (index) {
                                                        Config = 0;
                                                        attendanceProvider
                                                            .notifyListeners();
                                                      }),
                                                  Expanded(
                                                    child: Text('Qr'.tr()),
                                                  )
                                                ],
                                              ),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Radio(
                                                      value: 1,
                                                      groupValue: Config,
                                                      onChanged: (index) {
                                                        // _update(_count);
                                                        Config = 1;
                                                        attendanceProvider
                                                            .notifyListeners();
                                                      }),
                                                  Expanded(
                                                      child:
                                                      Text('Location'.tr()))
                                                ],
                                              ),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Radio(
                                                      value: 2,
                                                      groupValue: Config,
                                                      onChanged: (index) {
                                                        Config = 2;
                                                        attendanceProvider
                                                            .notifyListeners();
                                                      }),
                                                  Expanded(
                                                      child: Text('Any'.tr()))
                                                ],
                                              ),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      ButtonGlobal(
                                          buttontext: 'SAVE'.tr(),
                                          buttonDecoration: kButtonDecoration
                                              .copyWith(color: kMainColor),
                                          onPressed: () {
                                            Provider.of<AccountProvider>(
                                                context,
                                                listen: false)
                                                .authRepo
                                                .putShared(EmpCode, Config);

                                            bool QROption = true;
                                            bool LocationOption = true;
                                            // int xx = Config;
                                            if (Config == 0) {
                                              QROption;
                                              LocationOption = false;
                                            } else if (Config == 1) {
                                              LocationOption;
                                              QROption = false;
                                              attendanceProvider
                                                  .setEmpCode(EmpCode);
                                              attendanceProvider
                                                  .setQROption(QROption);
                                              attendanceProvider
                                                  .setLocationOption(
                                                  LocationOption);
                                            } else if (Config == 2) {
                                              QROption = false;
                                              LocationOption = false;
                                              attendanceProvider
                                                  .setEmpCode(EmpCode);
                                              attendanceProvider
                                                  .setQROption(QROption);
                                              attendanceProvider
                                                  .setLocationOption(
                                                  LocationOption);
                                            }

                                            if (LocationOption) {
                                              Navigator.pop(context);

                                              Future.delayed(
                                                  Duration(milliseconds: 500),
                                                      () => {
                                                    const AttendanceLocationMap()
                                                        .launch(aContext)
                                                  });
                                            } else if (QROption) {
                                              attendanceProvider
                                                  .attendanceConfig(
                                                  EmpCode,
                                                  QROption,
                                                  LocationOption,
                                                  0.0,
                                                  0.0);
                                              Navigator.pop(context);
                                              showCustomSnackBar(
                                                  "Employee Configuration Successfully Changed"
                                                      .tr(),
                                                  context,
                                                  isError: false);
                                            } else {
                                              attendanceProvider
                                                  .attendanceConfig(
                                                  EmpCode,
                                                  QROption,
                                                  LocationOption,
                                                  0.0,
                                                  0.0);
                                              Navigator.pop(context);
                                              showCustomSnackBar(
                                                  "Employee Configuration Successfully Changed"
                                                      .tr(),
                                                  context,
                                                  isError: false);
                                            }
                                            //Navigator.pop(context);
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          );
        });
  }

  Future<void> showLeaveSheet(BuildContext aContext, int index, String status, TextEditingController reasonController) async {
    showModalBottomSheet(
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: aContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 1,
              minChildSize: 0.7,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: context.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26))),
                  child: Column(
                    children: [
                      Container(color: Color(0XFFB4BBC2), width: 50, height: 3),
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          //create confirm dialog with text box
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                status == "2"
                                    ? Text(
                                    "Are you sure approving this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor))
                                    : Text(
                                    "Are you sure rejecting this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor)),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: boxDecorationWithRoundedCorners(
                                      borderRadius: radius(20),
                                      backgroundColor: Colors.white70,
                                      border: Border.all(color: kAlertColor)),
                                  child: TextField(
                                    controller: reasonController,
                                    decoration: InputDecoration.collapsed(
                                        hintText: "Enter reason here".tr()),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                          color: kAlertColor.withOpacity(0.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Cancel'.tr(),
                                            style: kTextStyle.copyWith(
                                              color: kAlertColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (status == "2") {
                                          Provider.of<EmployeeProvider>(context,
                                              listen: false)
                                              .updateVacation(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else if (status != "2" &&
                                            reasonController.text != "") {
                                          Provider.of<EmployeeProvider>(context,
                                              listen: false)
                                              .updateVacation(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Please put your reason of rejection"
                                                  .tr(),
                                              context,
                                              isError: true);
                                        }
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            color: kMainColor),
                                        child: Center(
                                          child: Text(
                                            'Confirm'.tr(),
                                            style: kTextStyle.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Future<void> showGeneralSheet(BuildContext aContext, int index, String status, TextEditingController reasonController) async {
    showModalBottomSheet(
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: aContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 1,
              minChildSize: 0.7,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: context.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26))),
                  child: Column(
                    children: [
                      Container(color: Color(0XFFB4BBC2), width: 50, height: 3),
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          //create confirm dialog with text box
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                status == "2"
                                    ? Text(
                                    "Are you sure approving this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor))
                                    : Text(
                                    "Are you sure rejecting this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor)),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: boxDecorationWithRoundedCorners(
                                      borderRadius: radius(20),
                                      backgroundColor: Colors.white70,
                                      border: Border.all(color: kAlertColor)),
                                  child: TextField(
                                    controller: reasonController,
                                    decoration: InputDecoration.collapsed(
                                        hintText: "Enter reason here".tr()),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                          color: kAlertColor.withOpacity(0.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Cancel'.tr(),
                                            style: kTextStyle.copyWith(
                                              color: kAlertColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (status == "2") {
                                          Provider.of<GeneralRequestProvider>(
                                              context,
                                              listen: false)
                                              .updateGeneral(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else if (status != "2" &&
                                            reasonController.text != "") {
                                          Provider.of<GeneralRequestProvider>(
                                              context,
                                              listen: false)
                                              .updateGeneral(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Please put your reason of rejection"
                                                  .tr(),
                                              context,
                                              isError: true);
                                        }
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            color: kMainColor),
                                        child: Center(
                                          child: Text(
                                            'Confirm'.tr(),
                                            style: kTextStyle.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Future<void> showLoanDelaySheet(BuildContext aContext, int index, String status, TextEditingController reasonController) async {
    showModalBottomSheet(
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: aContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 1,
              minChildSize: 0.7,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: context.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26))),
                  child: Column(
                    children: [
                      Container(color: Color(0XFFB4BBC2), width: 50, height: 3),
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          //create confirm dialog with text box
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                status == "2"
                                    ? Text(
                                    "Are you sure approving this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor))
                                    : Text(
                                    "Are you sure rejecting this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor)),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: boxDecorationWithRoundedCorners(
                                      borderRadius: radius(20),
                                      backgroundColor: Colors.white70,
                                      border: Border.all(color: kAlertColor)),
                                  child: TextField(
                                    controller: reasonController,
                                    decoration: InputDecoration.collapsed(
                                        hintText: "Enter reason here".tr()),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                          color: kAlertColor.withOpacity(0.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Cancel'.tr(),
                                            style: kTextStyle.copyWith(
                                              color: kAlertColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (status == "2") {
                                          Provider.of<LoanDelayProvider>(
                                              context,
                                              listen: false)
                                              .updateLoanDelay(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else if (status != "2" &&
                                            reasonController.text != "") {
                                          Provider.of<EmployeeProvider>(context,
                                              listen: false)
                                              .updateVacation(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Please put your reason of rejection"
                                                  .tr(),
                                              context,
                                              isError: true);
                                        }
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            color: kMainColor),
                                        child: Center(
                                          child: Text(
                                            'Confirm'.tr(),
                                            style: kTextStyle.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Future<void> showCashSheet(BuildContext aContext, int index, String status, TextEditingController reasonController) async {
    showModalBottomSheet(
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: aContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 1,
              minChildSize: 0.7,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: context.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26))),
                  child: Column(
                    children: [
                      Container(color: Color(0XFFB4BBC2), width: 50, height: 3),
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          //create confirm dialog with text box
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                status == "2"
                                    ? Text(
                                    "Are you sure approving this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor))
                                    : Text(
                                    "Are you sure rejecting this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor)),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: boxDecorationWithRoundedCorners(
                                      borderRadius: radius(20),
                                      backgroundColor: Colors.white70,
                                      border: Border.all(color: kAlertColor)),
                                  child: TextField(
                                    controller: reasonController,
                                    decoration: InputDecoration.collapsed(
                                        hintText: "Enter reason here".tr()),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                          color: kAlertColor.withOpacity(0.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Cancel'.tr(),
                                            style: kTextStyle.copyWith(
                                              color: kAlertColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (status == "2") {
                                          Provider.of<CashProvider>(context,
                                              listen: false)
                                              .updateCash(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else if (status != "2" &&
                                            reasonController.text != "") {
                                          Provider.of<CashProvider>(context,
                                              listen: false)
                                              .updateCash(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Please put your reason of rejection"
                                                  .tr(),
                                              context,
                                              isError: true);
                                        }
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            color: kMainColor),
                                        child: Center(
                                          child: Text(
                                            'Confirm'.tr(),
                                            style: kTextStyle.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Future<void> showClearanceSheet(BuildContext aContext, int index, String status, String empCode, TextEditingController reasonController) async {
    showModalBottomSheet(
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: aContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 1,
              minChildSize: 0.7,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: context.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26))),
                  child: Column(
                    children: [
                      Container(color: Color(0XFFB4BBC2), width: 50, height: 3),
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          //create confirm dialog with text box
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                status == "2"
                                    ? Text(
                                    "Are you sure approving this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor))
                                    : Text(
                                    "Are you sure rejecting this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor)),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: boxDecorationWithRoundedCorners(
                                      borderRadius: radius(20),
                                      backgroundColor: Colors.white70,
                                      border: Border.all(color: kAlertColor)),
                                  child: TextField(
                                    controller: reasonController,
                                    decoration: InputDecoration.collapsed(
                                        hintText: "Enter reason here".tr()),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                          color: kAlertColor.withOpacity(0.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Cancel'.tr(),
                                            style: kTextStyle.copyWith(
                                              color: kAlertColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (status == "2") {
                                          Provider.of<ClearanceProvider>(context,
                                              listen: false)
                                              .updateClearance(
                                              aContext,
                                              0,
                                              status,
                                              empCode,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else if (status != "2" &&
                                            reasonController.text != "") {
                                          Provider.of<ClearanceProvider>(context,
                                              listen: false)
                                              .updateClearance(
                                              aContext,
                                              0,
                                              status,
                                              empCode,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Please put your reason of rejection"
                                                  .tr(),
                                              context,
                                              isError: true);
                                        }
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            color: kMainColor),
                                        child: Center(
                                          child: Text(
                                            'Confirm'.tr(),
                                            style: kTextStyle.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Future<void> showLoanSheet(BuildContext aContext, int index, String status, TextEditingController reasonController) async {
    showModalBottomSheet(
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: aContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 1,
              minChildSize: 0.7,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: context.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26))),
                  child: Column(
                    children: [
                      Container(color: Color(0XFFB4BBC2), width: 50, height: 3),
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          //create confirm dialog with text box
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                status == "2"
                                    ? Text(
                                    "Are you sure approving this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor))
                                    : Text(
                                    "Are you sure rejecting this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor)),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: boxDecorationWithRoundedCorners(
                                      borderRadius: radius(20),
                                      backgroundColor: Colors.white70,
                                      border: Border.all(color: kAlertColor)),
                                  child: TextField(
                                    controller: reasonController,
                                    decoration: InputDecoration.collapsed(
                                        hintText: "Enter reason here".tr()),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                          color: kAlertColor.withOpacity(0.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Cancel'.tr(),
                                            style: kTextStyle.copyWith(
                                              color: kAlertColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (status == "2") {
                                          Provider.of<LoanProvider>(context,
                                              listen: false)
                                              .updateLoan(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else if (status != "2" &&
                                            reasonController.text != "") {
                                          Provider.of<LoanProvider>(context,
                                              listen: false)
                                              .updateLoan(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Please put your reason of rejection"
                                                  .tr(),
                                              context,
                                              isError: true);
                                        }
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            color: kMainColor),
                                        child: Center(
                                          child: Text(
                                            'Confirm'.tr(),
                                            style: kTextStyle.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Future<void> showPenaltySheet(BuildContext aContext, int index, String status, TextEditingController reasonController) async {
    showModalBottomSheet(
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: aContext,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 1,
              minChildSize: 0.7,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: context.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26))),
                  child: Column(
                    children: [
                      Container(color: Color(0XFFB4BBC2), width: 50, height: 3),
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          //create confirm dialog with text box
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                status == "2"
                                    ? Text(
                                    "Are you sure approving this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor))
                                    : Text(
                                    "Are you sure rejecting this request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor)),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: boxDecorationWithRoundedCorners(
                                      borderRadius: radius(20),
                                      backgroundColor: Colors.white70,
                                      border: Border.all(color: kAlertColor)),
                                  child: TextField(
                                    controller: reasonController,
                                    decoration: InputDecoration.collapsed(
                                        hintText: "Enter reason here".tr()),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                          color: kAlertColor.withOpacity(0.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Cancel'.tr(),
                                            style: kTextStyle.copyWith(
                                              color: kAlertColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (status == "2") {
                                          Provider.of<PenaltyProvider>(context,
                                              listen: false)
                                              .updatePenalty(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else if (status != "2" &&
                                            reasonController.text != "") {
                                          Provider.of<PenaltyProvider>(context,
                                              listen: false)
                                              .updatePenalty(
                                              aContext,
                                              index,
                                              status,
                                              reasonController.text);
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Please put your reason of rejection"
                                                  .tr(),
                                              context,
                                              isError: true);
                                        }
                                      },
                                      child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            color: kMainColor),
                                        child: Center(
                                          child: Text(
                                            'Confirm'.tr(),
                                            style: kTextStyle.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

}
import 'dart:convert';
import 'dart:typed_data';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:hub/Admin/screens/Management/AttendanceEmployeeList.dart';
import 'package:hub/Admin/screens/Management/CashRequestManagement.dart';
import 'package:hub/Admin/screens/Management/ClearanceManagement.dart';
import 'package:hub/Admin/screens/Management/ClearanceSubManagement.dart';
import 'package:hub/Admin/screens/Management/DesisionAttendanceHistory.dart';
import 'package:hub/Admin/screens/Management/DesisionHistory.dart';
import 'package:hub/Admin/screens/Management/GeneralRequestManagement.dart';
import 'package:hub/Admin/screens/Management/LeaveManagement.dart';
import 'package:hub/Admin/screens/Management/LoanDelayManagement.dart';
import 'package:hub/Admin/screens/Management/LoanManagement.dart';
import 'package:hub/Admin/screens/Management/MissingAttendanceManagement.dart';
import 'package:hub/Admin/screens/Management/PenaltyManagement.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Common/Util/shimmer.dart';
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
import 'package:hub/Data/provider/profile_provider.dart';
import 'package:hub/Widgets/decoration_widget.dart';
import 'package:hub/Widgets/requests_widget.dart';
import 'package:hub/Widgets/utils_widget.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../Admin/screens/Management/PrintEmployeeList.dart';

class ManagementWidget extends ChangeNotifier {
  Widget ShowLeaveList({required bool isApproved, required TextEditingController reasonController}) {
    return Consumer<EmployeeProvider>(
        builder: (context, employeeProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    color: kBgColor,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      employeeProvider.isLoading
                          ? Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[400],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1.0))),
                                margin: EdgeInsets.only(top: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 15, right: 10),
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 10),
                                            height: 8,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Container(
                                          height: 10,
                                          margin: EdgeInsets.only(right: 10),
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      height: 200,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                          : Visibility(
                        visible: true,
                        child:
                        employeeProvider.requestVacationModel.length != 0
                            ? Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context)
                                  .size
                                  .height -
                                  150,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: employeeProvider
                                    .requestVacationModel.length,
                                itemBuilder: (context, i) {
                                  Uint8List EmpImg =
                                  Uint8List.fromList(
                                      [0, 2, 5, 7, 42, 255]);
                                  String EmpImgOrig =
                                      employeeProvider
                                          .requestVacationModel[i]
                                          .employeeImage;
                                  if (!EmpImgOrig.startsWith(
                                      "https")) {
                                    EmpImg = base64Decode(
                                        employeeProvider
                                            .requestVacationModel[i]
                                            .employeeImage);
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        DecisionHistory(
                                            vacationId:
                                            employeeProvider
                                                .requestVacationModel[
                                            i]
                                                .VacRequestID,
                                            type: 'vacation')
                                            .launch(context);
                                      },
                                      child: Container(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 5.0,
                                            right: 5,
                                            top: 10,
                                            bottom: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(20.0),
                                            border: Border.all(
                                              color: kTitleColor,
                                              width: 0.5,
                                            )),
                                        child: Column(
                                          mainAxisSize:
                                          MainAxisSize.max,
                                          children: [
                                            ListTile(
                                              onTap: () {},
                                              leading: SizedBox(
                                                width: 50,
                                                child: EmpImgOrig
                                                    .startsWith(
                                                    "http")
                                                    ? CachedNetworkImage(
                                                  imageUrl:
                                                  EmpImgOrig,
                                                  imageBuilder:
                                                      (context,
                                                      imageProvider) =>
                                                      Container(
                                                        width:
                                                        50.0,
                                                        height:
                                                        50.0,
                                                        decoration:
                                                        BoxDecoration(
                                                          shape: BoxShape
                                                              .circle,
                                                          image:
                                                          DecorationImage(
                                                            image:
                                                            imageProvider,
                                                            fit: BoxFit
                                                                .fill,
                                                          ),
                                                        ),
                                                      ),
                                                )
                                                    : Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            9.0),
                                                        border: Border.all(
                                                            color: Colors
                                                                .white)),
                                                    child: Image.memory(
                                                        Uint8List.fromList(
                                                            EmpImg),
                                                        width:
                                                        50,
                                                        height:
                                                        50,
                                                        fit: BoxFit
                                                            .fill)),
                                              ),
                                              title: Text(
                                                Provider.of<AccountProvider>(
                                                    context,
                                                    listen:
                                                    false)
                                                    .authRepo
                                                    .getLang() ==
                                                    'ar'
                                                    ? employeeProvider
                                                    .requestVacationModel[
                                                i]
                                                    .employeeNameA
                                                    : employeeProvider
                                                    .requestVacationModel[
                                                i]
                                                    .employeeNameE,
                                                style: kTextStyle,
                                              ),
                                              subtitle: Text(
                                                'Employee'.tr(),
                                                style: kTextStyle
                                                    .copyWith(
                                                    color:
                                                    kGreyTextColor),
                                              ),
                                              trailing: Container(
                                                height: 50.0,
                                                width: 90.0,
                                                padding:
                                                const EdgeInsets
                                                    .all(2.0),
                                                decoration:
                                                BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      10.0),
                                                  color: kMainColor
                                                      .withOpacity(
                                                      0.08),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    Provider.of<AccountProvider>(context, listen: false)
                                                        .authRepo
                                                        .getLang() ==
                                                        'ar'
                                                        ? employeeProvider
                                                        .requestVacationModel[
                                                    i]
                                                        .VacationReasonA
                                                        : employeeProvider
                                                        .requestVacationModel[
                                                    i]
                                                        .VacationReasonE,
                                                    textAlign:
                                                    TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                        color:
                                                        VacColor,
                                                        fontSize:
                                                        12,
                                                        fontWeight:
                                                        FontWeight
                                                            .w800),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Column(
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets
                                                      .only(
                                                      left: 10,
                                                      right:
                                                      10),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize
                                                        .max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'From Day'
                                                            .tr(),
                                                        style: kTextStyle.copyWith(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      ),
                                                      Text(
                                                        'To Day'
                                                            .tr(),
                                                        style: kTextStyle.copyWith(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      ),
                                                      Text(
                                                        'Leave day'
                                                            .tr(),
                                                        style: kTextStyle.copyWith(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1.0,
                                                  color:
                                                  kGreyTextColor,
                                                ),
                                                const SizedBox(
                                                  height: 20.0,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets
                                                      .only(
                                                      left: 10,
                                                      right:
                                                      10),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize
                                                        .min,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        employeeProvider
                                                            .requestVacationModel[
                                                        i]
                                                            .VacationFrom,
                                                        style: kTextStyle
                                                            .copyWith(
                                                            color:
                                                            kGreyTextColor),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            left:
                                                            25.0,
                                                            right:
                                                            25.0),
                                                        child: Text(
                                                          employeeProvider
                                                              .requestVacationModel[
                                                          i]
                                                              .VacationTo,
                                                          style: kTextStyle.copyWith(
                                                              color:
                                                              kGreyTextColor),
                                                        ),
                                                      ),
                                                      Text(
                                                        employeeProvider
                                                            .requestVacationModel[
                                                        i]
                                                            .VacationFrom,
                                                        style: kTextStyle
                                                            .copyWith(
                                                            color:
                                                            kGreyTextColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            employeeProvider
                                                .requestVacationModel[
                                            i]
                                                .IsApproved ==
                                                "1"
                                                ? Visibility(
                                              visible:
                                              !isApproved,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  GestureDetector(
                                                    onTap:
                                                        () {
                                                      RequestsWidget().showLeaveSheet(
                                                          context,
                                                          i,
                                                          "2",
                                                          reasonController);
                                                    },
                                                    child:
                                                    Container(
                                                      width:
                                                      120,
                                                      padding: const EdgeInsets.only(
                                                          left:
                                                          10.0,
                                                          right:
                                                          10.0,
                                                          top:
                                                          10.0,
                                                          bottom:
                                                          10.0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(15.0),
                                                          color: kMainColor),
                                                      child:
                                                      Center(
                                                        child:
                                                        Text(
                                                          'Approve'.tr(),
                                                          style:
                                                          kTextStyle.copyWith(color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      width:
                                                      10.0),
                                                  GestureDetector(
                                                    onTap:
                                                        () {
                                                          RequestsWidget().showLeaveSheet(
                                                          context,
                                                          i,
                                                          "3",
                                                          reasonController);
                                                    },
                                                    child:
                                                    Container(
                                                      width:
                                                      120,
                                                      padding: const EdgeInsets.only(
                                                          left:
                                                          10.0,
                                                          right:
                                                          10.0,
                                                          top:
                                                          10.0,
                                                          bottom:
                                                          10.0),
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(15.0),
                                                        color:
                                                        kAlertColor.withOpacity(0.1),
                                                      ),
                                                      child:
                                                      Center(
                                                        child:
                                                        Text(
                                                          'Reject'.tr(),
                                                          style:
                                                          kTextStyle.copyWith(color: kAlertColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                                : Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                employeeProvider
                                                    .requestVacationModel[i]
                                                    .VacationStateE ==
                                                    "Pending"
                                                    ? GestureDetector(
                                                  onTap:
                                                      () async {
                                                    employeeProvider.updateVacation(
                                                        context,
                                                        i,
                                                        "2",
                                                        "Notified");
                                                  },
                                                  child:
                                                  Container(
                                                    width:
                                                    120,
                                                    padding: const EdgeInsets.only(
                                                        left: 10.0,
                                                        right: 10.0,
                                                        top: 10.0,
                                                        bottom: 10.0),
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15.0),
                                                      color: kMainColor,
                                                    ),
                                                    child:
                                                    Center(
                                                      child: Text(
                                                        'Notify'.tr(),
                                                        style: kTextStyle.copyWith(color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                    : Text(
                                                  employeeProvider.requestVacationModel[i].VacationStateE == "Pending"
                                                      ? "Notified"
                                                      : employeeProvider.requestVacationModel[i].VacationStateE,
                                                  style: TextStyle(
                                                      color: kGreenColor,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                            : Container(
                          width: MediaQuery.of(context).size.width,
                          height:
                          MediaQuery.of(context).size.height /
                              1.5,
                          child: Center(
                            child: Text('No Requests Yet'.tr(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget ShowEmpManagementList({required BuildContext context}) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20.0, right: 25, top: 20, bottom: 15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // const SizedBox(
                  //   height: 2.0,
                  // ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Administrative affairs'.tr(),
                        textAlign: TextAlign.right,
                        style: boldTextStyle())
                        .paddingAll(10),
                  ),
                  // Divider(height: 0, indent: 16, endIndent: 16),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          const PrintEmployeeList().launch(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/print.png',
                                  ),
                                  width: 100,
                                  height: 100,
                                ),
                                padding:
                                const EdgeInsets.all(12),
                              ),
                              Container(
                                width: 160,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                    BorderRadius.only(
                                        bottomRight: Radius
                                            .circular(15),
                                        bottomLeft:
                                        Radius.circular(
                                            15))),
                                child: Center(
                                  child: Text(
                                    "Print Cards".tr(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Robot',
                                        color: Colors.black45,
                                        fontWeight:
                                        FontWeight.w700),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          const AttendanceEmployeeList().launch(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/att.png',
                                  ),
                                  width: 100,
                                  height: 100,
                                ),
                                padding:
                                const EdgeInsets.all(12),
                              ),
                              Container(
                                width: 160,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                    BorderRadius.only(
                                        bottomRight: Radius
                                            .circular(15),
                                        bottomLeft:
                                        Radius.circular(
                                            15))),
                                child: Center(
                                  child: Text(
                                    "Mark Attendance"
                                        .tr(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                        fontWeight:
                                        FontWeight.w700),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Requests Management'.tr(),
                        textAlign: TextAlign.right,
                        style: boldTextStyle())
                        .paddingAll(10),
                  ),
                  // Divider(height: 0, indent: 16, endIndent: 16),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const LeaveManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage('assets/images/vac.png')),
                            title: Row(children: [
                              Text(
                                'Vacation Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, EmployeeProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.requestVacationModel.length
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //  provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: kAlertColor,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const MissingAttendanceManagement()
                                  .launch(context);
                            },
                            leading: const Image(
                                image: AssetImage(
                                    'assets/images/timeattendance.png')),
                            title: Text(
                              'Attendance Management'.tr(),
                              maxLines: 2,
                              style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFFFD73B0),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const LoanManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image:
                                AssetImage('assets/images/loanicon.png')),
                            title: Row(children: [
                              Text(
                                'Loan Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, LoanProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.loanNotifyList.length.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFF297E07),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const LoanDelayManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage(
                                    'assets/images/loandelayicon.png')),
                            title: Row(children: [
                              Text(
                                'Loan Delay Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, LoanDelayProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.loanDelayNotifiedList.length
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFFe8870a),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const CashRequestManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage(
                                    'assets/images/cashreqicon.png')),
                            title: Row(children: [
                              Text(
                                'Cash Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, CashProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.cashNotifiedList.length.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFF4f3c04),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const GeneralRequestManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage(
                                    'assets/images/general_icon.png')),
                            title: Row(children: [
                              Text(
                                'General Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder: (context,
                                  GeneralRequestProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.generalNotifiedList.length
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //  provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFFf31242),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const PenaltyManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage(
                                    'assets/images/penaltyicon.png')),
                            title: Row(children: [
                              Text(
                                'Penalty Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, PenaltyProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.PenaltyNotifiedData.length
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //  provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFFFA1A1FF),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const ClearanceManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage('assets/images/out.png')),
                            title: Row(children: [
                              Text(
                                'Clearance Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, ClearanceProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.clearanceEmpData.length.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFF4FA9C9),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget ShowEmpManagementList2({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const AttendanceEmployeeList().launch(context);
                            },
                            leading: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: const Image(
                                  width: 40,
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/employeemanagement.png')),
                            ),
                            title: Text(
                              'Employees'.tr(),
                              maxLines: 2,
                              style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFF9090C4),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const LeaveManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage('assets/images/vac.png')),
                            title: Row(children: [
                              Text(
                                'Vacation Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, EmployeeProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.requestVacationModel.length
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //  provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: kAlertColor,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const MissingAttendanceManagement()
                                  .launch(context);
                            },
                            leading: const Image(
                                image: AssetImage(
                                    'assets/images/timeattendance.png')),
                            title: Text(
                              'Attendance Management'.tr(),
                              maxLines: 2,
                              style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFFFD73B0),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const LoanManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image:
                                AssetImage('assets/images/loanicon.png')),
                            title: Row(children: [
                              Text(
                                'Loan Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, LoanProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.loanNotifyList.length.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFF297E07),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const LoanDelayManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage(
                                    'assets/images/loandelayicon.png')),
                            title: Row(children: [
                              Text(
                                'Loan Delay Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, LoanDelayProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.loanDelayNotifiedList.length
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFFe8870a),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const CashRequestManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage(
                                    'assets/images/cashreqicon.png')),
                            title: Row(children: [
                              Text(
                                'Cash Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, CashProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.cashNotifiedList.length.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFF4f3c04),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const GeneralRequestManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage(
                                    'assets/images/general_icon.png')),
                            title: Row(children: [
                              Text(
                                'General Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder: (context,
                                  GeneralRequestProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.generalNotifiedList.length
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //  provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFFf31242),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const PenaltyManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage(
                                    'assets/images/penaltyicon.png')),
                            title: Row(children: [
                              Text(
                                'Penalty Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, PenaltyProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.PenaltyNotifiedData.length
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //  provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFFFA1A1FF),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: DecorationWidget().boxDecorations(
                        bgColor: Colors.white, radius: 20, showShadow: true),
                    child: Stack(
                      children: [
                        Container(
                          width: context.width(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              const ClearanceManagement().launch(context);
                            },
                            leading: const Image(
                                width: 40,
                                height: 40,
                                image: AssetImage('assets/images/out.png')),
                            title: Row(children: [
                              Text(
                                'Clearance Management'.tr(),
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer(builder:
                                  (context, ClearanceProvider provider, child) {
                                return Badge(
                                  showBadge: provider.showBadge,
                                  position: BadgePosition.bottomEnd(
                                      bottom: 8, end: 8),
                                  badgeContent: Text(
                                    provider.clearanceEmpData.length.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(right: 10.0),
                                    icon: Icon(
                                      FontAwesomeIcons.bell,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // provider.clear();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SVNotificationFragment()));
                                    },
                                  ),
                                );
                              }),
                            ]),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 35,
                          margin: EdgeInsets.only(top: 25),
                          color: Color(0xFF4FA9C9),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget ShowMarkAttendanceList({required BuildContext context, required bool isPresent, required bool isAbsent, required bool isHalfDay, required bool isHoliday, required bool inTimeSelected, required bool outTimeSelected, required TimeOfDay selectedInTime, required TimeOfDay selectedOutTime}) {
    return SingleChildScrollView(
      child: Consumer<AttendanceProvider>(
          builder: (context, attendanceProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: context.width(),
                  height: context.height(),
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    color: kBgColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Attendance'.tr(),
                              style: kTextStyle,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () => {isPresent = !isPresent},
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 30.0,
                                        right: 30.0,
                                        top: 10.0,
                                        bottom: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: isPresent
                                          ? kMainColor
                                          : kMainColor.withOpacity(0.1),
                                    ),
                                    child: Text(
                                      'Present'.tr(),
                                      style: kTextStyle.copyWith(
                                          color:
                                          isPresent ? Colors.white : kMainColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 30.0,
                                            right: 30.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: isAbsent
                                              ? kAlertColor
                                              : kAlertColor.withOpacity(0.1),
                                        ),
                                        child: Text(
                                          'Absent'.tr(),
                                          style: kTextStyle.copyWith(
                                            color:
                                            isAbsent ? Colors.white : kAlertColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // setState(() {
                                    //   isHalfDay = !isHalfDay;
                                    // });
                                  },
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 30.0,
                                          right: 30.0,
                                          top: 10.0,
                                          bottom: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: isHalfDay
                                            ? kHalfDay
                                            : kHalfDay.withOpacity(0.1),
                                      ),
                                      child: Text(
                                        'Half Day'.tr(),
                                        style: kTextStyle.copyWith(
                                            color:
                                            isHalfDay ? Colors.white : kHalfDay,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    // setState(() {
                                    //   isHoliday = !isHoliday;
                                    // });
                                  },
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 30.0,
                                          right: 30.0,
                                          top: 10.0,
                                          bottom: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: isHoliday
                                            ? kGreenColor
                                            : kGreenColor.withOpacity(0.1),
                                      ),
                                      child: Text(
                                        'Holiday'.tr(),
                                        style: kTextStyle.copyWith(
                                          color: isHoliday
                                              ? Colors.white
                                              : kGreenColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Attendance'.tr(),
                              style: kTextStyle,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                  visible: inTimeSelected,
                                  child: Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(color: kGreyTextColor),
                                        ),
                                        child: Row(
                                          children: [
                                            TextButton(
                                                onPressed: () async {
                                                  attendanceProvider
                                                      .selectInTimeMethod(
                                                      context: context,
                                                      selectedInTime:
                                                      selectedInTime,
                                                      inTimeSelected:
                                                      inTimeSelected);
                                                },
                                                child: Text(
                                                    "${selectedInTime.hour}:${selectedInTime.minute} ${selectedInTime.period.toString().substring(10, 12)}")),
                                            const Spacer(),
                                            const Icon(
                                              Icons.access_time,
                                              color: kGreyTextColor,
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !inTimeSelected,
                                  child: Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: AppTextField(
                                        textFieldType: TextFieldType.NAME,
                                        readOnly: true,
                                        onTap: () async {
                                          attendanceProvider.selectInTimeMethod(
                                              context: context,
                                              selectedInTime: selectedInTime,
                                              inTimeSelected: inTimeSelected);
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                            suffixIcon: Icon(
                                              Icons.access_time,
                                              color: kGreyTextColor,
                                            ),
                                            labelText: 'In Time'.tr(),
                                            hintText: 'In Time'.tr()),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: outTimeSelected,
                                  child: Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(color: kGreyTextColor),
                                        ),
                                        child: Row(
                                          children: [
                                            TextButton(
                                                onPressed: () async {
                                                  attendanceProvider
                                                      .selectOutTimeMethod(
                                                      context: context,
                                                      selectedOutTime:
                                                      selectedOutTime,
                                                      outTimeSelected:
                                                      outTimeSelected);
                                                },
                                                child: Text(
                                                    "${selectedOutTime.hour}:${selectedOutTime.minute} ${selectedOutTime.period.toString().substring(10, 12)}")),
                                            const Spacer(),
                                            const Icon(
                                              Icons.access_time,
                                              color: kGreyTextColor,
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !outTimeSelected,
                                  child: Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: AppTextField(
                                        textFieldType: TextFieldType.NAME,
                                        readOnly: true,
                                        onTap: () async {
                                          attendanceProvider.selectOutTimeMethod(
                                              context: context,
                                              selectedOutTime: selectedOutTime,
                                              outTimeSelected: outTimeSelected);
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                            suffixIcon: Icon(
                                              Icons.access_time,
                                              color: kGreyTextColor,
                                            ),
                                            labelText: 'Out Time'.tr(),
                                            hintText: 'Out Time'.tr()),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ButtonGlobal(
                        buttontext: 'Submit Attendance'.tr(),
                        buttonDecoration:
                        kButtonDecoration.copyWith(color: kMainColor),
                        onPressed: () {
                          if (inTimeSelected && outTimeSelected) {
                            DateTime? checkInSelectedTime = DateTime(
                                selectedInTime.hour, selectedInTime.minute);
                            DateTime? checkOutSelectedTime = DateTime(
                                selectedOutTime.hour, selectedOutTime.minute);
                            Duration difference = checkInSelectedTime
                                .difference(checkOutSelectedTime);
                            if (difference.inMinutes > 1) {
                              Provider.of<EmployeeProvider>(context, listen: false)
                                  .addAttendance(
                                context,
                                isHoliday,
                                isPresent,
                                selectedInTime,
                                selectedOutTime,
                              );
                            } else {
                              showCustomSnackBar(
                                  'selected check-in must be less than check-out time'
                                      .tr(),
                                  context,
                                  isError: true);
                            }
                          } else {
                            showCustomSnackBar(
                                'select check-in and check-out time'.tr(), context,
                                isError: true);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget showClearanceEmpCard(BuildContext context, isDecision, reasonController, bool ShowList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: kBgColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Visibility(
                  visible: true,
                  child: ShowList && Provider.of<ClearanceProvider>(context, listen: false).clearanceEmpData.length != 0
                      ? Expanded(
                    child: Container(
                      height: context.height(),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Consumer<ClearanceProvider>(
                          builder: (context, clearanceProvider, child) {
                            return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount:
                                clearanceProvider.clearanceEmpData.length,
                                itemBuilder: (context, index) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: DecorationWidget()
                                              .boxDecorations(
                                              bgColor: Colors.white,
                                              radius: 20,
                                              showShadow: true),
                                          child: Column(
                                            children:[
                                              ListTile(
                                                onTap: () {
                                                  ClearanceSubManagement(
                                                      EmpCode: clearanceProvider
                                                          .clearanceEmpData[
                                                      index]
                                                          .EmpCode,
                                                      model: clearanceProvider
                                                          .clearanceSubData,
                                                      isDecision: isDecision,
                                                      index: index)
                                                      .launch(context);
                                                },
                                                leading: CachedNetworkImage(
                                                  imageUrl:
                                                  'https://www.w3schools.com/howto/img_avatar.png',
                                                  imageBuilder:
                                                      (context, imageProvider) =>
                                                      Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.cover),
                                                        ),
                                                      ),
                                                  placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                  const Icon(Icons.error),
                                                ),
                                                title: Text(
                                                    Provider.of<AccountProvider>(
                                                        context)
                                                        .authRepo
                                                        .getLang() ==
                                                        'ar'
                                                        ? clearanceProvider
                                                        .clearanceEmpData[
                                                    index]
                                                        .EmpNameA
                                                        : clearanceProvider
                                                        .clearanceEmpData[
                                                    index]
                                                        .EmpNameE,
                                                    style: kTextStyle),
                                                subtitle: Text(
                                                    Provider.of<AccountProvider>(
                                                        context)
                                                        .authRepo
                                                        .getLang() ==
                                                        'ar'
                                                        ? clearanceProvider
                                                        .clearanceEmpData[
                                                    index]
                                                        .PositionDescA
                                                        : clearanceProvider
                                                        .clearanceEmpData[
                                                    index]
                                                        .PositionDescE,
                                                    style: kTextStyle.copyWith(
                                                        color: kGreyTextColor,
                                                        fontSize: 12)),
                                                trailing: const Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }),
                    ),
                  )
                      : Provider.of<ClearanceProvider>(context, listen: false)
                      .isLoading == false
                      ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Center(
                      child: Text('No Requests Yet'.tr(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                          textAlign: TextAlign.center),
                    ),
                  )
                      : ShowList == false &&
                      Provider.of<ClearanceProvider>(context,
                          listen: false)
                          .isLoading ==
                          true
                      ? Container(
                    width: MediaQuery.of(context).size.width,
                    height:
                    MediaQuery.of(context).size.height / 1.5,
                    child: Center(
                      child: Text(
                        'Loading ...'.tr(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                      : Offstage(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget ShowMissingAttendance({required bool ShowList, required String hint, required bool isApproved, required selectedOutTime, required outTimeSelected, selectedTime, required selectedDate, required TimeToController, required dateToController, required reasonController}) {
    return Consumer<AttendanceProvider>(
        builder: (context, attendanceProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    color: kBgColor,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      attendanceProvider.isLoading
                          ? Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[400],
                            highlightColor: Colors.grey[100],
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black, width: 1.0))),
                              margin: EdgeInsets.only(top: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 15, right: 10),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          height: 8,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Container(
                                        height: 10,
                                        margin: EdgeInsets.only(right: 10),
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    height: 200,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                          : Visibility(
                        visible: true,
                        child: ShowList
                            ? Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              height:
                              MediaQuery.of(context).size.height -
                                  150,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: attendanceProvider
                                    .MissedAttendanceList.length,
                                itemBuilder: (context, i) {
                                  DateTime checkTime = DateTime.parse(
                                      attendanceProvider
                                          .MissedAttendanceList[i]
                                          .AttendanceCheckTime);
                                  DateTime checkOutDate =
                                  DateTime.parse(attendanceProvider
                                      .MissedAttendanceList[i]
                                      .AttendanceCheckDate);
                                  String EmployeeCheckOutTime =
                                  DateFormat('HH:mm:ss a')
                                      .format(checkTime);
                                  String EmployeeCheckTimeDate =
                                  DateFormat('dd-MM-yyyy')
                                      .format(checkTime);
                                  String EmployeeCheckOutDate =
                                  DateFormat('dd-MM-yyyy')
                                      .format(checkOutDate);

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        /** history cycle **/
                                        String MissedAttendanceId =
                                            attendanceProvider
                                                .MissedAttendanceList[i]
                                                .attendanceRequestID;
                                        DecisionAttendanceHistory(
                                            attendanceId:
                                            MissedAttendanceId)
                                            .launch(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 5.0,
                                            right: 5,
                                            top: 10,
                                            bottom: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              20.0),
                                          border: Border.all(
                                              color: kTitleColor,
                                              width: 0.5),
                                        ),
                                        child: Column(
                                          mainAxisSize:
                                          MainAxisSize.max,
                                          children: [
                                            ListTile(
                                              onTap: () {},
                                              leading:
                                              CachedNetworkImage(
                                                imageUrl:
                                                'https://www.w3schools.com/howto/img_avatar.png',
                                                imageBuilder: (context,
                                                    imageProvider) =>
                                                    Container(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      decoration:
                                                      BoxDecoration(
                                                        shape:
                                                        BoxShape.circle,
                                                        image: DecorationImage(
                                                            image:
                                                            imageProvider,
                                                            fit: BoxFit
                                                                .cover),
                                                      ),
                                                    ),
                                                placeholder: (context,
                                                    url) =>
                                                const CircularProgressIndicator(),
                                                errorWidget: (context,
                                                    url, error) =>
                                                const Icon(
                                                    Icons.error),
                                              ),
                                              title: Text(
                                                  attendanceProvider
                                                      .MissedAttendanceList[
                                                  i]
                                                      .attendanceDecisionMakerNameE,
                                                  style: kTextStyle),
                                              subtitle: Text(
                                                  attendanceProvider
                                                      .MissedAttendanceList[
                                                  i]
                                                      .EmployeePosition,
                                                  style: kTextStyle
                                                      .copyWith(
                                                      color:
                                                      kGreyTextColor)),
                                              trailing: Container(
                                                height: 50.0,
                                                width: 120.0,
                                                padding:
                                                const EdgeInsets
                                                    .all(2.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        10.0),
                                                    color: kMainColor
                                                        .withOpacity(
                                                        0.08)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                          EmployeeCheckOutTime,
                                                          style: TextStyle(
                                                              color:
                                                              VacColor,
                                                              fontSize:
                                                              12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w800)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 20),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'check In'
                                                              .tr(),
                                                          style: kTextStyle.copyWith(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'Check out'
                                                              .tr(),
                                                          style: kTextStyle.copyWith(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          'reason'.tr(),
                                                          style: kTextStyle
                                                              .copyWith(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                          ),
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1.0,
                                                  color: kGreyTextColor,
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 12),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          EmployeeCheckOutDate,
                                                          style: kTextStyle
                                                              .copyWith(
                                                              color:
                                                              kGreyTextColor),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          EmployeeCheckTimeDate,
                                                          style: kTextStyle
                                                              .copyWith(
                                                              color:
                                                              kGreyTextColor),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          attendanceProvider
                                                              .MissedAttendanceList[
                                                          i]
                                                              .attendanceReason,
                                                          style: kTextStyle
                                                              .copyWith(
                                                              color:
                                                              kGreyTextColor),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            attendanceProvider
                                                .MissedAttendanceList[
                                            i]
                                                .IsApprove ==
                                                "1"
                                                ? Visibility(
                                              visible:
                                              !isApproved,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      hint = "";
                                                      showSheetForMissingAttendance(
                                                          context,
                                                          i,
                                                          "2",
                                                          attendanceProvider
                                                              .MissedAttendanceList[
                                                          i]
                                                              .RequestStatusID,
                                                          attendanceProvider
                                                              .MissedAttendanceList[
                                                          i]
                                                              .IsDecision,
                                                          attendanceProvider
                                                              .MissedAttendanceList[
                                                          i]
                                                              .AttendanceCheckDate,
                                                          attendanceProvider
                                                              .MissedAttendanceList[
                                                          i]
                                                              .AttendanceCheckTime,
                                                          attendanceProvider
                                                              .MissedAttendanceList[i]
                                                              .FK_InOutSignID,
                                                          selectedOutTime,
                                                          outTimeSelected,
                                                          selectedTime,
                                                          selectedDate,
                                                          TimeToController,
                                                          dateToController,
                                                          reasonController);
                                                    },
                                                    child:
                                                    Container(
                                                      width: 120,
                                                      padding: const EdgeInsets
                                                          .only(
                                                          left:
                                                          10.0,
                                                          right:
                                                          10.0,
                                                          top:
                                                          10.0,
                                                          bottom:
                                                          10.0),
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                        color:
                                                        kMainColor,
                                                      ),
                                                      child:
                                                      Center(
                                                        child:
                                                        Text(
                                                          'Approve'
                                                              .tr(),
                                                          style: kTextStyle
                                                              .copyWith(
                                                            color:
                                                            Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showSheetForMissingAttendance(
                                                          context,
                                                          i,
                                                          "3",
                                                          attendanceProvider
                                                              .MissedAttendanceList[
                                                          i]
                                                              .RequestStatusID,
                                                          attendanceProvider
                                                              .MissedAttendanceList[
                                                          i]
                                                              .IsDecision,
                                                          attendanceProvider
                                                              .MissedAttendanceList[
                                                          i]
                                                              .AttendanceCheckDate,
                                                          attendanceProvider
                                                              .MissedAttendanceList[
                                                          i]
                                                              .AttendanceCheckTime,
                                                          attendanceProvider
                                                              .MissedAttendanceList[i]
                                                              .FK_InOutSignID,
                                                          selectedOutTime,
                                                          outTimeSelected,
                                                          selectedTime,
                                                          selectedDate,
                                                          TimeToController,
                                                          dateToController,
                                                          reasonController);
                                                    },
                                                    child:
                                                    Container(
                                                      width: 120,
                                                      padding: const EdgeInsets
                                                          .only(
                                                          left:
                                                          10.0,
                                                          right:
                                                          10.0,
                                                          top:
                                                          10.0,
                                                          bottom:
                                                          10.0),
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                        color: kAlertColor
                                                            .withOpacity(
                                                            0.1),
                                                      ),
                                                      child:
                                                      Center(
                                                        child:
                                                        Text(
                                                          'Reject'
                                                              .tr(),
                                                          style: kTextStyle
                                                              .copyWith(
                                                            color:
                                                            kAlertColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                                : Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                attendanceProvider
                                                    .MissedAttendanceList[
                                                i]
                                                    .ReqStatusE ==
                                                    "Pending"
                                                    ? GestureDetector(
                                                  onTap:
                                                      () async {
                                                    await Provider.of<AttendanceProvider>(context, listen: false).updateAttendance(
                                                        context,
                                                        i,
                                                        attendanceProvider.MissedAttendanceList[i].ReqStatusE,
                                                        attendanceProvider.MissedAttendanceList[i].RequestStatusID,
                                                        attendanceProvider.MissedAttendanceList[i].attendanceReason,
                                                        attendanceProvider.MissedAttendanceList[i].AttendanceCheckDate,
                                                        attendanceProvider.MissedAttendanceList[i].AttendanceCheckTime,
                                                        attendanceProvider.MissedAttendanceList[i].FK_InOutSignID);
                                                  },
                                                  child:
                                                  Container(
                                                    width:
                                                    120,
                                                    padding: const EdgeInsets.only(
                                                        left:
                                                        10.0,
                                                        right:
                                                        10.0,
                                                        top:
                                                        10.0,
                                                        bottom:
                                                        10.0),
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(15.0),
                                                      color:
                                                      kMainColor,
                                                    ),
                                                    child:
                                                    Center(
                                                      child:
                                                      Text(
                                                        'Notify'.tr(),
                                                        style:
                                                        kTextStyle.copyWith(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                    : Text(
                                                    attendanceProvider
                                                        .MissedAttendanceList[
                                                    i]
                                                        .ReqStatusE,
                                                    style: TextStyle(
                                                        color:
                                                        kGreenColor,
                                                        fontSize:
                                                        15,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                            : !ShowList
                            ? Container(
                          width: MediaQuery.of(context).size.width,
                          height:
                          MediaQuery.of(context).size.height /
                              1.5,
                          child: Center(
                            child: Text('No Requests Yet'.tr(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                                textAlign: TextAlign.center),
                          ),
                        )
                            : Offstage(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> showSheetForMissingAttendance(BuildContext aContext, int index, String status, int statusId, String isDecision, String chechInDate, String checkOutTime, String FK_InOutSignID, TimeOfDay selectedOutTime, bool outTimeSelected, TimeOfDay selectedTime, DateTime selectedDate, TextEditingController TimeToController, TextEditingController dateToController, TextEditingController reasonController) async {
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
                                    "Are you sure approving this attendance request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor))
                                    : Text(
                                    "Are you sure rejecting this attendance request"
                                        .tr(),
                                    style: boldTextStyle(
                                        size: 18, color: kMainColor)),
                                SizedBox(height: 20),
                                isDecision == "1"
                                    ? Row(
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 50.0,
                                      child: AppTextField(
                                        textFieldType: TextFieldType.NAME,
                                        textAlignVertical:
                                        TextAlignVertical.bottom,
                                        onTap: () async {
                                          FocusScope.of(context)
                                              .requestFocus(
                                              new FocusNode());
                                          Provider.of<AttendanceProvider>(
                                              context,
                                              listen: false)
                                              .selectOutTimeMethod(
                                              context: context,
                                              selectedOutTime:
                                              selectedOutTime,
                                              outTimeSelected:
                                              outTimeSelected);
                                        },
                                        controller: TimeToController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior
                                                .always,
                                            suffixIcon: Icon(
                                              Icons.access_time,
                                              color: kGreyTextColor,
                                            ),
                                            labelText: 'Time'.tr(),
                                            hintText: ("${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.toString().substring(10, 12)}" ==
                                                "")
                                                ? DateFormat("HH:mm:ss")
                                                .format(
                                                DateTime.parse(
                                                    checkOutTime))
                                                : "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.toString().substring(10, 12)}"),
                                      ),
                                    ),
                                    const Spacer(),
                                    //const SizedBox(width: 20,),
                                    Container(
                                      width: 160,
                                      height: 50.0,
                                      child: AppTextField(
                                          textFieldType:
                                          TextFieldType.NAME,
                                          textAlignVertical:
                                          TextAlignVertical.bottom,
                                          readOnly: true,
                                          onTap: () async {
                                            final DateTime? date =
                                            await showDatePicker(
                                                context: context,
                                                initialDate:
                                                DateTime.now(),
                                                firstDate:
                                                DateTime(1900),
                                                lastDate:
                                                DateTime(2100));
                                            selectedDate = date!;
                                            dateToController.text = date
                                                .toString()
                                                .substring(0, 10);
                                          },
                                          controller: dateToController,
                                          decoration: InputDecoration(
                                              border:
                                              OutlineInputBorder(),
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior
                                                  .always,
                                              suffixIcon: Icon(
                                                Icons.date_range_rounded,
                                                color: kGreyTextColor,
                                              ),
                                              labelText: 'Date'.tr(),
                                              hintText: chechInDate)),
                                    ),
                                  ],
                                )
                                    : Offstage(),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: boxDecorationWithRoundedCorners(
                                      borderRadius: radius(5),
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
                                        DateTime? checkInSelectedDate =
                                        DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            selectedDate.day);
                                        DateTime? checkOutSelectedTime =
                                        DateTime(selectedTime.hour,
                                            selectedTime.minute);
                                        String checkInSelectedDateFormat =
                                        DateFormat("yyyy-MM-dd")
                                            .format(checkInSelectedDate);
                                        String checkOutSelectedDateFormat =
                                        DateFormat("hh:mm:ss")
                                            .format(checkOutSelectedTime);

                                        if (isDecision == "1" &&
                                            checkInSelectedDateFormat != "" &&
                                            checkOutSelectedDateFormat != "") {
                                          Provider.of<AttendanceProvider>(
                                              context,
                                              listen: false)
                                              .updateAttendance(
                                              aContext,
                                              index,
                                              status,
                                              statusId,
                                              reasonController.text,
                                              FK_InOutSignID,
                                              checkInSelectedDateFormat,
                                              checkOutSelectedDateFormat);
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Request approved successfully"
                                                  .tr(),
                                              context,
                                              isError: false);
                                        } else if (isDecision == "1" &&
                                            checkInSelectedDateFormat == "" &&
                                            checkOutSelectedDateFormat == "") {
                                          Provider.of<AttendanceProvider>(
                                              context,
                                              listen: false)
                                              .updateAttendance(
                                              aContext,
                                              index,
                                              status,
                                              statusId,
                                              reasonController.text,
                                              FK_InOutSignID,
                                              chechInDate,
                                              checkOutTime);
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Request approved successfully"
                                                  .tr(),
                                              context,
                                              isError: false);
                                        } else if (isDecision == "1" &&
                                            checkInSelectedDateFormat == "" &&
                                            checkOutSelectedDateFormat != "") {
                                          Provider.of<AttendanceProvider>(
                                              context,
                                              listen: false)
                                              .updateAttendance(
                                              aContext,
                                              index,
                                              status,
                                              statusId,
                                              reasonController.text,
                                              FK_InOutSignID,
                                              chechInDate,
                                              checkOutSelectedDateFormat);
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Request approved successfully"
                                                  .tr(),
                                              context,
                                              isError: false);
                                        } else if (isDecision == "1" &&
                                            checkInSelectedDateFormat != "" &&
                                            checkOutSelectedDateFormat == "") {
                                          Provider.of<AttendanceProvider>(
                                              context,
                                              listen: false)
                                              .updateAttendance(
                                              aContext,
                                              index,
                                              status,
                                              statusId,
                                              reasonController.text,
                                              FK_InOutSignID,
                                              checkInSelectedDateFormat,
                                              checkOutTime);
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Request approved successfully"
                                                  .tr(),
                                              context,
                                              isError: false);
                                        } else if (isDecision == "0") {
                                          Provider.of<AttendanceProvider>(
                                              context,
                                              listen: false)
                                              .updateAttendance(
                                              aContext,
                                              index,
                                              status,
                                              statusId,
                                              reasonController.text,
                                              FK_InOutSignID,
                                              chechInDate,
                                              checkOutTime);
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Request approved successfully"
                                                  .tr(),
                                              context,
                                              isError: false);
                                        } else {
                                          Navigator.pop(context);
                                          showCustomSnackBar(
                                              "Please put the date time".tr(),
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

  Widget ShowEmpCard({Key? key, required BuildContext context, required String Qr_code}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: kBgColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: context.height(),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Consumer<ProfileProvider>(
                          builder: (context, profileProvider, child) {
                            String base = profileProvider.getEmpUsername();
                            String baseA = profileProvider.getEmpUsernameA();
                            String firstWord = base.substring(0, base.indexOf(" "));
                            String firstWordA =
                            baseA.substring(0, baseA.indexOf(" "));
                            String lastWord = base.substring(base.indexOf(' ') + 1);
                            String lastWordA =
                            baseA.substring(baseA.indexOf(' ') + 1);
                            Uint8List EmpImg =
                            Uint8List.fromList([0, 2, 5, 7, 42, 255]);
                            String EmpImgOrig =
                            profileProvider.getEmpProfilePhoto();
                            if (EmpImgOrig == "") {
                              EmpImgOrig =
                              'https://www.w3schools.com/howto/img_avatar.png';
                            }
                            if (!EmpImgOrig.startsWith("https")) {
                              EmpImg = base64Decode(
                                  profileProvider.getEmpProfilePhoto());
                              //profileProvider.notifyAll();
                            }
                            return Container(
                              padding: const EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: kTitleColor,
                                    width: 0.8,
                                  )),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    children: [
                                      // SizedBox(
                                      //   width: 5.0,
                                      // ),
                                      SizedBox(
                                        width: 120,
                                        child: EmpImgOrig.startsWith("http")
                                            ? CachedNetworkImage(
                                          imageUrl: EmpImgOrig,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                              Container(
                                                width: 100.0,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                        )
                                            : Container(
                                          width: 120,
                                          height: 120,
                                          //padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(9.0),
                                              border: Border.all(
                                                  color: Colors.white)),
                                          child: Image.memory(
                                            Uint8List.fromList(EmpImg),
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 5.0,
                                      ),
                                      Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'FirstName :  '.tr(),
                                                    style: kTextStyle.copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.normal),
                                                  ),
                                                  Text(
                                                    profileProvider.authRepo
                                                        .getLang() ==
                                                        'ar'
                                                        ? firstWordA
                                                        : firstWord,
                                                    style: kTextStyle.copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'LastName :  '.tr(),
                                                    style: kTextStyle.copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.normal),
                                                  ),
                                                  Text(
                                                    profileProvider.authRepo
                                                        .getLang() ==
                                                        'ar'
                                                        ? lastWordA
                                                        : lastWord,
                                                    style: kTextStyle.copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Location :     '.tr(),
                                                    style: kTextStyle.copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.normal),
                                                  ),
                                                  Text(
                                                    profileProvider.authRepo
                                                        .getLang() ==
                                                        'ar'
                                                        ? profileProvider
                                                        .getEmpLocationA()
                                                        : profileProvider
                                                        .getEmpLocationE(),
                                                    style: kTextStyle.copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Position :      '.tr(),
                                                    style: kTextStyle.copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.normal),
                                                  ),
                                                  Text(
                                                    profileProvider.authRepo
                                                        .getLang() ==
                                                        'ar'
                                                        ? profileProvider
                                                        .getEmpPositionA()
                                                        : profileProvider
                                                        .getEmpPositionE(),
                                                    style: kTextStyle.copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Code :             '.tr(),
                                                    style: kTextStyle.copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.normal),
                                                  ),
                                                  Text(
                                                    profileProvider.getEmpCode(),
                                                    style: kTextStyle.copyWith(
                                                        color: kRedColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  const Divider(
                                    thickness: 1.0,
                                    color: kGreyTextColor,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  //  Expanded(
                                  Center(
                                    child: SfBarcodeGenerator(
                                      value: Qr_code,
                                      symbology: QRCode(),
                                      showValue: false,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(19.0),
                                            bottomRight: Radius.circular(19.0)),
                                        color: kMainColor),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              profileProvider.getEmpCompanyName(),
                                              style: kTextStyle.copyWith(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Expanded(
                                            Text(
                                              'ID / Iqama No'.tr(),
                                              style: kTextStyle.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              profileProvider.getEmpIqamaNo(),
                                              style: kTextStyle.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> initAttendanceEmployee(BuildContext context, showProgress) async {
    var status = await Permission.locationWhenInUse.status;
    if (status != PermissionStatus.granted) {
      Future.delayed(Duration(milliseconds: 1)).then((value) async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => UtilsWidget().ShowLocationPermissionAlert(context));
        Provider.of<EmployeeProvider>(context, listen: false)
            .getEmployeeList(context, '');
        Provider.of<EmployeeProvider>(context, listen: false).clearData();
        showProgress = true;
      });
    } else {
      Future.delayed(Duration(milliseconds: 1)).then((value) async {
        Provider.of<EmployeeProvider>(context, listen: false)
            .getEmployeeList(context, '')
            .then((value) async {
          bool EmployeeListShow =
          await Provider.of<EmployeeProvider>(context, listen: false)
              .getEmployeeList(context, '');
          if (EmployeeListShow != true) {
            Provider.of<EmployeeProvider>(context, listen: false).showList =
            false;
          } else {
            Provider.of<EmployeeProvider>(context, listen: false).showList =
            true;
          }
        });
        Provider.of<EmployeeProvider>(context, listen: false).clearData();
        showProgress = true;
      });
    }
  }

}
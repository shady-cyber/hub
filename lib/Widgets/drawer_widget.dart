import 'dart:convert';
import 'dart:typed_data';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:hub/Admin/screens/Management/EmployeeManagement.dart';
import 'package:hub/Admin/screens/Management/PenaltyNotification.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Common/screens/Authentication/Select_Type.dart';
import 'package:hub/Common/screens/Authentication/Sign_In.dart';
import 'package:hub/Common/screens/CashInAdvance/CashInAdvanceScreen.dart';
import 'package:hub/Common/screens/Clearance/EmployeeClearance.dart';
import 'package:hub/Common/screens/GeneralRequest/GeneralRequestScreen.dart';
import 'package:hub/Common/screens/LanguageSelection/Language.dart';
import 'package:hub/Common/screens/Loan/EmployeeLoan.dart';
import 'package:hub/Common/screens/LoanDelay/EmployeeLoanDelay.dart';
import 'package:hub/Common/screens/Penalty/EmployeePenalty.dart';
import 'package:hub/Common/screens/PersonalInfo/EmployeeCard.dart';
import 'package:hub/Common/screens/PersonalInfo/ProfileScreen.dart';
import 'package:hub/Common/screens/PersonalInfo/SettingScreen.dart';
import 'package:hub/Common/screens/TermsAndConditions/PrivacyPolicy.dart';
import 'package:hub/Common/screens/TermsAndConditions/TermsOfServices.dart';
import 'package:hub/Common/screens/Vacation/RequestVacationScreen.dart';
import 'package:hub/Data/provider/account_provider.dart';
import 'package:hub/Data/provider/attendance_provider.dart';
import 'package:hub/Data/provider/penalty_provider.dart';
import 'package:hub/Employee/screens/Attendance/attendance.dart';
import 'package:share_plus/share_plus.dart';

class DrawerWidget extends ChangeNotifier {
  Widget appDrawerWidgets({required BuildContext context, required String type}) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 120,
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(top: 100),
              // decoration: const BoxDecoration(
              //   borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(30.0),
              //       topRight: Radius.circular(30.0)),
              //   color: Colors.white,
              // ),
              child: SingleChildScrollView(
                child: Consumer<AttendanceProvider>(
                    builder: (context, attendanceProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 40.0,
                          ),
                          type == "admin"
                              ? Visibility(
                            visible: true,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        const EmployeeManagement()
                                            .launch(context);
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
                                                  'assets/images/attendanceicon.png',
                                                ),
                                                width: 130,
                                                height: 150,
                                              ),
                                              padding:
                                              const EdgeInsets.all(12),
                                            ),
                                             Container(
                                              width: 160,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                  color: empCard,
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      bottomRight: Radius
                                                          .circular(15),
                                                      bottomLeft:
                                                      Radius.circular(
                                                          15))),
                                              child: Center(
                                                child: Text(
                                                  "Employee Management".tr(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.w700),
                                                ),
                                              ),

                                              //  padding: const EdgeInsets.all(12),
                                              //  padding: const EdgeInsets.all(12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        attendanceProvider.checkInWithQrCard(
                                            context: context);
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
                                                  'assets/images/qr_scanner.png',
                                                ),
                                                width: 130,
                                                height: 150,
                                              ),
                                              padding:
                                              const EdgeInsets.all(12),
                                            ),
                                            Container(
                                              width: 160,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xff474788),
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      bottomRight: Radius
                                                          .circular(15),
                                                      bottomLeft:
                                                      Radius.circular(
                                                          15))),
                                              child: Center(
                                                child: Text(
                                                  "Employee Card Scanner"
                                                      .tr(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.w700),
                                                ),
                                              ),

                                              // padding: const EdgeInsets.all(12),
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
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        const attendance().launch(context);
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
                                                  'assets/images/attendance1.png',
                                                ),
                                                width: 130,
                                                height: 150,
                                              ),
                                              padding:
                                              const EdgeInsets.all(12),
                                            ),
                                            Container(
                                              width: 160,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFF9972b3),
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      bottomRight: Radius
                                                          .circular(15),
                                                      bottomLeft:
                                                      Radius.circular(
                                                          15))),
                                              child: Center(
                                                child: Text(
                                                  "Employee Attendance".tr(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
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
                                        const RequestVacationScreen()
                                            .launch(context);
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
                                                  'assets/images/leave1.png',
                                                ),
                                                width: 130,
                                                height: 150,
                                              ),
                                              padding:
                                              const EdgeInsets.all(12),
                                            ),
                                            Container(
                                              width: 160,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFF47bab7),
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      bottomRight: Radius
                                                          .circular(15),
                                                      bottomLeft:
                                                      Radius.circular(
                                                          15))),
                                              child: Center(
                                                child: Text(
                                                  "Request Vacation".tr(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.w700),
                                                ),
                                              ),

                                              // padding: const EdgeInsets.all(12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                              : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      const attendance().launch(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.grey.withOpacity(0.3),
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
                                                'assets/images/attendance1.png',
                                              ),
                                              width: 130,
                                              height: 150,
                                            ),
                                            padding: const EdgeInsets.all(12),
                                          ),
                                          Container(
                                            width: 160,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFF9972b3),
                                                borderRadius:
                                                BorderRadius.only(
                                                    bottomRight:
                                                    Radius.circular(
                                                        15),
                                                    bottomLeft:
                                                    Radius.circular(
                                                        15))),
                                            child: Center(
                                              child: Text(
                                                "Employee Attendance".tr(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                            ),

                                            //  padding: const EdgeInsets.all(12),
                                            //  padding: const EdgeInsets.all(12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      const RequestVacationScreen()
                                          .launch(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.grey.withOpacity(0.3),
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
                                                'assets/images/leave1.png',
                                              ),
                                              width: 130,
                                              height: 150,
                                            ),
                                            padding: const EdgeInsets.all(12),
                                          ),
                                          Container(
                                            width: 160,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFF47bab7),
                                                borderRadius:
                                                BorderRadius.only(
                                                    bottomRight:
                                                    Radius.circular(
                                                        15),
                                                    bottomLeft:
                                                    Radius.circular(
                                                        15))),
                                            child: Center(
                                              child: Text(
                                                "Request Vacation".tr(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                            ),

                                            // padding: const EdgeInsets.all(12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  const EmployeeLoan().launch(context);
                                  //showCustomSnackBar('Under Development!', context, isError: true);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
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
                                            'assets/images/loanemp.png',
                                          ),
                                          width: 130,
                                          height: 150,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFF246E91),
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15))),
                                        child: Center(
                                          child: Text(
                                            "Employee Loan".tr(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  const GeneralRequestScreen().launch(context);
                                  //showCustomSnackBar('Under Development!', context, isError: true);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
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
                                            'assets/images/bounceemp.png',
                                          ),
                                          width: 130,
                                          height: 150,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Color(0xff12ae6e),
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15))),
                                        child: Center(
                                          child: Text(
                                            "General Request".tr(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  const EmployeeLoanDelay().launch(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
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
                                            'assets/images/loandelay.png',
                                          ),
                                          width: 130,
                                          height: 150,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Color(0xff7e3f01),
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15))),
                                        child: Center(
                                          child: Text(
                                            "LoanDelay Request".tr(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  const CashInAdvanceScreen().launch(context);
                                  // showCustomSnackBar('Under Development!', context, isError: true);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
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
                                            'assets/images/cashmoney.png',
                                          ),
                                          width: 130,
                                          height: 150,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Color(0xff84990d),
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15))),
                                        child: Center(
                                          child: Text(
                                            "Cash Requests".tr(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  const EmployeeClearance().launch(context);
                                  // showCustomSnackBar('Under Development!', context, isError: true);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
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
                                            'assets/images/clearance.png',
                                          ),
                                          width: 130,
                                          height: 150,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFFc30808),
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15))),
                                        child: Center(
                                          child: Text(
                                            "Employee Clearance".tr(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              type == "Employee"
                                  ? Visibility(
                                visible: true,
                                maintainSize: true,
                                maintainState: true,
                                maintainAnimation: true,
                                child: GestureDetector(
                                  onTap: () {
                                    const PenaltyNotification()
                                        .launch(context);
                                    // showCustomSnackBar('Under Development!', context, isError: true);
                                  },
                                  child: Stack(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.grey.withOpacity(0.3),
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
                                                'assets/images/penalty.png',
                                              ),
                                              width: 130,
                                              height: 150,
                                            ),
                                            padding: const EdgeInsets.all(12),
                                          ),
                                          Container(
                                            width: 160,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFF505050),
                                                borderRadius:
                                                BorderRadius.only(
                                                    bottomRight:
                                                    Radius.circular(
                                                        15),
                                                    bottomLeft:
                                                    Radius.circular(
                                                        15))),
                                            child: Center(
                                              child: Text(
                                                "Employee Penalty".tr(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Consumer(builder: (context,
                                        PenaltyProvider provider, child) {
                                      return Badge(
                                        showBadge: provider.showBadge,
                                        position: BadgePosition.bottomEnd(
                                            bottom: 8, end: 8),
                                        badgeContent: Text(
                                          provider
                                              .EmpPenaltyNotifiedData.length
                                              .toString(),
                                          style:
                                          TextStyle(color: Colors.white),
                                        ),
                                        child: IconButton(
                                          padding:
                                          EdgeInsets.only(right: 10.0),
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
                                ),
                              )
                                  : type == "admin"
                                  ? Visibility(
                                visible: true,
                                maintainSize: true,
                                maintainState: true,
                                maintainAnimation: true,
                                child: GestureDetector(
                                  onTap: () {
                                    const EmployeePenalty()
                                        .launch(context);
                                    // showCustomSnackBar('Under Development!', context, isError: true);
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
                                              'assets/images/penalty.png',
                                            ),
                                            width: 130,
                                            height: 150,
                                          ),
                                          padding:
                                          const EdgeInsets.all(12),
                                        ),
                                        Container(
                                          width: 160,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                              color: Color(0xFF505050),
                                              borderRadius:
                                              BorderRadius.only(
                                                  bottomRight: Radius
                                                      .circular(15),
                                                  bottomLeft:
                                                  Radius.circular(
                                                      15))),
                                          child: Center(
                                            child: Text(
                                              "Employee Penalty".tr(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                                  : Container(
                                width: 160,
                                height: 40,
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appDrawerEmployee({required BuildContext context}) {
    return Drawer(
      child:
      Consumer<AccountProvider>(builder: (context, accountProvider, child) {
        return ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: context.height() / 2.5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
                color: kMainColor,
              ),
              child: Consumer<AccountProvider>(
                  builder: (context, accountProvider, child) {
                    Uint8List EmpImg = Uint8List.fromList([0, 2, 5, 7, 42, 255]);
                    String EmpImgOrig =
                    accountProvider.authRepo.getEmpProfilePhoto();
                    if (EmpImgOrig == "") {
                      EmpImgOrig = 'https://www.w3schools.com/howto/img_avatar.png';
                    }
                    if (!EmpImgOrig.startsWith("https")) {
                      EmpImg = base64Decode(
                          accountProvider.authRepo.getEmpProfilePhoto());
                      // accountProvider.notifyAll();
                    }
                    return Column(
                      children: [
                        Container(
                          height: context.height() / 3.4,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 2, top: 12),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: EmpImgOrig.startsWith("http")
                                        ? CachedNetworkImage(
                                      imageUrl: EmpImgOrig,
                                      imageBuilder:
                                          (context, imageProvider) =>
                                          Container(
                                            width: 120,
                                            height: 120,
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
                                      padding:
                                      EdgeInsets.only(bottom: 2, top: 12),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20.0),
                                          border: Border.all(
                                              color: Colors.white)),
                                      child: Image.memory(
                                        Uint8List.fromList(EmpImg),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    accountProvider.authRepo.getLang() == 'ar'
                                        ? accountProvider.ArabicName
                                        : accountProvider.EnglishName,
                                    style: kTextStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Employee'.tr(),
                                    style:
                                    kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ],
                              ).onTap(() {
                                const ProfileScreen().launch(context);
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '00',
                                  style: kTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Presents'.tr(),
                                  style: kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '00',
                                  style: kTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Late'.tr(),
                                  style: kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '00',
                                  style: kTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Absent'.tr(),
                                  style: kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ListTile(
              onTap: () {
                const ProfileScreen().launch(context);
              },
              leading: const Icon(
                Icons.person,
                color: kGreyTextColor,
              ),
              title: Text(
                'Employee Profile'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const EmployeeCard().launch(context);
              },
              leading: const Icon(
                Icons.credit_card,
                color: kGreyTextColor,
              ),
              title: Text(
                'Employee Card'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const TermsOfServices().launch(context);
              },
              leading: const Icon(
                FontAwesomeIcons.infoCircle,
                color: kGreyTextColor,
              ),
              title: Text(
                'Terms of Services'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const PrivacyPolicy().launch(context);
              },
              leading: const Icon(
                Icons.dangerous_sharp,
                color: kGreyTextColor,
              ),
              title: Text(
                'Privacy Policy'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const Language().launch(context);
              },
              leading: const Icon(
                Icons.language,
                color: kGreyTextColor,
              ),
              title: Text(
                'Language'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                accountProvider.clearSharedData().then((condition) {
                  accountProvider.clearSharedType();
                  accountProvider.clearSharedUserName();
                  accountProvider.clearSharedEmpPhoto();

                  Navigator.pop(context);
                  if (accountProvider.authRepo.getConnectionString() == "") {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SelectType()),
                            (route) => false);
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SignIn()),
                            (route) => false);
                  }
                });
              },
              leading: const Icon(
                FontAwesomeIcons.signOutAlt,
                color: kGreyTextColor,
              ),
              title: Text(
                'Logout'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget appDrawerAdmin({required BuildContext context}) {
    return Drawer(
      child:
      Consumer<AccountProvider>(builder: (context, accountProvider, child) {
        return ListView(
          children: [
            Container(
              height: context.height() / 2.5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
                color: kMainColor,
              ),
              child: Consumer<AccountProvider>(
                  builder: (context, accountProvider, child) {
                    Uint8List EmpImg = Uint8List.fromList([0, 2, 5, 7, 42, 255]);
                    String EmpImgOrig =
                    accountProvider.authRepo.getEmpProfilePhoto();
                    if (EmpImgOrig == "") {
                      EmpImgOrig = 'https://www.w3schools.com/howto/img_avatar.png';
                    }
                    if (!EmpImgOrig.startsWith("https")) {
                      EmpImg = base64Decode(
                          accountProvider.authRepo.getEmpProfilePhoto());
                      //accountProvider.notifyAll();
                    }
                    return Column(
                      children: [
                        Container(
                          height: context.height() / 3.4,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 1, top: 20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 160,
                                    child: EmpImgOrig.startsWith("http")
                                        ? CachedNetworkImage(
                                      imageUrl: EmpImgOrig,
                                      imageBuilder:
                                          (context, imageProvider) =>
                                          Container(
                                            width: 160.0,
                                            height: 160.0,
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
                                      width: 160,
                                      height: 160,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20.0),
                                          border: Border.all(
                                              color: Colors.white)),
                                      child: Image.memory(
                                        Uint8List.fromList(EmpImg),
                                        // width: 130,
                                        // height: 130,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    accountProvider.authRepo.getLang() == 'ar'
                                        ? accountProvider.ArabicName
                                        : accountProvider.EnglishName,
                                    style: kTextStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Admin'.tr(),
                                    style:
                                    kTextStyle.copyWith(color: kGreyTextColor),
                                  ),
                                ],
                              ).onTap(() {
                                const ProfileScreen().launch(context);
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '0',
                                  style: kTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Employees'.tr(),
                                  style: kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '0',
                                  style: kTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Absent'.tr(),
                                  style: kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '0',
                                  style: kTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Presents'.tr(),
                                  style: kTextStyle.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ListTile(
              onTap: () {
                const ProfileScreen().launch(context);
              },
              leading: const Icon(
                Icons.person,
                color: kGreyTextColor,
              ),
              title: Text(
                'Employee Profile'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const EmployeeCard().launch(context);
              },
              leading: const Icon(
                Icons.credit_card,
                color: kGreyTextColor,
              ),
              title: Text(
                'Employee Card'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const SettingScreen().launch(context);
              },
              leading: const Icon(
                Icons.settings,
                color: kGreyTextColor,
              ),
              title: Text(
                'Settings'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () => Share.share('Google Play Store Link'.tr()),
              leading: const Icon(
                FontAwesomeIcons.userFriends,
                color: kGreyTextColor,
              ),
              title: Text(
                'Share App'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const TermsOfServices().launch(context);
              },
              leading: const Icon(
                FontAwesomeIcons.infoCircle,
                color: kGreyTextColor,
              ),
              title: Text(
                'Terms of Services'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const PrivacyPolicy().launch(context);
              },
              leading: const Icon(
                Icons.dangerous_sharp,
                color: kGreyTextColor,
              ),
              title: Text(
                'Privacy Policy'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                const Language().launch(context);
              },
              leading: const Icon(
                Icons.language,
                color: kGreyTextColor,
              ),
              title: Text(
                'Language'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
            ListTile(
              onTap: () {
                accountProvider.clearSharedData().then((condition) {
                  accountProvider.clearSharedType();
                  accountProvider.clearSharedUserName();
                  accountProvider.clearSharedUserNameA();
                  accountProvider.clearSharedEmpPhoto();

                  Navigator.pop(context);
                  if (accountProvider.authRepo.getConnectionString() == "") {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SelectType()),
                            (route) => false);
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SignIn()),
                            (route) => false);
                  }
                });
              },
              leading: const Icon(
                FontAwesomeIcons.signOutAlt,
                color: kGreyTextColor,
              ),
              title: Text(
                'Logout'.tr(),
                style: kTextStyle.copyWith(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: kGreyTextColor,
              ),
            ),
          ],
        );
      }),
    );
  }
}
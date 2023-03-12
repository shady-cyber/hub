import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:hub/Admin/screens/Management/DecisionAttendanceHistoryList.dart';
import 'package:hub/Admin/screens/Management/DecisionHistoryList.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Common/Util/shimmer.dart';
import 'package:hub/Data/provider/attendance_provider.dart';
import 'package:hub/Data/provider/vacation_provider.dart';

class HistoryWidget extends ChangeNotifier {
  Widget ShowEmpDecisionHistory({required BuildContext context, required bool ShowHistoryList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: Container(
            width: context.width(),
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: kBgColor,
            ),
            child: Consumer<VacationProvider>(
                builder: (context, vacationProvider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      vacationProvider.VacHistoryIsLoading
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
                        child: vacationProvider.ShowHistoryList
                            ? Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        child: ListView.builder(
                                          scrollDirection:
                                          Axis.vertical,
                                          shrinkWrap: true,
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          itemCount: vacationProvider
                                              .vacationHistoryList
                                              .length,
                                          itemBuilder: (context, i) {
                                            return SingleChildScrollView(
                                              physics:
                                              NeverScrollableScrollPhysics(),
                                              child: DecisionHistoryList(
                                                  vacationProvider
                                                      .vacationHistoryList[i],
                                                  i),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                            : Container(
                          width: MediaQuery.of(context).size.width,
                          height:
                          MediaQuery.of(context).size.height / 1.5,
                          child: Center(
                            child: Text(
                              'No History Yet'.tr(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }

  Widget ShowEmpDecisionAttendanceHistory({required BuildContext context, required bool ShowHistoryList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: Container(
            width: context.width(),
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: kBgColor,
            ),
            child: Consumer<AttendanceProvider>(
                builder: (context, attendanceProvider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      attendanceProvider.AttendanceHistoryIsLoading
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
                        child: ShowHistoryList
                            ? Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        child: ListView.builder(
                                          scrollDirection:
                                          Axis.vertical,
                                          shrinkWrap: true,
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          itemCount: attendanceProvider
                                              .attendanceHistoryList
                                              .length,
                                          itemBuilder: (context, i) {
                                            return SingleChildScrollView(
                                              physics:
                                              NeverScrollableScrollPhysics(),
                                              child: DecisionAttendanceHistoryList(
                                                  attendanceProvider
                                                      .attendanceHistoryList[i],
                                                  i),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                            : Container(
                          width: MediaQuery.of(context).size.width,
                          height:
                          MediaQuery.of(context).size.height / 1.5,
                          child: Center(
                            child: Text(
                              'No History Yet'.tr(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }

}
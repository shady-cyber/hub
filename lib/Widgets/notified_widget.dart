import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:hub/Admin/screens/Management/DesisionHistory.dart';
import 'package:hub/Common/Util/appConstatns.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Common/Util/shimmer.dart';
import 'package:hub/Data/provider/account_provider.dart';
import 'package:hub/Data/provider/cash_provider.dart';
import 'package:hub/Data/provider/general_req_provider.dart';
import 'package:hub/Data/provider/loan_delay_provider.dart';
import 'package:hub/Data/provider/loan_provider.dart';
import 'package:hub/Data/provider/penalty_provider.dart';
import 'package:hub/Widgets/requests_widget.dart';

class NotifiedWidget extends ChangeNotifier {
  Widget ShowLoanNotifiedList({required bool isApproved, required TextEditingController reasonController}) {
    return Consumer<LoanProvider>(builder: (context, loanProvider, child) {
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
                  loanProvider.isLoading
                      ? Container(
                    // child: Expanded(
                    //   flex: 1,
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
                                  // Expanded(
                                  //   child: Container(
                                  //     padding: EdgeInsets.only(left: 10),
                                  //     height: 8,
                                  //     color: Colors.grey,
                                  //   ),
                                  // ),
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
                    //   ),
                  )
                      : Visibility(
                    visible: true,
                    child: loanProvider.loanNotifyList.length != 0
                        ?
                    // Column(
                    //   children:[
                    //     Expanded(
                    //     flex: 1,
                    // child:
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height -
                            160,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount:
                          loanProvider.loanNotifyList.length,
                          itemBuilder: (context, i) {
                            String EmpImgOrig =
                                'https://www.w3schools.com/howto/img_avatar.png';
                            String xx = loanProvider
                                .loanNotifyList[i].RequestDate;
                            String reqDate = xx.substring(0, 10);
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  DecisionHistory(
                                      vacationId: loanProvider
                                          .loanNotifyList[i]
                                          .LoanRequestID,
                                      type: 'loan')
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
                                        width: 0.5,
                                      )),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ListTile(
                                        onTap: () {},
                                        leading: SizedBox(
                                          width: 50,
                                          child: CachedNetworkImage(
                                            imageUrl: EmpImgOrig,
                                            imageBuilder: (context,
                                                imageProvider) =>
                                                Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration:
                                                  BoxDecoration(
                                                    shape:
                                                    BoxShape.circle,
                                                    image:
                                                    DecorationImage(
                                                      image:
                                                      imageProvider,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                          ),
                                        ),
                                        title: Text(
                                          Provider.of<AccountProvider>(
                                              context,
                                              listen:
                                              false)
                                              .authRepo
                                              .getLang() ==
                                              'ar'
                                              ? loanProvider
                                              .loanNotifyList[i]
                                              .EmpNameA
                                              : loanProvider
                                              .loanNotifyList[i]
                                              .EmpNameE,
                                          style: kTextStyle,
                                        ),
                                        subtitle: Text(
                                          'Employee'.tr(),
                                          style: kTextStyle.copyWith(
                                              color:
                                              kGreyTextColor),
                                        ),
                                        trailing: Container(
                                          height: 50.0,
                                          width: 90.0,
                                          padding:
                                          const EdgeInsets.all(
                                              2.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(10.0),
                                            color: kMainColor
                                                .withOpacity(0.08),
                                          ),
                                          child: Center(
                                            child: Text(
                                              Provider.of<AccountProvider>(
                                                  context,
                                                  listen:
                                                  false)
                                                  .authRepo
                                                  .getLang() ==
                                                  'ar'
                                                  ? loanProvider
                                                  .loanNotifyList[
                                              i]
                                                  .StatusA
                                                  : loanProvider
                                                  .loanNotifyList[
                                              i]
                                                  .StatusE,
                                              textAlign:
                                              TextAlign.center,
                                              style: TextStyle(
                                                  color: VacColor,
                                                  fontSize: 12,
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.only(
                                                left: 10,
                                                right: 10),
                                            child: Row(
                                              mainAxisSize:
                                              MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  'Amount'.tr(),
                                                  style: kTextStyle.copyWith(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Text(
                                                  'LoanDate'.tr(),
                                                  style: kTextStyle.copyWith(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Text(
                                                  'Loan Reason'
                                                      .tr(),
                                                  style: kTextStyle.copyWith(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1.0,
                                            color: kGreyTextColor,
                                          ),
                                          // const SizedBox(
                                          //   width: 20.0,
                                          // ),
                                          Row(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                loanProvider
                                                    .loanNotifyList[
                                                i]
                                                    .LoanAmount,
                                                style: kTextStyle
                                                    .copyWith(
                                                    color:
                                                    kGreyTextColor),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 25.0,
                                                    right:
                                                    25.0),
                                                child: Text(
                                                  reqDate,
                                                  style: kTextStyle
                                                      .copyWith(
                                                      color:
                                                      kGreyTextColor),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                EdgeInsets.only(
                                                    left: 40.0),
                                                child: Text(
                                                  loanProvider
                                                      .loanNotifyList[
                                                  i]
                                                      .LoanReason,
                                                  style: kTextStyle
                                                      .copyWith(
                                                      color:
                                                      kGreyTextColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      loanProvider.loanNotifyList[i]
                                          .IsApprove ==
                                          "1"
                                          ? Visibility(
                                        visible: !isApproved,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                RequestsWidget().showLoanSheet(context,
                                                    i,
                                                    "2",
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
                                                    top: 10.0,
                                                    bottom:
                                                    10.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        15.0),
                                                    color:
                                                    kMainColor),
                                                child: Center(
                                                  child: Text(
                                                    'Approve'
                                                        .tr(),
                                                    style: kTextStyle.copyWith(
                                                        color:
                                                        Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                width: 10.0),
                                            GestureDetector(
                                              onTap: () {
                                                RequestsWidget()
                                                    .showLoanSheet(
                                                    context,
                                                    i,
                                                    "3",
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
                                                    top: 10.0,
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
                                                child: Center(
                                                  child: Text(
                                                    'Reject'
                                                        .tr(),
                                                    style: kTextStyle.copyWith(
                                                        color:
                                                        kAlertColor),
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
                                          loanProvider
                                              .loanNotifyList[
                                          i]
                                              .StatusE ==
                                              "Pending"
                                              ? GestureDetector(
                                            onTap:
                                                () async {
                                              loanProvider.updateLoan(
                                                  context,
                                                  i,
                                                  "2",
                                                  "Notified");
                                            },
                                            child:
                                            Container(
                                              width:
                                              120,
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
                                                BorderRadius.circular(15.0),
                                                color:
                                                kMainColor,
                                              ),
                                              child:
                                              Center(
                                                child:
                                                Text(
                                                  'Notify'
                                                      .tr(),
                                                  style:
                                                  kTextStyle.copyWith(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                              : Text(
                                            loanProvider.loanNotifyList[i].StatusE ==
                                                "Pending"
                                                ? "Notified"
                                                : loanProvider
                                                .loanNotifyList[i]
                                                .StatusA,
                                            style: TextStyle(
                                                color:
                                                kGreenColor,
                                                fontSize:
                                                15,
                                                fontWeight:
                                                FontWeight.bold),
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
                    )
                    //  )
                    //   ])
                        : Container(
                      width: MediaQuery.of(context).size.width,
                      height:
                      MediaQuery.of(context).size.height / 1.5,
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

  Widget ShowLoanDelayNotifiedList({required bool isApproved, required TextEditingController reasonController}) {
    return Consumer<LoanDelayProvider>(
        builder: (context, loanDelayProvider, child) {
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
                      loanDelayProvider.isLoading
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
                        loanDelayProvider.loanDelayNotifiedList.length !=
                            0
                            ? Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context)
                                  .size
                                  .height -
                                  150,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: loanDelayProvider
                                    .loanDelayNotifiedList.length,
                                itemBuilder: (context, i) {
                                  String EmpImgOrig =
                                      'https://www.w3schools.com/howto/img_avatar.png';
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        DecisionHistory(
                                            vacationId: loanDelayProvider
                                                .loanDelayNotifiedList[
                                            i]
                                                .EmployeeLoanDelayRequestID,
                                            type: 'loan_delay')
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
                                                child:
                                                CachedNetworkImage(
                                                  imageUrl:
                                                  EmpImgOrig,
                                                  imageBuilder:
                                                      (context,
                                                      imageProvider) =>
                                                      Container(
                                                        width: 50.0,
                                                        height: 50.0,
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
                                                ),
                                              ),
                                              title: Text(
                                                Provider.of<AccountProvider>(
                                                    context,
                                                    listen:
                                                    false)
                                                    .authRepo
                                                    .getLang() ==
                                                    'ar'
                                                    ? loanDelayProvider
                                                    .loanDelayNotifiedList[
                                                i]
                                                    .EmpNameA
                                                    : loanDelayProvider
                                                    .loanDelayNotifiedList[
                                                i]
                                                    .EmpNameE,
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
                                                        ? loanDelayProvider
                                                        .loanDelayNotifiedList[
                                                    i]
                                                        .LoanDescA
                                                        : loanDelayProvider
                                                        .loanDelayNotifiedList[
                                                    i]
                                                        .LoanDescE,
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
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets
                                                      .only(
                                                      left: 60,
                                                      right:
                                                      60),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize
                                                        .max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'AmountPerMonth'
                                                            .tr(),
                                                        style: kTextStyle.copyWith(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      ),
                                                      Text(
                                                        'MonthName'
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
                                                Padding(
                                                  padding: EdgeInsets
                                                      .only(
                                                      left: 100,
                                                      right:
                                                      90),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize
                                                        .max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                        loanDelayProvider
                                                            .loanDelayNotifiedList[
                                                        i]
                                                            .AmountPerMonth,
                                                        style: kTextStyle
                                                            .copyWith(
                                                            color:
                                                            kGreyTextColor),
                                                      ),
                                                      Text(
                                                        loanDelayProvider
                                                            .loanDelayNotifiedList[
                                                        i]
                                                            .MonthName,
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
                                            loanDelayProvider
                                                .loanDelayNotifiedList[
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
                                                    onTap:
                                                        () {
                                                          RequestsWidget().showLoanDelaySheet(
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
                                                          RequestsWidget().showLoanDelaySheet(
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
                                                loanDelayProvider
                                                    .loanDelayNotifiedList[i]
                                                    .StatusE ==
                                                    "Pending"
                                                    ? GestureDetector(
                                                  onTap:
                                                      () async {
                                                    loanDelayProvider.updateLoanDelay(
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
                                                  loanDelayProvider.loanDelayNotifiedList[i].StatusE == "Pending"
                                                      ? "Notified"
                                                      : loanDelayProvider.loanDelayNotifiedList[i].StatusA,
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

  Widget ShowGeneralNotifiedList({required bool isApproved, required TextEditingController reasonController}) {
    return Consumer<GeneralRequestProvider>(
        builder: (context, generalRequestProvider, child) {
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
                      generalRequestProvider.isLoading
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
                        generalRequestProvider
                            .generalNotifiedList.length !=
                            0
                            ? Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context)
                                  .size
                                  .height -
                                  150,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: generalRequestProvider
                                    .generalNotifiedList.length,
                                itemBuilder: (context, i) {
                                  String EmpImgOrig =
                                      'https://www.w3schools.com/howto/img_avatar.png';
                                  String xx = generalRequestProvider
                                      .generalNotifiedList[i]
                                      .RequestDate;
                                  String reqDate =
                                  xx.substring(0, 10);
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        DecisionHistory(
                                            vacationId:
                                            generalRequestProvider
                                                .generalNotifiedList[
                                            i]
                                                .RequestID
                                                .toString(),
                                            type: 'general')
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
                                                child:
                                                CachedNetworkImage(
                                                  imageUrl:
                                                  EmpImgOrig,
                                                  imageBuilder:
                                                      (context,
                                                      imageProvider) =>
                                                      Container(
                                                        width: 50.0,
                                                        height: 50.0,
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
                                                ),
                                              ),
                                              title: Text(
                                                Provider.of<AccountProvider>(
                                                    context,
                                                    listen:
                                                    false)
                                                    .authRepo
                                                    .getLang() ==
                                                    'ar'
                                                    ? generalRequestProvider
                                                    .generalNotifiedList[
                                                i]
                                                    .EmpNameA
                                                    : generalRequestProvider
                                                    .generalNotifiedList[
                                                i]
                                                    .EmpNameE,
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
                                                        ? generalRequestProvider
                                                        .generalNotifiedList[
                                                    i]
                                                        .StatusA
                                                        : generalRequestProvider
                                                        .generalNotifiedList[
                                                    i]
                                                        .StatusE,
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
                                              MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets
                                                      .only(
                                                      left: 80,
                                                      right:
                                                      80),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    mainAxisSize:
                                                    MainAxisSize
                                                        .max,
                                                    children: [
                                                      Text(
                                                        'Title'
                                                            .tr(),
                                                        style: kTextStyle.copyWith(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      ),
                                                      Text(
                                                        'Details'
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
                                                Padding(
                                                  padding: EdgeInsets
                                                      .only(
                                                      left: 80,
                                                      right:
                                                      80),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    mainAxisSize:
                                                    MainAxisSize
                                                        .max,
                                                    children: [
                                                      Text(
                                                        generalRequestProvider
                                                            .generalNotifiedList[
                                                        i]
                                                            .RequestTitle,
                                                        style: kTextStyle
                                                            .copyWith(
                                                            color:
                                                            kGreyTextColor),
                                                      ),
                                                      Text(
                                                        generalRequestProvider
                                                            .generalNotifiedList[
                                                        i]
                                                            .RequestDetails,
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
                                            generalRequestProvider
                                                .generalNotifiedList[
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
                                                    onTap:
                                                        () {
                                                          RequestsWidget().showGeneralSheet(
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
                                                          RequestsWidget().showGeneralSheet(
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
                                                generalRequestProvider
                                                    .generalNotifiedList[i]
                                                    .StatusE ==
                                                    "Pending"
                                                    ? GestureDetector(
                                                  onTap:
                                                      () async {
                                                    generalRequestProvider.updateGeneral(
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
                                                  generalRequestProvider.generalNotifiedList[i].StatusE == "Pending"
                                                      ? "Notified"
                                                      : generalRequestProvider.generalNotifiedList[i].StatusA,
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

  Widget ShowCashNotifiedList({required bool isApproved, required TextEditingController reasonController}) {
    return Consumer<CashProvider>(builder: (context, cashProvider, child) {
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
                  cashProvider.isLoading
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
                    child: cashProvider.cashNotifiedList.length != 0
                        ? Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height:
                          MediaQuery.of(context).size.height -
                              150,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: cashProvider
                                .cashNotifiedList.length,
                            itemBuilder: (context, i) {
                              String EmpImgOrig =
                                  'https://www.w3schools.com/howto/img_avatar.png';
                              String xx = cashProvider
                                  .cashNotifiedList[i].RequestDate;
                              String reqDate = xx.substring(0,
                                  10); // Starts from 5 and goes to 10
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    DecisionHistory(
                                        vacationId: cashProvider
                                            .cashNotifiedList[i]
                                            .EmpCashRequestID,
                                        type: 'cash')
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
                                            child:
                                            CachedNetworkImage(
                                              imageUrl: EmpImgOrig,
                                              imageBuilder: (context,
                                                  imageProvider) =>
                                                  Container(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    decoration:
                                                    BoxDecoration(
                                                      shape: BoxShape
                                                          .circle,
                                                      image:
                                                      DecorationImage(
                                                        image:
                                                        imageProvider,
                                                        fit:
                                                        BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          ),
                                          title: Text(
                                            Provider.of<AccountProvider>(
                                                context,
                                                listen:
                                                false)
                                                .authRepo
                                                .getLang() ==
                                                'ar'
                                                ? cashProvider
                                                .cashNotifiedList[
                                            i]
                                                .EmpNameA
                                                : cashProvider
                                                .cashNotifiedList[
                                            i]
                                                .EmpNameE,
                                            style: kTextStyle,
                                          ),
                                          subtitle: Text(
                                            'Employee'.tr(),
                                            style: kTextStyle.copyWith(
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
                                                'Cash Request'.tr(),
                                                textAlign: TextAlign
                                                    .center,
                                                style: TextStyle(
                                                    color: VacColor,
                                                    fontSize: 12,
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
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsets.only(
                                                  left: 50,
                                                  right: 50),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                mainAxisSize:
                                                MainAxisSize
                                                    .max,
                                                children: [
                                                  Text(
                                                    'Amount'.tr(),
                                                    style: kTextStyle.copyWith(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                  Text(
                                                    'RequestDate'
                                                        .tr(),
                                                    style: kTextStyle.copyWith(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 1.0,
                                              color: kGreyTextColor,
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.only(
                                                  left: 55,
                                                  right: 50),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                mainAxisSize:
                                                MainAxisSize
                                                    .max,
                                                children: [
                                                  Text(
                                                    cashProvider
                                                        .cashNotifiedList[
                                                    i]
                                                        .LoanAmount,
                                                    style: kTextStyle
                                                        .copyWith(
                                                        color:
                                                        kGreyTextColor),
                                                  ),
                                                  Text(
                                                    reqDate,
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
                                        cashProvider
                                            .cashNotifiedList[
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
                                                  RequestsWidget().showCashSheet(
                                                      context,
                                                      i,
                                                      "2",
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
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                      color:
                                                      kMainColor),
                                                  child:
                                                  Center(
                                                    child:
                                                    Text(
                                                      'Approve'
                                                          .tr(),
                                                      style: kTextStyle.copyWith(
                                                          color:
                                                          Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                  width:
                                                  10.0),
                                              GestureDetector(
                                                onTap: () {
                                                  RequestsWidget().showCashSheet(
                                                      context,
                                                      i,
                                                      "3",
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
                                                      style: kTextStyle.copyWith(
                                                          color:
                                                          kAlertColor),
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
                                            cashProvider
                                                .cashNotifiedList[
                                            i]
                                                .StatusE ==
                                                "Pending"
                                                ? GestureDetector(
                                              onTap:
                                                  () async {
                                                cashProvider.updateCash(
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
                                                    kTextStyle.copyWith(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                                : Text(
                                              cashProvider.cashNotifiedList[i].StatusE ==
                                                  "Pending"
                                                  ? "Notified"
                                                  : cashProvider
                                                  .cashNotifiedList[i]
                                                  .StatusA,
                                              style: TextStyle(
                                                  color:
                                                  kGreenColor,
                                                  fontSize:
                                                  15,
                                                  fontWeight:
                                                  FontWeight.bold),
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
                      MediaQuery.of(context).size.height / 1.5,
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

  Widget ShowPenaltyNotifiedList({required bool isApproved, required TextEditingController reasonController}) {
    return Consumer<PenaltyProvider>(
        builder: (context, penaltyProvider, child) {
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
                      penaltyProvider.isLoading
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
                        child: penaltyProvider.PenaltyNotifiedData.length != 0
                            ? Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              height:
                              MediaQuery.of(context).size.height -
                                  150,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: penaltyProvider
                                    .PenaltyNotifiedData.length,
                                itemBuilder: (context, i) {
                                  String EmpImgOrig =
                                      'https://www.w3schools.com/howto/img_avatar.png';
                                  String xx = penaltyProvider
                                      .PenaltyNotifiedData[i]
                                      .RequestDate;
                                  String reqDate = xx.substring(0,
                                      10); // Starts from 5 and goes to 10
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        DecisionHistory(
                                            vacationId: penaltyProvider
                                                .PenaltyNotifiedData[
                                            i]
                                                .PenaltyRequestID
                                                .toString(),
                                            type: 'penalty')
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
                                                child:
                                                CachedNetworkImage(
                                                  imageUrl: EmpImgOrig,
                                                  imageBuilder: (context,
                                                      imageProvider) =>
                                                      Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                        BoxDecoration(
                                                          shape: BoxShape
                                                              .circle,
                                                          image:
                                                          DecorationImage(
                                                            image:
                                                            imageProvider,
                                                            fit:
                                                            BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                ),
                                              ),
                                              title: Text(
                                                Provider.of<AccountProvider>(
                                                    context,
                                                    listen:
                                                    false)
                                                    .authRepo
                                                    .getLang() ==
                                                    'ar'
                                                    ? penaltyProvider
                                                    .PenaltyNotifiedData[
                                                i]
                                                    .EmpNameA
                                                    : penaltyProvider
                                                    .PenaltyNotifiedData[
                                                i]
                                                    .EmpNameE,
                                                style: kTextStyle,
                                              ),
                                              subtitle: Text(
                                                'Employee'.tr(),
                                                style: kTextStyle.copyWith(
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
                                                    reqDate,
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                        color: VacColor,
                                                        fontSize: 12,
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
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 140,
                                                      right: 140),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Penalty'
                                                              .tr(),
                                                          style: kTextStyle.copyWith(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
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
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .only(
                                                          left: 30,
                                                          right:
                                                          30),
                                                      child: SizedBox(
                                                        width: 300,
                                                        child: Text(
                                                          Provider.of<AccountProvider>(context, listen: false)
                                                              .authRepo
                                                              .getLang() ==
                                                              'ar'
                                                              ? penaltyProvider
                                                              .PenaltyNotifiedData[
                                                          i]
                                                              .PenalityDescA
                                                              : penaltyProvider
                                                              .PenaltyNotifiedData[
                                                          i]
                                                              .PenalityDescE,
                                                          maxLines: 3,
                                                          style:
                                                          TextStyle(
                                                            fontSize:
                                                            12,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                          ),
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
                                            penaltyProvider
                                                .PenaltyNotifiedData[
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
                                                      RequestsWidget().showPenaltySheet(
                                                          context,
                                                          i,
                                                          "2",
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
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                          color:
                                                          kMainColor),
                                                      child:
                                                      Center(
                                                        child:
                                                        Text(
                                                          'Approve'
                                                              .tr(),
                                                          style: kTextStyle.copyWith(
                                                              color:
                                                              Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      width:
                                                      10.0),
                                                  GestureDetector(
                                                    onTap: () {
                                                      RequestsWidget().showPenaltySheet(
                                                          context,
                                                          i,
                                                          "3",
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
                                                          style: kTextStyle.copyWith(
                                                              color:
                                                              kAlertColor),
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
                                                penaltyProvider
                                                    .PenaltyNotifiedData[
                                                i]
                                                    .StatusE ==
                                                    "Pending"
                                                    ? GestureDetector(
                                                  onTap:
                                                      () async {
                                                    penaltyProvider.updatePenalty(
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
                                                        kTextStyle.copyWith(color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                    : Text(
                                                  penaltyProvider.PenaltyNotifiedData[i].StatusE ==
                                                      "Pending"
                                                      ? "Notified"
                                                      : penaltyProvider
                                                      .PenaltyNotifiedData[i]
                                                      .StatusA,
                                                  style: TextStyle(
                                                      color:
                                                      kGreenColor,
                                                      fontSize:
                                                      15,
                                                      fontWeight:
                                                      FontWeight.bold),
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
                          MediaQuery.of(context).size.height / 1.5,
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

  Widget ShowEmpPenaltyNotifiedList({required bool isApproved, required TextEditingController reasonController}) {
    return Consumer<PenaltyProvider>(
        builder: (context, penaltyProvider, child) {
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
                      penaltyProvider.isLoading
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
                        child: penaltyProvider
                            .EmpPenaltyNotifiedData.length !=
                            0
                            ? Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              height:
                              MediaQuery.of(context).size.height -
                                  150,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: penaltyProvider
                                    .EmpPenaltyNotifiedData.length,
                                itemBuilder: (context, i) {
                                  String EmpImgOrig =
                                      'https://www.w3schools.com/howto/img_avatar.png';
                                  String xx = penaltyProvider
                                      .EmpPenaltyNotifiedData[i]
                                      .RequestDate;
                                  String reqDate = xx.substring(0,
                                      10); // Starts from 5 and goes to 10
                                  dynamic Arabic_name = Provider.of<
                                      AccountProvider>(context,
                                      listen: false)
                                      .authRepo
                                      .sharedPreferences
                                      .getString(
                                      AppConstants.EMP_ARABIC_NAME);
                                  dynamic English_name =
                                  Provider.of<AccountProvider>(
                                      context,
                                      listen: false)
                                      .authRepo
                                      .sharedPreferences
                                      .getString(AppConstants
                                      .EMP_ENGLISH_NAME);
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0),
                                    child: GestureDetector(
                                      onTap: () {},
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
                                                child:
                                                CachedNetworkImage(
                                                  imageUrl: EmpImgOrig,
                                                  imageBuilder: (context,
                                                      imageProvider) =>
                                                      Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                        BoxDecoration(
                                                          shape: BoxShape
                                                              .circle,
                                                          image:
                                                          DecorationImage(
                                                            image:
                                                            imageProvider,
                                                            fit:
                                                            BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                ),
                                              ),
                                              title: Text(
                                                Provider.of<AccountProvider>(
                                                    context,
                                                    listen:
                                                    false)
                                                    .authRepo
                                                    .getLang() ==
                                                    'ar'
                                                    ? Arabic_name
                                                    : English_name,
                                                style: kTextStyle,
                                              ),
                                              subtitle: Text(
                                                'Employee'.tr(),
                                                style: kTextStyle.copyWith(
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
                                                    reqDate,
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                        color: VacColor,
                                                        fontSize: 12,
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
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 140,
                                                      right: 140),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Penalty'
                                                              .tr(),
                                                          style: kTextStyle.copyWith(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
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
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .only(
                                                          left: 30,
                                                          right:
                                                          30),
                                                      child: SizedBox(
                                                        width: 300,
                                                        child: Text(
                                                          Provider.of<AccountProvider>(context, listen: false)
                                                              .authRepo
                                                              .getLang() ==
                                                              'ar'
                                                              ? penaltyProvider
                                                              .EmpPenaltyNotifiedData[
                                                          i]
                                                              .PenalityDescA
                                                              : penaltyProvider
                                                              .EmpPenaltyNotifiedData[
                                                          i]
                                                              .PenalityDescE,
                                                          maxLines: 3,
                                                          style:
                                                          TextStyle(
                                                            fontSize:
                                                            12,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                          ),
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
                          MediaQuery.of(context).size.height / 1.5,
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

}
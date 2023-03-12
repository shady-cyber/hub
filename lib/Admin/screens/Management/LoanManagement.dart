import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Data/provider/loan_provider.dart';
import 'package:hub/Widgets/notified_widget.dart';

class LoanManagement extends StatefulWidget {
  const LoanManagement({Key? key}) : super(key: key);

  @override
  _LoanManagementState createState() => _LoanManagementState();
}

class _LoanManagementState extends State<LoanManagement> {
  bool isApproved = false;
  final reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      Provider.of<LoanProvider>(context, listen: false).getLoanNotifiedList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Loan List'.tr(),
          maxLines: 2,
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: NotifiedWidget().ShowLoanNotifiedList(isApproved: isApproved, reasonController: reasonController),
    );
  }
}

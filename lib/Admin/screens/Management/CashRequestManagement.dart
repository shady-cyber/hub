import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 import 'package:hub/Data/provider/cash_provider.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Widgets/notified_widget.dart';

class CashRequestManagement extends StatefulWidget {
  const CashRequestManagement({Key? key}) : super(key: key);

  @override
  _CashRequestManagementState createState() => _CashRequestManagementState();
}

class _CashRequestManagementState extends State<CashRequestManagement> {
  bool isApproved = false;
  final reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      Provider.of<CashProvider>(context, listen: false).getCashNotifiedList();
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
          'Cash Request List'.tr(),
          maxLines: 2,
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: NotifiedWidget().ShowCashNotifiedList(isApproved: isApproved, reasonController: reasonController),
    );
  }
}

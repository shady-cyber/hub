import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Data/provider/penalty_provider.dart';
import 'package:hub/Widgets/notified_widget.dart';

class PenaltyManagement extends StatefulWidget {
  const PenaltyManagement({Key? key}) : super(key: key);

  @override
  _PenaltyManagementState createState() => _PenaltyManagementState();
}

class _PenaltyManagementState extends State<PenaltyManagement> {
  bool isApproved = false;
  final reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      Provider.of<PenaltyProvider>(context, listen: false).getPenaltyNotifiedList();
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
          'Penalty List'.tr(),
          maxLines: 2,
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: NotifiedWidget().ShowPenaltyNotifiedList(isApproved: isApproved, reasonController: reasonController),
    );
  }
}

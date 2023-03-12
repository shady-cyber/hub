import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Data/provider/general_req_provider.dart';
import 'package:hub/Widgets/notified_widget.dart';

class GeneralRequestManagement extends StatefulWidget {
  const GeneralRequestManagement({Key? key}) : super(key: key);

  @override
  _GeneralRequestManagementState createState() => _GeneralRequestManagementState();
}

class _GeneralRequestManagementState extends State<GeneralRequestManagement> {
  bool isApproved = false;
  final reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      Provider.of<GeneralRequestProvider>(context, listen: false).getGeneralNotifiedList();
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
          'General Request List'.tr(),
          maxLines: 2,
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: NotifiedWidget().ShowGeneralNotifiedList(isApproved: isApproved, reasonController: reasonController),
    );
  }
}

import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:hub/Common/screens/notification/SVNotificationFragment.dart';
import 'package:hub/Data/provider/notification_provider.dart';
import 'package:hub/Data/provider/account_provider.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Widgets/decoration_widget.dart';
import 'package:hub/Widgets/drawer_widget.dart';

import '../../../Common/screens/Authentication/background2.dart';
import '../../../Data/provider/penalty_provider.dart';

class HomeScreenEmployee extends StatefulWidget {
  const HomeScreenEmployee({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenEmployee> {
  bool isChecked = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1)).then((value) async {
      await Provider.of<NotificationProvider>(context, listen: false)
          .initFirebasePushNotification(context);
      await Provider.of<NotificationProvider>(context, listen: false)
          .NotificationCount();
      try {
        await Provider.of<AccountProvider>(context, listen: false)
            .reloadUsername()
            .then((value) {
          Provider
              .of<AccountProvider>(context, listen: false)
              .EnglishName =
              Provider.of<AccountProvider>(context, listen: false)
                  .getEmpUsername();
          Provider
              .of<AccountProvider>(context, listen: false)
              .ArabicName = Provider.of<AccountProvider>(context, listen: false)
              .getEmpUsernameA();
          Provider.of<AccountProvider>(context, listen: false).notifyAll();
        });
        Provider.of<PenaltyProvider>(context, listen: false)
            .getEmpPenaltyNotifiedList();
      }catch(e){}
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return DecorationWidget().showDialogExit(context: context);
            });

        return value == true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
       // backgroundColor: kMainColor,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          titleSpacing: 5.0,
          toolbarHeight: 80,
          iconTheme: const IconThemeData(color: Colors.black26),
          title: Consumer<AccountProvider>(
              builder: (context, authProvider, child) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.authRepo.getLang() == 'ar' ?
                          authProvider.ArabicName
                              : authProvider.EnglishName,
                        maxLines: 2,
                        style: kTextStyle.copyWith(
                            color: Colors.black45,
                            fontSize: 18.0,
                            fontFamily: 'Robot',
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'You are welcome'.tr(),
                        maxLines: 2,
                        style: kTextStyle.copyWith(
                            color: Colors.black45,
                            fontSize: 15.0,
                            fontFamily: 'Robot',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
              }),
          actions: [
            Consumer(builder: (context, NotificationProvider provider, child) {
              return Badge(
                showBadge: provider.showBadge,
                position: BadgePosition.topEnd(top: 15, end: 9),
                badgeContent: Text(
                  provider.notificationCount.toString(),
                  style: TextStyle(color: Colors.black45),
                ),
                child: IconButton(
                  padding: EdgeInsets.only(right: 10.0),
                  icon: Icon(
                    FontAwesomeIcons.bell,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    provider.clear();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SVNotificationFragment()));
                  },
                ),
              );
            }),
          ],
        ),
        drawer: DrawerWidget().appDrawerEmployee(context: context),
        body: Background2(
         child: DrawerWidget().appDrawerWidgets(context: context, type: "Employee"),
        ),
      ),
    );
  }
}

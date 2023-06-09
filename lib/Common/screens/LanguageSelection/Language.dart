import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Data/provider/account_provider.dart';
import 'package:hub/Data/repository/auth_repo.dart';
import 'package:hub/Widgets/utils_widget.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  late AuthRepo authRepo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Language'.tr(),
          style: kTextStyle.copyWith(color: Colors.white,fontWeight: FontWeight.w700),
        ),
      ),
      body : ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: languages.length,
        itemBuilder: (BuildContext context, int index) {
          authRepo = Provider.of<AccountProvider>(context, listen: false).authRepo;
          return UtilsWidget().LanguageItemList(languages[index], index, context, authRepo);
        },
      ),
    );
  }
}

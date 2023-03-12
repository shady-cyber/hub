import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:hub/Data/provider/account_provider.dart';
import '../../Util/constant.dart';
import 'background.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  bool _isLoading = false;
  bool showProgress = false;
  bool isChecked = false;
  bool pressAttention = false;
  bool checkedValue = false;
  final TextEditingController controller = TextEditingController();
  final TextEditingController _empcodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return WillPopScope(
      onWillPop: () async {
        if (MediaQuery
            .of(context)
            .viewInsets
            .bottom != 0) {
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          exit(0);
        }
        return false;
      },
      child: Scaffold(
        body: Consumer<AccountProvider>(
            builder: (context, accountProvider, child) {
              return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Background(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Container(
                    alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Sign In".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kMainColor,
                            fontSize: 36
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SizedBox(
                      height: 60.0,
                      width: size.width * 0.5,
                      child: AppTextField(
                        textFieldType: TextFieldType.NAME,
                        controller: _empcodeController,
                        decoration: InputDecoration(
                          labelText: 'Code'.tr(),
                          labelStyle: kTextStyle,
                          hintText: 'Enter code'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 60.0,
                      width: size.width * 0.5,
                      child:
                      AppTextField(
                        textFieldType: TextFieldType.PASSWORD,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password'.tr(),
                          labelStyle: kTextStyle,
                          hintText: 'Enter password'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),

                    CheckboxListTile(
                      title: const Text(
                        "Use biometric face for login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kMainCard,
                            fontFamily: "Robot",
                            fontSize: 14),
                      ),
                      value: checkedValue,
                      onChanged: (newValue) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {
                          checkedValue = newValue!;
                        });
                      },
                      contentPadding: EdgeInsets.only(
                          left: 80, top: 0, right: 80),
                      controlAffinity: ListTileControlAffinity.leading,
                      //  <-- leading Checkbox
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),
                    //SizedBox(height: size.height * 0.05),
                    Container(
                      width: 350,
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                          onPressed: accountProvider.isLoading ? null : () =>
                          accountProvider.onSubmitSignIn(context, pressAttention, _empcodeController, _passwordController, checkedValue),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor: kBlueTextColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          )),
                      icon: accountProvider.isLoading
                          ? Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(2.0),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      ) : Offstage(),
                      label: Text('Login'.tr()),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
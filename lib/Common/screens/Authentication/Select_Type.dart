import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hub/Data/provider/account_provider.dart';
import 'package:hub/Widgets/utils_widget.dart';
import '../../../Data/provider/connection_string_provider.dart';
import '../../Util/constant.dart';
import 'Sign_In.dart';

class SelectType extends StatefulWidget {
  const SelectType({Key? key}) : super(key: key);

  @override
  _selectType createState() => _selectType();
}

class _selectType extends State<SelectType> {
  bool showTextVerify = false;
 // List<String> codeController = [];
  List<String> codeControllerr = [''];
  StringBuffer stringBuffer = new StringBuffer();
  String resultString = '';
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Consumer<ConnectStringProvider>(
        builder: (context, connectStringProvider, child) {
    return Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/onboard3.png',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your OTP company code",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Consumer<AccountProvider>(
                    builder: (context, accountProvider, child) {
                      return Column(
                  children: [
                    accountProvider.OtpValue == false ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UtilsWidget().textFieldOTP(first: true, last: false),
                        UtilsWidget().textFieldOTP(first: false, last: false),
                        UtilsWidget().textFieldOTP(first: false, last: false),
                        UtilsWidget().textFieldOTP(first: true, last: true),
                      ],
                    ): Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UtilsWidget().textFieldOTP2(first: true, last: false),
                        UtilsWidget().textFieldOTP2(first: false, last: false),
                        UtilsWidget().textFieldOTP2(first: false, last: false),
                        UtilsWidget().textFieldOTP2(first: true, last: true),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
               SizedBox(
                      width: double.infinity,
                      child:
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : () =>
                            accountProvider.onSubmitOtp(context, showTextVerify, accountProvider.resultString),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            backgroundColor: kMainColor,
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
                        label: Text('Verify'.tr()),
                          ),
                        ),
                  ],
                );
                  }),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "If you didn't have company code",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Please Check with your Manager",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kMainColor,
                ),
                textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
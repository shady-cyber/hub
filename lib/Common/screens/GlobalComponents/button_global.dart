import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Data/provider/employee_provider.dart';

class ButtonGlobal extends StatelessWidget {
  final String buttontext;
  final Decoration buttonDecoration;
  var onPressed;
  var loading = false;

  ButtonGlobal(
      {required this.buttontext,
      required this.buttonDecoration,
      required this.onPressed,
      loading});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: Provider.of<EmployeeProvider>(context, listen: false).loading_btn == false ? onPressed : () =>
      Container(
        width: 24,
        height: 24,
        padding: const EdgeInsets.all(2.0),
        child: const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: buttonDecoration,
        child: Center(
          child: Text(
            buttontext,
            style: kTextStyle.copyWith(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ButtonGlobalWithoutIcon extends StatelessWidget {
  final String buttontext;
  final Decoration buttonDecoration;
  var onPressed;
  final Color buttonTextColor;

  ButtonGlobalWithoutIcon(
      {required this.buttontext,
      required this.buttonDecoration,
      required this.onPressed,
      required this.buttonTextColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        decoration: buttonDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttontext,
              style: kTextStyle.copyWith(color: buttonTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

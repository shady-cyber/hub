import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Common/screens/GlobalComponents/button_global.dart';

class DecorationWidget extends ChangeNotifier {

  BoxDecoration boxDecoration({double radius = 2, Color color = Colors
      .transparent, Color? bgColor, var showShadow = false}) {
    return BoxDecoration(
      color: bgColor,
      boxShadow: showShadow
          ? defaultBoxShadow(shadowColor: shadowColorGlobal)
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

  Widget text(String? text,
      {var fontSize = 18.0, Color? textColor, var fontFamily, var isCentered = false, var maxLine = 1, var latterSpacing = 0.5, bool textAllCaps = false, var isLongText = false, bool lineThrough = false,}) {
    return Text(
      textAllCaps ? text!.toUpperCase() : text!,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily ?? null,
        fontSize: fontSize,
        color: textColor,
        height: 1.5,
        letterSpacing: latterSpacing,
        decoration:
        lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  BoxDecoration boxDecorations({double radius = 2, Color color = Colors
      .transparent, Color? bgColor, var showShadow = false}) {
    return BoxDecoration(
      color: bgColor ?? Colors.white,
      boxShadow: showShadow
          ? defaultBoxShadow(shadowColor: shadowColorGlobal)
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

  void changeStatusColor(Color color) async {
    setStatusBarColor(color);
  }

  Padding editTextStyle(var hintText, {var line = 1}) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: TextFormField(
          maxLines: line,
          style: TextStyle(
            fontSize: textSizeMedium,
            fontFamily: fontRegular,
          ),
          decoration: InputDecoration(
            contentPadding:
            EdgeInsets.fromLTRB(spacing_standard_new, 16, 4, 16),
            hintText: hintText,
            filled: true,
            fillColor: kDarkWhite,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(spacing_middle),
              borderSide: BorderSide(color: kDarkWhite, width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(spacing_middle),
              borderSide: BorderSide(color: kDarkWhite, width: 0.0),
            ),
          ),
        ));
  }

  Widget svCommonCachedNetworkImage(String? url,
      {double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, bool usePlaceholderIfUrlEmpty = true, double? radius, Color? color,}) {
    if (url!.validate().isEmpty) {
      return placeHolderWidget(
          height: height,
          width: width,
          fit: fit,
          alignment: alignment,
          radius: radius);
    } else if (url.validate().startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        color: color,
        alignment: alignment as Alignment? ?? Alignment.center,
        errorWidget: (_, s, d) {
          return placeHolderWidget(
              height: height,
              width: width,
              fit: fit,
              alignment: alignment,
              radius: radius);
        },
        placeholder: (_, s) {
          if (!usePlaceholderIfUrlEmpty) return SizedBox();
          return placeHolderWidget(
              height: height,
              width: width,
              fit: fit,
              alignment: alignment,
              radius: radius);
        },
      );
    } else {
      return svCommonCachedNetworkImage(url,
          height: height,
          width: width,
          fit: fit,
          alignment: alignment ?? Alignment.center)
          .cornerRadiusWithClipRRect(radius ?? defaultRadius);
    }
  }

  Widget placeHolderWidget(
      {double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
    return Image.asset('assets/images/emp2.png',
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center)
        .cornerRadiusWithClipRRect(radius ?? defaultRadius);
  }
  Widget showDialogExit({required BuildContext context}) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      // ignore: sized_box_for_whitespace
      child: SizedBox(
        height: 310.0,
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Image(
              image: AssetImage('assets/images/exit.png'),
              width: 100,
              height: 100,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Exit'.tr(),
              style: kTextStyle.copyWith(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              'Are you sure?'.tr(),
              style: kTextStyle.copyWith(
                color: kGreyTextColor,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              'You want to exit.'.tr(),
              style: kTextStyle.copyWith(
                color: kGreyTextColor,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            ButtonGlobal(
                buttontext: 'YES'.tr(),
                buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
                onPressed: () {
                  // Navigator.pop(context);
                  exit(0);
                }),
          ],
        ),
      ),
    );
  }

}
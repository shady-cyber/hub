import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:hub/Data/model/notification-model.dart';
import 'package:hub/Common/Util/constant.dart';
import 'package:hub/Widgets/decoration_widget.dart';

class SVNewPostNotificationComponent extends StatelessWidget {
  final SVNotificationModel element;

  SVNewPostNotificationComponent({required this.element});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecorationWidget()
            .svCommonCachedNetworkImage(element.profileImage.validate(),
                height: 40, width: 40, fit: BoxFit.cover)
            .cornerRadiusWithClipRRect(8),
        8.width,
        Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(element.name.validate(), style: boldTextStyle(size: 14)),
                  2.width,
                  element.isOfficial.validate()
                      ? Image.asset('assets/images/emp3.png',
                          height: 14, width: 14, fit: BoxFit.cover)
                      : Offstage(),
                  Text(' Posted new post',
                      style: secondaryTextStyle(color: kMainColor)),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),
            6.height,
            Text('${element.time.validate()} ago',
                style: secondaryTextStyle(color: kMainColor, size: 12)),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ).expand(),
        DecorationWidget()
            .svCommonCachedNetworkImage(element.postImage.validate(),
                height: 48, width: 48, fit: BoxFit.cover)
            .cornerRadiusWithClipRRect(4),
      ],
    ).paddingAll(16);
  }
}

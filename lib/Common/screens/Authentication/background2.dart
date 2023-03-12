import 'package:flutter/material.dart';

class Background2 extends StatelessWidget {
  final Widget child;

  const Background2({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -60,
            right: 0,
            child: Image.asset(
              "assets/images/top1.png",
              width: size.width
            ),
          ),
          Positioned(
            top: -110,
            right: 0,
            child: Image.asset(
              "assets/images/top2.png",
              width: size.width
            ),
          ),
          child
        ],
      ),
    );
  }
}
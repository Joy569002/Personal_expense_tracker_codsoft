// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math; // Import the math library

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the flutter_svg package
import 'package:velocity_x/velocity_x.dart';

class BalanceLayout extends StatelessWidget {
  final Animation<Offset>? offsetAnimation;
  final String? title;
  final double? amount;
  final bool isexpense;

  const BalanceLayout({
    Key? key,
    this.offsetAnimation,
    this.title,
    this.amount,
    required this.isexpense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/balanceContainer.png', // Replace with your actual asset path
          height: 65,
          width: context.screenWidth,
          fit: BoxFit.fill,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    "$title".text.white.make(),
                    4.widthBox,
                    (isexpense)
                        ? Icon(
                            Icons.arrow_downward,
                            color: Colors.red,
                            size: 16,
                          )
                        : Icon(
                            Icons.arrow_upward,
                            size: 16,
                            color: Colors.green,
                          )
                  ],
                ),
                3.heightBox,
                Row(
                  children: [
                    "$amount ".text.white.bold.size(18).make(),
                    8.widthBox,
                    if (offsetAnimation != null)
                      SlideTransition(
                        position: offsetAnimation!,
                        child: SvgPicture.asset('assets/anchorArrowRight.svg'),
                      ),
                  ],
                ),
              ],
            ).pSymmetric(h: 12),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.asset(
                'assets/wallet.gif',
                height: 60,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

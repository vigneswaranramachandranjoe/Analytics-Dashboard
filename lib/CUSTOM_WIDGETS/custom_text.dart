import 'package:flutter/material.dart';

import '../CONSTANT/constant.dart';





class CustomText extends StatelessWidget {
  String txt;
  Color? clr;
  double? size, space;
  FontWeight? fontWeight;
  bool? underLn;
  FontStyle? fontStyle;
  TextAlign? textAlign;
  int? maxLn;

  CustomText(
      {required this.txt,
      this.size,
      this.fontWeight,
      this.clr,
      this.underLn,
      this.space,
      this.fontStyle,
      this.textAlign,
      this.maxLn});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      maxLines: maxLn ?? 3,
      style: TextStyle(
          color: clr ?? AppColors.txtGrey,
          fontWeight: fontWeight,
          fontSize: size ?? 12,
          letterSpacing: space,
          fontStyle: fontStyle,
          decoration: underLn == true ? TextDecoration.underline : null),
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      // textDirection: TextDirection.rtl,
    );
  }
}

class ManitoryTitleText extends StatelessWidget {
  ManitoryTitleText(
      {super.key,
      required this.w,
      this.txt,
      this.strWant,
      this.child,
      this.padding});

  final double w;
  final String? txt;
  final bool? strWant;
  Widget? child;
  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: child != null ? 5 : 0,
        children: [
          RichText(
            text: TextSpan(
              text: '${txt}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: strWant == false ? "" : '*',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          child ?? SizedBox()
        ],
      ),
    );
  }
}

class DoubleTextRow extends StatelessWidget {
  DoubleTextRow(
      {super.key, this.padd,this.txt1, this.txt2, this.clr1, this.clr2,this.size2,this.size1,this.isCloanWant});

  String? txt1, txt2;
  double? size1, size2;
  Color? clr1, clr2;
  bool? isCloanWant;
  EdgeInsets? padd;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padd ?? EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              size: size1,
              txt: isCloanWant == false?"${txt1}":"${txt1} :",
              clr: clr1 ?? AppColors.txtGrey,
              fontWeight: FontWeight.w600,
            ),
            CustomText(
              txt: txt2 ?? "",
              maxLn: 5,
              size: size2,
              clr: clr2,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.bold,
            )
          ],
        )
        // child: Row(
        //
        //   children: [
        //     Expanded(
        //       flex: 1,
        //
        //       child: CustomText(
        //         txt: txt1 ?? "",
        //         clr: AppColors.txtGrey,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //     Expanded(
        //       flex: 2,
        //
        //       child: CustomText(
        //         txt: txt2 ?? "",
        //         maxLn: 5,
        //         textAlign: TextAlign.right,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     )
        //   ],
        // ),
        );
  }
}

class StockText extends StatelessWidget {
  StockText({super.key, this.pad, this.txt1, this.txt2});

  String? txt1, txt2;
  double? pad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txt: txt1 ?? "",
          clr: AppColors.txtGrey,
          fontWeight: FontWeight.w600,
        ),
        CustomText(
          txt: txt2 ?? "",
          maxLn: 5,
          textAlign: TextAlign.left,
          fontWeight: FontWeight.bold,
        )
      ],
    );
  }
}

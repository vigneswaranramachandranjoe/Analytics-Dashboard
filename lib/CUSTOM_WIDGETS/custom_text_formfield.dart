import 'package:flutter/material.dart';
import '../CONSTANT/constant.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? hintTxt;
  double? h, w, radius, overAllHeight;
  Widget? suffix;
  Widget? preffix;
  Color? fillClr;
  bool? readOnly, enable, obscure;
  Function()? tap;
  String? Function(String?)? validation;
  Function(String?)? onchange;

  int? maxLn;
  TextInputType? keyboardType;
  TextInputAction? txtInputAction;
  FocusNode? focusNode;
  String? manitTxt;
  bool? starWant;

  Function(String?)? submit;

  CustomTextFormField({
    this.controller,
    this.starWant,
    this.manitTxt,
    this.hintTxt,
    this.h,
    this.obscure,
    this.w,
    this.radius,
    this.onchange,
    this.fillClr,
    this.tap,
    this.readOnly,
    this.validation,
    this.maxLn,
    this.focusNode,
    this.submit,
    this.overAllHeight,

    this.suffix,
    this.preffix,
    this.enable,
    this.keyboardType,
    this.txtInputAction,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return ManitoryTitleText(
      w: w ?? width,
      strWant: starWant ?? true,
      txt: manitTxt ?? "",
      child: Container(
        height: overAllHeight ?? height * 0.08,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w ?? 0, vertical: h ?? 0),
          child: TextFormField(
            style: const TextStyle(color: Colors.black),
            obscureText: obscure ?? false,

            scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 15 * 4,
            ),
            controller: controller,
            readOnly: readOnly ?? false,
            onTap: tap,
            validator:
                validation ??
                (val) {
                  return validator(val: val, hintTxt: hintTxt);
                },
            maxLines: maxLn ?? 1,
            enabled: enable,
            focusNode: focusNode,

            onChanged: onchange,
            keyboardType: hintTxt == null
                ? keyboardType
                : getKeyBoardType(val: hintTxt),
            textInputAction: txtInputAction ?? TextInputAction.next,
            onFieldSubmitted: submit,

            decoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize: 11,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),

              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),

              hintText: hintTxt ?? "",
              hintStyle: TextStyle(
                fontSize: 12,
                color: AppColors.txtGrey,
                overflow: TextOverflow.ellipsis,
              ),
              hintMaxLines: 1,
              suffixIcon: suffix,
              prefixIcon: preffix,
              fillColor: fillClr == null ? AppColors.cardBg : fillClr,
              filled: true,

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.txtGrey.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(radius ?? 7),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.txtGrey.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(radius ?? 7),
              ),
              helperStyle: TextStyle(
                color: AppColors.txtGrey,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),

              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.txtGrey.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(radius ?? 7),
              ), //
              // Outlined border
            ),
          ),
        ),
      ),
    );
  }

  getKeyBoardType({String? val}) {
    if (val!.contains("Name") || val!.contains("name")) {
      return TextInputType.name;
    } else if (val!.contains("Email") ||
        val.contains("mail") ||
        val.contains("Mail")) {
      return TextInputType.emailAddress;
    } else if (val!.contains("Phone") || val!.contains("Mobile")) {
      return TextInputType.phone;
    } else {
      return null;
    }
  }

  String? validator({String? val, hintTxt}) {
    print(val);
    print("888");
    if (hintTxt!.contains("Name") || hintTxt!.contains("name")) {
      if (val!.isEmpty) {
        return "Please enter valid name";
      }
    } else if (hintTxt!.contains("Email") ||
        hintTxt.contains("mail") ||
        hintTxt.contains("Mail") ||
        hintTxt.contains("Email")) {
      if (val!.isEmpty) {
        return "Please enter the email";
      } else if (!RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      ).hasMatch(val)) {
        return "Please enter valid email";
      }
    } else if (hintTxt!.contains("Phone") || hintTxt!.contains("Mobile")) {
      if (val!.isEmpty) {
        return "Please enter valid phone number";
      } else if (val!.length >= 12) {
        return "Phone number have maximum 12 characters";
      }
    } else if (hintTxt!.contains("Password")) {
      if (val!.isEmpty) {
        return "Please enter password";
      }
    }
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const SearchTextField({super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Color(0xff1170AA).withOpacity(0.4),
            blurRadius: 6,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search...",
          // hintStyle: TextStyle(fontSize: 12),
          suffixIcon: Icon(Icons.search, color: Colors.grey[700], size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
        ),
      ),
    );
  }
}

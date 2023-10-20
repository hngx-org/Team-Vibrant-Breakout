import 'package:flutter/material.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';

class RetroText extends StatelessWidget {
  final String largeText;
  final String smallText;
  const RetroText(
      {required this.largeText, required this.smallText, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        Text(
          largeText,
          style: TextStyle(
            //fontFamily: 'Scholarly Ambition',
            color: buttonColor,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        Text(
          smallText,
          style: TextStyle(
            color: buttonColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        )
      ]),
    );
  }
}

class InfoFilelds extends StatelessWidget {
  const InfoFilelds({
    required this.hintText,
    required this.icon,
    required this.validator,
    this.trailing,
    this.obscureText = false,
    required this.controller,
    super.key,
  });
  final TextEditingController controller;

  final Widget? icon;

  final String hintText;

  final Widget? trailing;
  final bool obscureText;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return validator(value);
      },
      obscureText: obscureText,
      controller: controller,
      style: TextStyle(color: colorWhite),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 24),
        prefixIcon: icon,
        prefixIconColor: colorWhite,
        suffixIcon: trailing,
        suffixIconColor: colorWhite,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: buttonColor),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: buttonColor),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: buttonColor),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: false,
        hintText: hintText,
        hintStyle: TextStyle(
          color: colorWhite,
        ),
      ),
    );
  }
}

class AuthScreenButtons extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const AuthScreenButtons({required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        maximumSize: Size(350, 48),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: bgColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // ),
    );
  }
}

class InLineTexts extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Function()? onpressed;
  const InLineTexts(
      {required this.firstText,
      required this.secondText,
      required this.onpressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: TextStyle(
            color: colorWhite,
            fontSize: 15,
          ),
        ),
        TextButton(
            onPressed: onpressed,
            child: Text(
              secondText,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: buttonColor,
                  fontSize: 17),
            ))
      ],
    );
  }
}

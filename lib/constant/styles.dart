import 'package:flutter/material.dart';
import 'package:management/constant/colors.dart';

const kPadding = 16.0;

const cardVerPadding = EdgeInsets.only(top: 16, bottom: 20);

const kScaffoldPadding = EdgeInsets.symmetric(horizontal: kPadding);

var kBorderRadius = const BorderRadius.all(
  Radius.circular(8),
);

InputDecoration getInputDecoration(BuildContext context) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 14.0,
      horizontal: 14.0,
    ),
    errorStyle: const TextStyle(
      color: Colors.red,
    fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.4,
        color: Theme.of(context).iconTheme.color!,
      ),
      borderRadius: kBorderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 0.8,
        color: Colors.red,
      ),
      borderRadius: kBorderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 0.8,
        color: Colors.red,
      ),
      borderRadius: kBorderRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.4,
        color: Theme.of(context).iconTheme.color!,
      ),
      borderRadius: kBorderRadius,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 0.8,
        color: AppColors.kSecondary,
      ),
      borderRadius: kBorderRadius,
    ),
    hintStyle: TextStyle(
      color: Colors.grey.shade600,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  );
}

List<BoxShadow>? getBoxShadow(BuildContext context) {
  return const [
    BoxShadow(
      offset: Offset(0, 0),
      spreadRadius: 0,
      blurRadius: 7,
      color: Color.fromRGBO(246, 245, 245, 1),
    )
  ];
}

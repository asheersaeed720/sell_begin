import 'package:flutter/material.dart';

InputDecoration buildTextFieldInputDecoration(
  context, {
  required String txt,
  Color fillColor = Colors.white,
  String prefixIconUrl = '',
  String suffixIconUrl = '',
  Function? suffixFunction,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 22),
    enabledBorder: const OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 0.7),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
    hintText: '$txt',
    isDense: true,
    fillColor: fillColor != Colors.white ? fillColor : Theme.of(context).cardColor,
    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 12.0, color: Colors.grey),
    filled: true,
    prefixIcon: prefixIconUrl.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 8.0),
            child: Image.asset(prefixIconUrl),
          )
        : SizedBox.shrink(),
    prefixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
    suffixIcon: suffixIconUrl.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () {
                suffixFunction!();
              },
              child: Image.asset(suffixIconUrl),
            ),
          )
        : SizedBox.shrink(),
    suffixIconConstraints: BoxConstraints(minWidth: 20, maxHeight: 17),
  );
}

InputDecoration buildPasswordInputDecoration(
  context, {
  required String txt,
  Color fillColor = Colors.white,
  required Widget suffixIcon,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
    enabledBorder: const OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 0.7),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
    hintText: '$txt',
    isDense: true,
    fillColor: fillColor != Colors.white ? fillColor : Theme.of(context).cardColor,
    hintStyle: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 12.0, color: Colors.grey),
    filled: true,
    suffixIcon: suffixIcon,
  );
}

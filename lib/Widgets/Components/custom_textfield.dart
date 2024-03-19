import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final Function(String?)? onsave;
  final int? maxLines;
  final bool isPassword;
  final bool enable;
  final TextInputType? keyboardtype;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;
  final bool? check;
  CustomTextField(
      {this.check,
      this.controller,
      this.hintText,
      this.validate,
      this.onsave,
      this.enable = true,
      this.focusNode,
      this.isPassword = true,
      this.keyboardtype,
      this.maxLines,
      this.prefix,
      this.suffix,
      this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines == null ? 1 : maxLines,
      enabled: enable == true ? true : enable,
      onSaved: onsave,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardtype == null ? TextInputType.name : keyboardtype,
      controller: controller,
      validator: validate,
      obscureText: isPassword == false ? false : isPassword,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffix,
        labelText: hintText ?? "Hint Text",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              style: BorderStyle.solid,
color: Theme.of(context).primaryColor              ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Color.fromARGB(255,136,69,121)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              style: BorderStyle.solid, color: Theme.of(context).primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
              style: BorderStyle.solid, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

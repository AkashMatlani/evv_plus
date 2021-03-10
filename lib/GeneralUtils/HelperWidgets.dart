import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Constant.dart';


Widget textFieldFor(String hint,
    TextEditingController controller,
    {TextInputType keyboardType = TextInputType.text,
      bool autocorrect = true,
      TextCapitalization textCapitalization = TextCapitalization.sentences,
      bool obscure = false,
      maxLength: 200,
      Widget perfixIcon,
      Widget suffixIcon,
      bool enabled = true,
      bool readOnly = false,
      VoidCallback onEditingComplete,
      VoidCallback onTap,
      Function onSubmit}) {
  return SizedBox(
    height: 50,
    child: TextField(
      autocorrect: autocorrect,
      enabled: enabled,
      readOnly: readOnly,
      textCapitalization: textCapitalization,
      onEditingComplete: onEditingComplete,
      obscureText: obscure,
      controller: controller,
      keyboardType: keyboardType,
      style: AppTheme.regularSFTextStyle(),
      decoration: InputDecoration(
        filled: true,
        contentPadding: textFieldPadding(),
        prefixIcon: perfixIcon,
        hintText: hint,
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        hintStyle: AppTheme.textFieldHintTextStyle(),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
      onTap: onTap,
      onSubmitted: onSubmit,
    ),
  );
}

Widget multilineTextFieldFor(String hint, TextEditingController controller, double height,
    {TextInputType keyboardType = TextInputType.text,
      bool autocorrect = true,
      TextCapitalization textCapitalization = TextCapitalization.sentences,
      bool obscure = false,
      maxLength: 200,
      Widget perfixIcon,
      bool enabled = true,
      bool readOnly = false,
      VoidCallback onEditingComplete,
      VoidCallback onTap,
      Function onSubmit,
      Function onChange}) {
  return SizedBox(
    height: height,
    child: TextField(
      autocorrect: autocorrect,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: 5,
      textCapitalization: textCapitalization,
      onEditingComplete: onEditingComplete,
      obscureText: obscure,
      controller: controller,
      keyboardType: keyboardType,
      style: AppTheme.regularSFTextStyle(),
      decoration: InputDecoration(
        filled: true,
        contentPadding: textFieldPadding(),
        prefixIcon: perfixIcon,
        hintText: hint,
        fillColor: Colors.white,
        hintStyle: AppTheme.textFieldHintTextStyle(),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
      onTap: onTap,
      onSubmitted: onSubmit,
    ),
  );
}

Widget appBar(String text, IconButton iconButton, {Color color}) {
  return AppBar(
    title: Text(
      text,
      style: AppTheme.headerTextStyle(),
    ),
    centerTitle: true,
    leading: IconButton(icon: iconButton, onPressed: () {}),
    backgroundColor: color ?? MyColor.backgroundColor(),
    brightness: Brightness.dark,
    elevation: 1,
  );
}

EdgeInsets textFieldPadding() {
  return EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0);
}

import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../modal/authType.dart';

class AuthTextField extends StatefulWidget {
  @override
  final Key key;
  final TextEditingController textController;
  final String placeholder;
  final AuthTextFieldType type;
  final bool isOptional;
  final String compareText;

  AuthTextField(
      {@required this.textController,
      @required this.placeholder,
      @required this.type,
      this.key,
      this.isOptional = false,
      this.compareText = ''});
  @override
  _AuthTextFieldState createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  var _isHiddenText = true;

  void setHidden() {
    setState(() {
      _isHiddenText = !_isHiddenText;
    });
  }

  bool isPassword() {
    return (widget.type == AuthTextFieldType.password) ||
        (widget.type == AuthTextFieldType.confirmPassword);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        // check email is valid ?
        if (val.isEmpty && !widget.isOptional) {
          return '${widget.placeholder} is Required';
        }
        if (isPassword()) {
          if (val.length < 8) {
            return 'Password must have a least 8 character';
          }
        }
        if (widget.type == AuthTextFieldType.confirmPassword) {
          if (val != widget.compareText) {
            return 'Password is not match';
          }
        }
        return null;
      },
      controller: widget.textController,
      obscureText: isPassword() && _isHiddenText,
      style: kBody1Gold,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: kBorderRadiusXS * 1.5, borderSide: BorderSide.none),
          filled: true,
          fillColor: kNeutralWhite,
          hintText: widget.placeholder,
          hintStyle: kBody1Gold,
          contentPadding: EdgeInsets.symmetric(
            horizontal: kSizeS * 1.25,
          ),
          suffixIcon: isPassword()
              ? IconButton(
                  iconSize: kSizeS * 1.25,
                  icon: _isHiddenText
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: setHidden,
                  color: kNeutral450,
                )
              : null,
          errorStyle: kBody1Red),
    );
  }
}

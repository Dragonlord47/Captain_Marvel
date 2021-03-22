import 'package:captain_marvel/custom/text_style_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IconTextField extends StatefulWidget {
  final String textHint;
  final IconData icon;
  final TextEditingController controller;
  final bool isSecure;
  final Function searchOperation;
  final Function changedHandler;
  final Function validatorHandler;
  final TextInputType inputType;
  final int lineNumber;
  final Color textFieldBackgroundColor;
  final Color hintColor;
  final Color borderColor;
  final AutovalidateMode autovalidateMode;
  List<TextInputFormatter> formatter;
  IconTextField({
    @required this.textHint,
    @required this.icon,
    @required this.controller,
    @required this.isSecure,
    @required this.searchOperation,
    this.changedHandler,
    this.formatter,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.validatorHandler,
    this.inputType = TextInputType.text,
    this.lineNumber = 1,
    this.textFieldBackgroundColor = Colors.transparent,
    this.hintColor = const Color.fromRGBO(114, 112, 112, 1),
    this.borderColor = Colors.redAccent,
  });

  //

  @override
  _IconTextFieldState createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<IconTextField> {
  bool toggle = true;
  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;

    //Color borderColor = widget.borderColor;
    return SizedBox(
      height: widget.lineNumber == 1 ? dimension.height * 0.095 : null,
      child: Theme(
        data: new ThemeData(
            primaryColor: widget.borderColor, dividerColor: Colors.redAccent),
        child: TextFormField(
          autovalidateMode: widget.autovalidateMode,
          controller: widget.controller,
          inputFormatters: widget.formatter,
          textAlignVertical: TextAlignVertical.center,
          obscureText: !widget.isSecure ? widget.isSecure : toggle,
          keyboardType: widget.inputType,
          maxLines: widget.lineNumber,
          onChanged:
              widget.changedHandler != null ? widget.changedHandler : null,
          validator: widget.validatorHandler != null
              ? widget.validatorHandler
              : (value) {
                  return '';
                },
          style: TextStyle(
              fontSize: 13,
              //fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white60,
              ),
              focusColor: Colors.red[200],
              filled: true,
              fillColor: widget.textFieldBackgroundColor,
              hintText: widget.textHint,
              alignLabelWithHint: true,
              hintMaxLines: widget.lineNumber,
              helperText: ' ',
              errorMaxLines: 1,
              contentPadding: EdgeInsets.only(
                  top: dimension.height * 0.04, left: dimension.height * 0.02),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(dimension.width * 0.01),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(dimension.width * 0.01),
                borderSide: BorderSide(
                  color: Color.fromRGBO(204, 212, 236, 1),
                  width: 1.0,
                ),
              ),
              errorBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(dimension.width * 0.01),
                borderSide: new BorderSide(color: Colors.red, width: 1),
              ),
              isDense: false,
              suffixIcon: InkWell(
                  onTap: widget.searchOperation,
                  child: Icon(MdiIcons.magnify, color: Colors.white))),
        ),
      ),
    );
  }
}

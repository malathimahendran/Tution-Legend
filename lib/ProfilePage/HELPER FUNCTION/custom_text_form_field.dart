import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import 'provider_for_edit_page.dart';

class CustomTextFormField extends StatefulWidget {
  final double? height;
  final double? width;
  var controller;
  final hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? value;
  final FocusNode? focusNode;
  final bool? obsecure;
  final bool? readOnly;
  final TextInputType? keyboardType;
  CustomTextFormField(
      {this.height,
      this.width,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.value,
      this.focusNode,
      this.obsecure = false,
      this.readOnly = false,
      this.keyboardType});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final l = Logger();
  var controllers;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width! * 0.8,
      height: widget.height! * 0.073,
      child: Card(
        elevation: 5,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        child: TextFormField(
          readOnly: widget.readOnly!,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          obscureText: widget.obsecure!,
          keyboardType: widget.keyboardType,
          // focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: HexColor('#FFFFFF'),
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey.shade300),
            prefixIcon: Container(
              // width: (width - 70.0) * 0.05,
              // width: 30.0,
              width: (widget.width! * 0.13),
              margin: EdgeInsets.only(right: (widget.width! * 0.02)),
              alignment: Alignment.centerRight,
              child: Icon(
                widget.prefixIcon,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(widget.suffixIcon),
              onPressed: () async {
                await clicking(
                  context: context,
                  value: widget.value,
                );

                widget.controller.text =
                    Provider.of<ProviderFunction>(context, listen: false)
                        .date
                        .toString()
                        .substring(0, 10);
                l.i(Provider.of<ProviderFunction>(context, listen: false)
                    .date
                    .toString()
                    .substring(0, 10));
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(color: Color(0xF2FFFFFF), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(color: Color(0xF227DEBF), width: 1),
            ),
          ),
        ),
      ),
    );
  }

  clicking({context, value, control}) async {
    if (value == 'visible') {
      Provider.of<ProviderFunction>(context, listen: false)
          .changingTrueOrFalse();
    } else if (value == 'calendar') {
      var returnDate =
          await Provider.of<ProviderFunction>(context, listen: false)
              .selectingDate(context: context);
      l.w(returnDate);
      return returnDate;
    }
  }
}

// ignore: must_be_immutable
class CustomSelectFormField extends StatelessWidget {
  final double? width;
  final double? height;
  final String? hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  CustomSelectFormField(
      {this.hintText,
      this.controller,
      this.width,
      this.prefixIcon,
      this.height});

  List<Map<String, dynamic>> items = [
    {
      'value': "9",
      'label': '9',
    },
    {
      'value': "10",
      'label': '10',
    },
    {
      'value': "11",
      'label': '11',
    },
    {
      'value': "12",
      'label': '12',
    },
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: width! * 0.8,
      height: height! * 0.073,
      child: Card(
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        child: SelectFormField(
          items: items,
          controller: controller,
          type: SelectFormFieldType.dropdown,
          decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            prefixIcon: Container(
              // width: (width - 70.0) * 0.05,
              width: (width! * 0.13),
              margin: EdgeInsets.only(right: (width! * 0.02)),
              // width: 50,
              alignment: Alignment.centerRight,
              child: Icon(prefixIcon),
            ),
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey.shade300),
            suffixIcon: Icon(Icons.arrow_drop_down),
            fillColor: HexColor('#FFFFFF'),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(color: Color(0xF2FFFFFF), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              borderSide: BorderSide(color: Color(0xF227DEBF), width: 1),
            ),
          ),
        ),
      ),
    );
  }
}

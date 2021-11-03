import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import 'provider_for_edit_page.dart';

class CustomTextFormField extends StatelessWidget {
  final double? height;
  final double? width;
  final controller;
  final hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? value;
  final FocusNode? focusNode;
  final bool? obsecure;
  CustomTextFormField(
      {this.height,
      this.width,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.value,
      this.focusNode,
      this.obsecure = false});
  final l = Logger();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obsecure!,

      // focusNode: focusNode,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade300),
        prefixIcon: Container(
          // width: (width - 70.0) * 0.05,
          // width: 30.0,
          width: (width! * 0.13),
          margin: EdgeInsets.only(right: (width! * 0.02)),
          alignment: Alignment.centerRight,
          child: Icon(
            prefixIcon,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: () {
            clicking(
              context: context,
              value: value,
              control: controller,
            );
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  clicking({context, value, control}) {
    if (value == 'visible') {
      Provider.of<ProviderFunction>(context, listen: false)
          .changingTrueOrFalse();
    } else if (value == 'calendar') {
      Provider.of<ProviderFunction>(context, listen: false)
          .selectingDate(context: context);
      controller.text =
          Provider.of<ProviderFunction>(context, listen: true).date;

      l.i(controller.text);
    }
  }
}

// ignore: must_be_immutable
class CustomSelectFormField extends StatelessWidget {
  final double? width;
  final String? hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  CustomSelectFormField(
      {this.hintText, this.controller, this.width, this.prefixIcon});

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
    return SelectFormField(
      items: items,
      controller: controller,
      type: SelectFormFieldType.dropdown,
      decoration: InputDecoration(
        fillColor: Colors.white,
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
        hintStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade300),
        suffixIcon: Icon(Icons.arrow_drop_down),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.red,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}

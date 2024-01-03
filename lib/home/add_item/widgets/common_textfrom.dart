import 'package:flutter/material.dart';
import 'package:phone_book/home/add_item/view_model/add_address_viewmodel.dart';
import 'package:provider/provider.dart';

customeTextField(
  BuildContext context, {
  String? hintext,
  IconButton? suffixIcon,
  VoidCallback? onPresstextField,
  Widget? trailingIcon,
  Icon? prefixIcon,
  double? continreHight,
  bool? enabled,
  VoidCallback? onPresstextFieldContiner,
  dynamic Controller,
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Row(
      children: [
        GestureDetector(
          onTap: onPresstextFieldContiner,
          child: Container(
            width: trailingIcon == null
                ? MediaQuery.of(context).size.width * 9 / 10
                : MediaQuery.of(context).size.width * 8 / 10,
            height: continreHight ?? 50,
            margin: const EdgeInsets.only(
              left: 20,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 184, 207, 230),
                border: Border.all(width: 1, color: Colors.green),
                borderRadius: BorderRadius.circular(6)),
            child: TextFormField(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
              controller: Controller,
              enabled: enabled,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10.0),
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  hintText: hintext ?? "",
                  hintStyle:
                      const TextStyle(fontSize: 17, color: Colors.grey),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green))),
            ),
          ),
        ),
        trailingIcon ?? const SizedBox()
      ],
    ),
  );
}

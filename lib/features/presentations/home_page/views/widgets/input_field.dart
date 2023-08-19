import 'package:flutter/material.dart';
import 'package:jym_app/core/constants/stylies.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      this.controller,
      this.widget,
      required this.title,
      required this.hint})
      : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  // final Function function;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Stylies.titleStyle(),
          ),
          Container(
            padding: const EdgeInsets.only(left: 14),
            margin: const EdgeInsets.only(top: 8),
            height: 52,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget != null,
                    autofocus: false,
                    controller: controller,
                    style: Stylies.subTitleStyle(),
                    decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: Stylies.subTitleStyle(),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white.withOpacity(0),
                          width: 0,
                        )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.red.withOpacity(0),
                          width: 0,
                        ))),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

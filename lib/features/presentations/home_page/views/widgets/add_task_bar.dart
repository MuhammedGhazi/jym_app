import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/core/constants/stylies.dart';

import 'my_button.dart';

class AddTaskBar extends StatelessWidget {
  const AddTaskBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: Stylies.subHeadingStyle(),
              ),
              Text(
                'Today',
                style: Stylies.headingStyle(),
              ),
            ],
          ),
          MyButton(
              lable: " New subscriber",
              onTap: (() => Navigator.of(context).pushNamed('addTask')))
        ],
      ),
    );
  }
}

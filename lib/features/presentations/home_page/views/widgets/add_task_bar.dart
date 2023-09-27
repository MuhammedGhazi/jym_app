import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/core/constants/stylies.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';

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
              onTap: (() {
                // BlocProvider.of<SubsCubit>(context).fetchActiveSubs();
                debugPrint(
                    "${BlocProvider.of<SubsCubit>(context).allActiveSubs == null ? 0 : BlocProvider.of<SubsCubit>(context).allActiveSubs!.length} ??");
                if (BlocProvider.of<SubsCubit>(context).allActiveSubs == null ||
                    BlocProvider.of<SubsCubit>(context).allActiveSubs!.length <
                        6) {
                  return Navigator.of(context).pushNamed('addTask');
                } else {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const Text(" Hellow man!!"),
                  );
                }
              }))
        ],
      ),
    );
  }
}

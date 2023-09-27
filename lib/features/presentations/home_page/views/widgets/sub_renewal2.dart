import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import '../../manag/cubits/subs_cubit/subs_cubit.dart';
import 'input_field.dart';
import 'my_button.dart';

class SubRenewal2 extends StatefulWidget {
  const SubRenewal2({super.key, required this.subM});
  final SubscriberModel subM;

  @override
  State<SubRenewal2> createState() => _SubRenewal2State();
}

class _SubRenewal2State extends State<SubRenewal2> {
  String? recodTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Column(
        children: [
          Text(widget.subM.fullName.toString()),
          const SizedBox(
            height: 10,
          ),
          Text(widget.subM.category.toString()),
          InputField(
            title: " تجديد لغاية ",
            hint: recodTo ??
                _addMonthToDate(widget.subM.upToRecord.toString(), 1),
            widget: IconButton(
                onPressed: () async {
                  DateTime? dt = await _getDateFromUser(context);
                  if (dt != null) {
                    setState(() {
                      recodTo =
                          DateFormat('dd/MM/y').format(dt); //dt toString();
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today_outlined)),
          ),
          const SizedBox(height: 5),
          MyButton(
            lable: "تجديد",
            onTap: () {
              setState(() {
                BlocProvider.of<SubsCubit>(context).renewalSubs(
                    widget.subM.id!,
                    recodTo ??
                        _addMonthToDate(widget.subM.upToRecord.toString(), 1));
                Navigator.pop(context);
                BlocProvider.of<SubsCubit>(context).fetchArchiveSubs();
                BlocProvider.of<SubsCubit>(context).fetchActiveSubs();
              });
            },
          ),
          const SizedBox(height: 5),
          MyButton(
            lable: "حذف",
            onTap: () {
              setState(() {
                BlocProvider.of<SubsCubit>(context).deleteSub(widget.subM.id!);
                Navigator.pop(context);
                BlocProvider.of<SubsCubit>(context).fetchArchiveSubs();
              });
            },
          ),
        ],
      ),
    );
  }

  String _addMonthToDate(String oldDate, int addedMonths) {
    DateTime tempDate = DateFormat("dd/MM/y").parse(oldDate);
    tempDate =
        DateTime(tempDate.year, tempDate.month + addedMonths, tempDate.day);
    return DateFormat("dd/MM/y").format(tempDate).toString();
  }

  Future<DateTime?> _getDateFromUser(BuildContext mContext) async {
    DateTime? pickerDate = await showDatePicker(
      context: mContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    return pickerDate;
  }
}

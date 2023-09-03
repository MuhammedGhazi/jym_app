import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import '../../manag/cubits/subs_cubit/subs_cubit.dart';
import 'input_field.dart';
import 'my_button.dart';

class SubRenewal extends StatefulWidget {
  const SubRenewal({super.key, required this.subM});
  final SubscriberModel subM;

  @override
  State<SubRenewal> createState() => _SubRenewalState();
}

class _SubRenewalState extends State<SubRenewal> {
  String? recodTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Column(
        children: [
          Text(widget.subM.fullName.toString()),
          SizedBox(
            height: 10,
          ),
          Text(widget.subM.category.toString()),
          InputField(
            title: " renewal record to ",
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
            lable: "renewal",
            onTap: () {},
          ),
          const SizedBox(height: 5),
          MyButton(
            lable: "archive",
            onTap: () {
              setState(() {
                BlocProvider.of<SubsCubit>(context)
                    .archiveSubs(widget.subM.id!);
                Navigator.pop(context);
                BlocProvider.of<SubsCubit>(context).fetchArchiveSubs();
              });
            },
          ),
          const SizedBox(height: 5),
          MyButton(
            lable: "delete",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  String _addMonthToDate(String oldDate, int addedMonths) {
    DateTime _tempDate = DateFormat("dd/MM/y").parse(oldDate);
    _tempDate =
        DateTime(_tempDate.year, _tempDate.month + addedMonths, _tempDate.day);
    return DateFormat("dd/MM/y").format(_tempDate).toString();
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
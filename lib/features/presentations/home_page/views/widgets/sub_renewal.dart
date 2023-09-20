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
          Text(
              "Name: ${widget.subM.fullName.toString()}            Sport: ${widget.subM.category.toString()}"),
          const SizedBox(height: 10),
          Text(
              "         Age: ${DateTime.now().year - widget.subM.age!}            Tall: ${widget.subM.tall}            Weight: ${widget.subM.weight}"),
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
          Row(
            children: [
              MyButton(
                lable: "renewal",
                onTap: () {
                  BlocProvider.of<SubsCubit>(context).renewalSubs(
                      widget.subM.id!,
                      recodTo ??
                          _addMonthToDate(
                              widget.subM.upToRecord.toString(), 1));
                  Navigator.pop(context);
                  BlocProvider.of<SubsCubit>(context).fetchActiveSubs();
                },
              ),
              const SizedBox(width: 5),
              MyButton(
                lable: "archive",
                onTap: () {
                  setState(() {
                    BlocProvider.of<SubsCubit>(context)
                        .archiveSubs(widget.subM.id!);
                    Navigator.pop(context);
                    BlocProvider.of<SubsCubit>(context).fetchActiveSubs();
                    BlocProvider.of<SubsCubit>(context).fetchArchiveSubs();
                  });
                },
              ),
              const SizedBox(width: 5),
              MyButton(
                lable: "delete",
                onTap: () {
                  setState(() {
                    BlocProvider.of<SubsCubit>(context)
                        .deleteSub(widget.subM.id!);
                    Navigator.pop(context);
                    BlocProvider.of<SubsCubit>(context).fetchActiveSubs();
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(widget.subM.note.toString())
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

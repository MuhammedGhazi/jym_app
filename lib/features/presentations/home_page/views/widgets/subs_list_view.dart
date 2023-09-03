import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/my_button.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/sub_tile.dart';

import 'input_field.dart';

class SubsListView extends StatelessWidget {
  const SubsListView({Key? key, required this.checkDate}) : super(key: key);
  final DateTime checkDate;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubsCubit, SubsState>(
      builder: (context, state) {
        List<SubscriberModel> subs =
            BlocProvider.of<SubsCubit>(context).allsubs ?? [];
        return Expanded(
            child: ListView.builder(
          itemCount: subs.length,
          itemBuilder: (context, index) {
            return
                //SubItem(subM: subs[index]);
                AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                  child: FadeInAnimation(
                      child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SubRenewal(
                                  subM: subs[index],
                                );
                              },
                            );
                          },
                          child: SubTile(
                            subs: subs[index],
                            checkDate: checkDate,
                          )))),
            );
          },
        ));
      },
    );
  }
}

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
          Text(widget.subM.category.toString()),
          InputField(
            title: " renewal record to ",
            hint: recodTo ?? widget.subM.upToRecord.toString(),
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
          const Text(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY),
          MyButton(
            lable: "lable",
            onTap: () {},
          )
        ],
      ),
    );
  }

  _addMonthToDate(String oldDate, int addedMonths) {}

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

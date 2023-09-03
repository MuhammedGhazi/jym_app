import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/core/constants/constants.dart';
import 'package:jym_app/core/constants/stylies.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/add_subs_cubit/add_subs_cubit.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/my_button.dart';
import 'package:numberpicker/numberpicker.dart';

import '../manag/cubits/cubit/theme_cubit.dart';
import 'widgets/input_field.dart';
import 'widgets/input_field2.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key, required Text title}) : super(key: key);

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  int _age = 20;
  int _tall = 175;
  int _weight = 75;
  String _note = "notes";
  DateTime _selectedDate = DateTime.now();
  DateTime _upToDate = DateTime(
      DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);

  String _selectedClass = "GYM";
  List<String> classList = [
    "GYM",
    "karati",
    "Karate",
    "Judo",
    "boxing",
    "taekwondo"
  ];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThemeCubit>();
    final cubitAddSubs = context.read<AddSubsCubit>();
    final cubitSubs = context.read<SubsCubit>();
    return BlocListener<AddSubsCubit, AddSubsState>(
      listener: (context, state) {},
      child: Scaffold(
        //  backgroundColor: ,
        appBar: _myAppBar(context, cubit),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Al_DANA GYM",
                    style: Stylies.headingStyle(),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InputField(
                        hint: 'Enter your full name',
                        title: 'Full Name',
                        controller: _titleController,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/jym_profile.jpeg"),
                      radius: 50,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: InputField2(
                        hint: "year",
                        title: 'age',
                        widget: NumberPicker(
                          itemWidth: 50,
                          selectedTextStyle: const TextStyle(fontSize: 18),
                          itemCount: 1,
                          minValue: 4,
                          maxValue: 70,
                          value: _age,
                          onChanged: (value) {
                            setState(() {
                              _age = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: InputField2(
                        hint: "Cm",
                        title: 'Tall',
                        widget: NumberPicker(
                          itemWidth: 50,
                          selectedTextStyle: const TextStyle(fontSize: 18),
                          itemCount: 1,
                          minValue: 30,
                          maxValue: 220,
                          value: _tall,
                          onChanged: (value) {
                            setState(() {
                              _tall = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: InputField2(
                        hint: 'KG',
                        title: 'weight',
                        widget: NumberPicker(
                          itemWidth: 50,
                          selectedTextStyle: const TextStyle(fontSize: 18),
                          itemCount: 1,
                          minValue: 20,
                          maxValue: 150,
                          value: _weight,
                          onChanged: (value) {
                            setState(() {
                              _weight = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                InputField(
                  hint: _selectedClass,
                  title: 'category',
                  controller: _classController,
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items:
                        classList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedClass = value!;
                      });
                    },
                  ),
                ),
                InputField(title: "note", hint: "$_note"),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: "date record",
                        hint: DateFormat('dd/MM/y').format(_selectedDate),
                        widget: IconButton(
                            onPressed: () async {
                              DateTime? dt = await _getDateFromUser(context);
                              if (dt != null) {
                                setState(() {
                                  _selectedDate = dt;
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_today_outlined)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InputField(
                        title: "record up to",
                        hint: DateFormat('dd/MM/y').format(_upToDate),
                        widget: IconButton(
                            onPressed: () async {
                              DateTime? dt = await _getDateFromUser(context);
                              if (dt != null) {
                                setState(() {
                                  _upToDate = dt;
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_today_outlined)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _colorPallete(),
                    MyButton(
                        lable: "Add subscriber",
                        onTap: () {
                          _validateDate(cubitAddSubs);
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateDate(AddSubsCubit cubitAddSubs) {
    if (_titleController.text.isNotEmpty) {
      cubitAddSubs.addSub(SubscriberModel(
          fullName: _titleController.text,
          category: _selectedClass,
          dateRecord: DateFormat('dd/MM/y').format(_selectedDate).toString(),
          note: _note,
          age: _age,
          tall: _tall,
          weight: _weight,
          archive: 0,
          upToRecord: DateFormat('dd/MM/y').format(_upToDate)));

      Navigator.pop(context);
      BlocProvider.of<SubsCubit>(context).fetchArchiveSubs();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("all feiled id required..")));
    }
  }

  Column _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Colors",
          style: Stylies.titleStyle(),
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
              3,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: index == 0
                            ? primaryClr
                            : index == 1
                                ? pinkClr
                                : yellowClr,
                        child: _selectedColor == index
                            ? const Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                            : Container(),
                      ),
                    ),
                  )),
        )
      ],
    );
  }

  AppBar _myAppBar(BuildContext context, ThemeCubit cubit) {
    return AppBar(
      elevation: 0,
      backgroundColor: cubit.isDartMode ? Colors.black12 : Colors.white,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.grey,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/jym_pro2.jpeg"),
          radius: 25,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
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

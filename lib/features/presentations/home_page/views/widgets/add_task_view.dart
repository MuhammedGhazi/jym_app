import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/core/constants/stylies.dart';

import '../../manag/cubits/cubit/theme_cubit.dart';
import 'input_field.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key, required Text title}) : super(key: key);

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  DateTime _selectedDate = DateTime.now();
  DateTime _upToDate = DateTime.now().add(Duration(days: 30));

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThemeCubit>();
    return Scaffold(
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
                children: const [
                  Expanded(
                    child: InputField(
                        hint: 'Enter your full name', title: 'Full Name'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/jym_profile.jpeg"),
                    radius: 50,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: InputField(hint: '175 cm', title: 'Tall'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InputField(hint: '75', title: 'weight'),
                  ),
                ],
              ),
              const InputField(hint: 'GYM', title: 'class'),
              const InputField(title: "note", hint: "enter your hints here"),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "date record",
                      hint: DateFormat.yMd().format(_selectedDate),
                      widget: IconButton(
                          onPressed: () async {
                            await _getDateFromUser(_selectedDate);
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
                      hint: DateFormat.yMd().format(_upToDate),
                      widget: IconButton(
                          onPressed: () async {
                            await _getDateFromUser(_upToDate);
                          },
                          icon: const Icon(Icons.calendar_today_outlined)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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

  Future _getDateFromUser(DateTime putDate) async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (pickerDate != null) {
      setState(() {
        putDate = pickerDate;
      });
    }
  }
}

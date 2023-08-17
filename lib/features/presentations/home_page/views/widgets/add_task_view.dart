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
                  "Add text",
                  style: Stylies.headingStyle(),
                ),
              ),
              const InputField(hint: 'enter your title', title: 'my title'),
              const InputField(title: "note", hint: "enter your hints here"),
              InputField(
                  title: "date", hint: DateFormat.yMd().format(_selectedDate)),
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
}

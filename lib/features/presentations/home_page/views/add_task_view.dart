import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/core/constants/constants.dart';
import 'package:jym_app/core/constants/stylies.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/add_subs_cubit/add_subs_cubit.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/my_button.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import '../manag/cubits/category_cubit/category_cubit.dart';
import '../manag/cubits/them_cubit/theme_cubit.dart';
import 'widgets/input_field.dart';
import 'widgets/input_field2.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key, required Text title}) : super(key: key);
  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _titleController = TextEditingController();
  int _age = 20;
  int _tall = 175;
  int _weight = 75;
  //String _note = "notes";
  DateTime _selectedDate = DateTime.now();
  DateTime _upToDate = DateTime(
      DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);
  String _selectedClass = "GYM";
  int _selectedColor = 0;
  File? _imageFile;
  File? saveImagePath;
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 300);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });
    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    saveImagePath = await _imageFile!.copy('${apDir.path}/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThemeCubit>();
    final cubitAddSubs = context.read<AddSubsCubit>();
    return BlocListener<AddSubsCubit, AddSubsState>(
      listener: (context, state) {},
      child: Scaffold(
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
                    "نادي الدانا الرياضي",
                    style: Stylies.headingStyle(),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InputField(
                        hint: 'ادخل الاسم الكامل',
                        title: 'الاسم الكامل',
                        controller: _titleController,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        _takePicture();
                      },
                      child: CircleAvatar(
                        backgroundImage: _imageFile == null
                            ? null
                            : FileImage(File(_imageFile!.path)),
                        radius: 50,
                        child: _imageFile == null
                            ? const Icon(Icons.add_a_photo)
                            : null,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: InputField2(
                        hint: "سنة",
                        title: 'العمر',
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
                        title: 'الطول',
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
                        title: 'الوزن',
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
                  title: 'الرياضة',
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: BlocProvider.of<CategoryCubit>(context)
                        .categories
                        .map<DropdownMenuItem<String>>((String value) {
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
                // InputField(title: "note", hint: _note),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: "تاريخ التسجيل",
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
                        title: "سجل لتاريخ",
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
                    // _colorPallete(),
                    MyButton(
                        lable: "إضافة",
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
          note:
              "سجل لأول مرة في  :${DateFormat('dd/MM/y').format(_selectedDate).toString()} لغاية ${DateFormat('dd/MM/y').format(_upToDate)} \n",
          age: DateTime.now().year - _age,
          tall: _tall,
          weight: _weight,
          archive: 0,
          image: saveImagePath,
          upToRecord: DateFormat('dd/MM/y').format(_upToDate)));

      Navigator.pop(context);
      BlocProvider.of<SubsCubit>(context).fetchActiveSubs();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("جميع الحقول مطلوبة ..")));
    }
  }

  Column _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "اللون",
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

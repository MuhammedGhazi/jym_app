import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/core/constants/constants.dart';
import 'package:jym_app/core/constants/stylies.dart';
import 'package:jym_app/core/utils/services/notification_services.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/cubit/theme_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/my_button.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    NotifyHelper.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThemeCubit>();
    DateTime _selectedDate = DateTime.now();
    return Scaffold(
      appBar: _myAppBar(cubit),
      body: Column(
        children: [_addTaskBar(), _addDateBar(_selectedDate)],
      ),
    );
  }

  Container _addDateBar(DateTime _selectedDate) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        dayTextStyle:
            GoogleFonts.lato(textStyle: const TextStyle(fontSize: 15)),
        monthTextStyle:
            GoogleFonts.lato(textStyle: const TextStyle(fontSize: 15)),
        onDateChange: (selectedDate) {
          _selectedDate = selectedDate;
          print(selectedDate.toString());
        },
      ),
    );
  }

  Padding _addTaskBar() {
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
              lable: "+ add Task",
              onTap: (() => Navigator.of(context).pushNamed('addTask')))
        ],
      ),
    );
  }

  AppBar _myAppBar(ThemeCubit cubit) {
    return AppBar(
      elevation: 0,
      backgroundColor: cubit.isDartMode ? Colors.black12 : Colors.white,
      leading: GestureDetector(
        onTap: () {
          setState(() {
            cubit.taggleTheme();
            NotifyHelper.showBigTextNotification(
                title: "change theme ",
                body: cubit.isDartMode
                    ? "change mode to dark"
                    : "change mod to light",
                fln: flutterLocalNotificationsPlugin);
          });
        },
        child: IconMode(cubit: cubit),
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

class IconMode extends StatelessWidget {
  const IconMode({
    super.key,
    required this.cubit,
  });

  final ThemeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return cubit.isDartMode
        ? const Icon(
            Icons.sunny,
            size: 20,
          )
        : const Icon(
            Icons.nightlight_round_sharp,
            size: 20,
            color: Colors.black54,
          );
  }
}

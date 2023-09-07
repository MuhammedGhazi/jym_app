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
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/subscripers._view.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/my_button.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/subs_list_view.dart';

import 'widgets/icon_mode.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //DateTime _selectedTime = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SubsCubit>(context).fetchActiveSubs();
    BlocProvider.of<SubsCubit>(context).fetchArchiveSubs();
    NotifyHelper.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThemeCubit>();

    final cubitSubs = context.read<SubsCubit>();
    DateTime selectedDate = DateTime.now();
    var subs = cubitSubs.fetchActiveSubs();
    return Scaffold(
        appBar: _myAppBar(cubit),
        body: Column(
          children: [
            _addTaskBar(),
            _addDateBar(selectedDate),
            const SizedBox(height: 10),
            SubsListView(checkDate: _selectedDate),
          ],
        ));
  }

  Container _addDateBar(DateTime selectedDate) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10),
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
        onDateChange: (datem) {
          setState(() {
            _selectedDate = datem;
          });
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
              lable: " New subscriber",
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
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SubscripersView(),
              ));
              //BlocProvider.of<SubsCubit>(context).delDB();
            },
            icon: const Icon(
              Icons.person,
              color: Colors.grey,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.grey,
            )),
        const CircleAvatar(
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jym_app/core/utils/services/notification_services.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/cubit/theme_cubit.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            cubit.taggleTheme();
            NotifyHelper.showBigTextNotification(
                title: "change theme ",
                body: cubit.state == ThemeMode.dark
                    ? "change mode to dark"
                    : "change mod to light",
                fln: flutterLocalNotificationsPlugin);
          },
          child: Icon(
            cubit.state != ThemeMode.dark
                ? Icons.nightlight_round
                : Icons.sunny,
            size: 20,
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/jym_pro2.jpeg"),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(),
    );
  }

  // _appBar() {
  //   return AppBar(
  //     leading: GestureDetector(
  //       onTap: () {
  //         //   final cubit =context.read<ThemeCubit>();
  //         ThemeCubit().taggleTheme();
  //       },
  //       child: const Icon(
  //         Icons.nightlight_round,
  //         size: 20,
  //       ),
  //     ),
  //     actions: const [
  //       Icon(
  //         Icons.person,
  //         size: 20,
  //       ),
  //       SizedBox(
  //         width: 20,
  //       )
  //     ],
  //   );
  // }
}

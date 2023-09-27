import 'package:flutter/material.dart';
import 'package:jym_app/core/utils/services/notification_services.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/them_cubit/theme_cubit.dart';

import '../home_page.dart';
import '../subscripers._view.dart';
import 'icon_mode.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.cubit});
  final ThemeCubit cubit;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: widget.cubit.isDartMode ? Colors.black12 : Colors.white,
      leading: GestureDetector(
        onTap: () {
          setState(() {
            widget.cubit.taggleTheme();
            NotifyHelper.showBigTextNotification(
                title: "change theme ",
                body: widget.cubit.isDartMode
                    ? "change mode to dark"
                    : "change mod to light",
                fln: flutterLocalNotificationsPlugin);
          });
        },
        child: IconMode(cubit: widget.cubit),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SubscripersView(),
              ));
            },
            icon: const Icon(
              Icons.person,
              color: Colors.grey,
            )),
        // IconButton(
        //     onPressed: () {
        //       //   Scaffold.of(context).openDrawer();
        //       // scaffoldKey.currentState!.openDrawer();
        //       //  BlocProvider.of<SubsCubit>(context).delDB();
        //     },
        //     icon: const Icon(
        //       Icons.settings,
        //       color: Colors.grey,
        //     )),

        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed("statistics"),
          child: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/jym_pro2.jpeg"),
            radius: 25,
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}

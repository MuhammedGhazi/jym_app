import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'package:jym_app/core/utils/theme/theme.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/cubit/theme_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/home_page.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/add_task_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Themes.light,
            themeMode: state,
            darkTheme: Themes.dark,
            home: const HomePage(),
            routes: <String, WidgetBuilder>{
              'addTask': (BuildContext context) =>
                  const AddTaskView(title: Text('page A')),
              // '/b': (BuildContext context) => const MyPage(title: Text('page B')),
              // '/c': (BuildContext context) => const MyPage(title: Text('page C')),
            },
          );
        },
      ),
    );
  }
}

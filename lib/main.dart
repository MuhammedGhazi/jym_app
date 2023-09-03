import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'package:jym_app/core/utils/theme/theme.dart';
import 'package:jym_app/features/presentations/home_page/manag/block_observer.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/add_subs_cubit/add_subs_cubit.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/cubit/theme_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/home_page.dart';
import 'package:jym_app/features/presentations/home_page/views/add_task_view.dart';

import 'features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';

//import 'features/presentations/home_page/manag/cubits/theme_cubit/theme_cubit.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (BuildContext context) => ThemeCubit(),
        ),
        BlocProvider<AddSubsCubit>(
          create: (BuildContext context) => AddSubsCubit(),
        ),
        BlocProvider<SubsCubit>(
          create: (BuildContext context) => SubsCubit(),
        ),
      ],
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
            },
          );
        },
      ),
    );
  }
}

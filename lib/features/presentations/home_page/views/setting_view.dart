import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/category_cubit/category_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/category_list_view.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/input_field.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  late List<String> listCategories;
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final catgCubit = context.read<CategoryCubit>();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                      hintText: "Enter new category",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18))),
                )),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_categoryController.text.isNotEmpty) {
                      setState(() {
                        catgCubit.categories.add(_categoryController.text);
                        _categoryController.text = "";
                      });
                    } else {}
                  },
                  child: const Text("add category"),
                  style: ButtonStyle(alignment: AlignmentDirectional.center),
                )
              ],
            ),
          ),
          CategoryListView(),
        ],
      ),
    );
  }
}

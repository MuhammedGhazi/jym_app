import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jym_app/core/constants/constants.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/archive_view.dart';

import 'widgets/input_field.dart';
import 'widgets/subs_list_view2.dart';

class SubscripersView extends StatefulWidget {
  const SubscripersView({Key? key}) : super(key: key);

  @override
  State<SubscripersView> createState() => _SubscripersViewState();
}

class _SubscripersViewState extends State<SubscripersView> {
  final TextEditingController _classController = TextEditingController();
  String _selectedClass = "karati";
  List<String> cList = classList.toList();
  @override
  void initState() {
    cList.add("All");
    BlocProvider.of<SubsCubit>(context).fetchActiveSubs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubsCubit, SubsState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Subscripers'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ArchiveView(),
                  ));
                },
                icon: const Icon(Icons.archive))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: InputField(
                hint: _selectedClass,
                title: 'category',
                controller: _classController,
                widget: DropdownButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: cList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedClass = value!;
                      BlocProvider.of<SubsCubit>(context)
                          .fetchActiveSubs(cate: _selectedClass);
                    });
                  },
                ),
              ),
            ),
            SubsListView2(category: _selectedClass),
          ],
        ),
      ),
    );
  }
}

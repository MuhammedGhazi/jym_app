import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jym_app/core/constants/constants.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/archive_view.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/subs_list_view_standard.dart';

import 'widgets/input_field.dart';

import 'widgets/subs_list_view2.dart';

class SubscripersView extends StatefulWidget {
  const SubscripersView({Key? key}) : super(key: key);

  @override
  State<SubscripersView> createState() => _SubscripersViewState();
}

class _SubscripersViewState extends State<SubscripersView> {
  final TextEditingController _classController = TextEditingController();
  String _selectedClass = "All";
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
                  // List<String> names = [];
                  // for (var element
                  //     in BlocProvider.of<SubsCubit>(context).classActiveSubs!) {
                  //   names.add(element.fullName!);
                  // }
                  var Subs =
                      BlocProvider.of<SubsCubit>(context).classActiveSubs ?? [];

                  showSearch(
                      context: context,
                      delegate: CustomSearchDelegateSubs(Subs));
                },
                icon: const Icon(Icons.search)),
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

class CustomSearchDelegateSubs extends SearchDelegate {
  CustomSearchDelegateSubs(this.subsModel);
  List<SubscriberModel> subsModel;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<SubscriberModel> matchQuery = [];
    for (var element in subsModel) {
      if (element.fullName!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    return SubsListViewStandard(subs: matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SubscriberModel> matchQuery = [];
    for (var element in subsModel) {
      if (element.fullName!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    return SubsListViewStandard(subs: matchQuery);
  }
}

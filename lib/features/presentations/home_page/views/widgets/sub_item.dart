import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';

class SubItem extends StatelessWidget {
  const SubItem({Key? key, required this.subM}) : super(key: key);
  final SubscriberModel subM;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(subM.fullName.toString()),
              subtitle: Text(subM.category.toString()),
            ),
          ),
          const VerticalDivider(),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<SubsCubit>(context).deleteSub(subM.id!);
                    BlocProvider.of<SubsCubit>(context).fetchAllSubs();
                  },
                  child: const Text("أرشيف")),
              ElevatedButton(onPressed: () {}, child: const Text("اشتراك")),
            ],
          )
        ],
      ),
    );
  }
}

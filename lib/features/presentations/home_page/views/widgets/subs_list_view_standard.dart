import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';
import 'sub_renewal.dart';
import 'sub_tile2.dart';

class SubsListViewStandard extends StatelessWidget {
  const SubsListViewStandard({Key? key, required this.subs}) : super(key: key);
  final List<SubscriberModel> subs;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubsCubit, SubsState>(
      builder: (context, state) {
        return Expanded(
            child: ListView.builder(
          itemCount: subs.length,
          itemBuilder: (context, index) {
            return
                //SubItem(subM: subs[index]);
                AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                  child: FadeInAnimation(
                      child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SubRenewal(
                                  subM: subs[index],
                                );
                              },
                            );
                          },
                          child: SubTile2(
                            subs: subs[index],
                          )))),
            );
          },
        ));
      },
    );
  }
}

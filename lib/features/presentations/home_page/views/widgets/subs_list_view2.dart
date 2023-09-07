import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';
import 'sub_renewal.dart';
// import 'sub_renewal2.dart';
import 'sub_tile2.dart';

class SubsListView2 extends StatelessWidget {
  const SubsListView2({Key? key, this.category = "GYM"}) : super(key: key);
  final String category;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubsCubit, SubsState>(
      builder: (context, state) {
        List<SubscriberModel> subs =
            BlocProvider.of<SubsCubit>(context).classActiveSubs ?? [];
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

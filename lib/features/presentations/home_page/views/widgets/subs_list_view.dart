import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/add_subs_cubit/add_subs_cubit.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/sub_item.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/sub_tile.dart';

class SubsListView extends StatelessWidget {
  const SubsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubsCubit, SubsState>(
      builder: (context, state) {
        List<SubscriberModel> subs =
            BlocProvider.of<SubsCubit>(context).allsubs ?? [];
        return Expanded(
            child: ListView.builder(
          itemCount: subs.length,
          itemBuilder: (context, index) {
            return
                //SubItem(subM: subs[index]);
                AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                  child: FadeInAnimation(child: SubTile(subs: subs[index]))),
            );
          },
        ));
      },
    );
  }
}

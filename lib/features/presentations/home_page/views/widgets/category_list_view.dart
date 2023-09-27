import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/category_cubit/category_cubit.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/catg_renewal.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/catg_tile.dart';

import '../../../../../core/utils/services/catogary_service.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final catCubit = context.read<CategoryCubit>();

    List<String> catg = catCubit.categories;

    return BlocBuilder<CategoryCubit, CatogaryService>(
      builder: (context, state) {
        return Expanded(
            child: ListView.builder(
          itemCount: catg.length,
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
                                        return CatgRenewal(catg: catg[index]);
                                      });
                                },
                                child: CatgTile(
                                  catg: catg[index],
                                )))));
          },
        ));
      },
    );
  }
}

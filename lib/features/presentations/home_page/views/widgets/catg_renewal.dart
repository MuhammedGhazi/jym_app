import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/category_cubit/category_cubit.dart';
import 'my_button.dart';

class CatgRenewal extends StatefulWidget {
  const CatgRenewal({super.key, required this.catg});
  final String catg;

  @override
  State<CatgRenewal> createState() => _CatgRenewalState();
}

class _CatgRenewalState extends State<CatgRenewal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Column(
        children: [
          Text(widget.catg),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(height: 5),
          MyButton(
            lable: "delete",
            onTap: () {
              setState(() {
                BlocProvider.of<CategoryCubit>(context).removeCatg(widget.catg);
                Navigator.pop(context);
                // BlocProvider.of<SubsCubit>(context).fetchActiveSubs();
              });
            },
          ),
        ],
      ),
    );
  }
}

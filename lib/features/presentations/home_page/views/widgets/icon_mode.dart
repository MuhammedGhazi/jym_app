import 'package:flutter/material.dart';

import '../../manag/cubits/them_cubit/theme_cubit.dart';

class IconMode extends StatelessWidget {
  const IconMode({
    super.key,
    required this.cubit,
  });

  final ThemeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return cubit.isDartMode
        ? const Icon(
            Icons.sunny,
            size: 20,
          )
        : const Icon(
            Icons.nightlight_round_sharp,
            size: 20,
            color: Colors.black54,
          );
  }
}

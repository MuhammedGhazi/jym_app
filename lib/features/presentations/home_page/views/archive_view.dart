import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/subs_list_view3.dart';

import '../manag/cubits/subs_cubit/subs_cubit.dart';
// import 'package:intl/intl.dart';
// import 'package:jym_app/features/presentations/home_page/views/widgets/subs_list_view3.dart';

//import 'widgets/subs_list_view2.dart';

class ArchiveView extends StatelessWidget {
  const ArchiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            " All Archive Subscribers : ${BlocProvider.of<SubsCubit>(context).allArchiveSubs == null ? 0 : BlocProvider.of<SubsCubit>(context).allArchiveSubs!.length}"),
      ),
      body: Column(
        children: const [
          SubsListView3(),
        ],
      ),
    );
  }
}

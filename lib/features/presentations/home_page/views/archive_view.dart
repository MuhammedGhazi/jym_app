import 'package:flutter/material.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/subs_list_view3.dart';
// import 'package:intl/intl.dart';
// import 'package:jym_app/features/presentations/home_page/views/widgets/subs_list_view3.dart';

//import 'widgets/subs_list_view2.dart';

class ArchiveView extends StatelessWidget {
  const ArchiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Archive Subscripers'),
      ),
      body: Column(
        children: const [
          SubsListView3(),
        ],
      ),
    );
  }
}

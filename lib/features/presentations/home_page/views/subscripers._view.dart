import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/features/presentations/home_page/views/archive_view.dart';

import 'widgets/subs_list_view2.dart';

class SubscripersView extends StatelessWidget {
  const SubscripersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Subscripers'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const archiveView(),
                ));
              },
              icon: const Icon(Icons.archive))
        ],
      ),
      body: Column(
        children: const [
          SubsListView2(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          DataTable(
            columns: const [
              DataColumn(label: Text("category")),
              DataColumn(label: Text("num")),
              DataColumn(label: Text("age")),
              DataColumn(label: Text("wieght")),
            ],
            rows: getLDR(context),
          ),
        ],
      ),
    );
  }

  List<DataRow> getLDR(BuildContext context) {
    List<Map> infocatg = BlocProvider.of<SubsCubit>(context).infoCatg!;
    List<DataRow> tempInfo = [];
    for (var e in infocatg) {
      tempInfo.add(getInfoCatg(e));
    }
    return tempInfo;
  }

  DataRow getInfoCatg(Map dRow) {
    List<DataCell> dC = [];
    dRow.forEach((key, value) {
      dC.add(DataCell(Text("$value")));
    });

    return DataRow(cells: dC);
  }
}

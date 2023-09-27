import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/subs_cubit/subs_cubit.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            " إجمالي عدد المشتركين : ${BlocProvider.of<SubsCubit>(context).allActiveSubs == null ? 0 : BlocProvider.of<SubsCubit>(context).allActiveSubs!.length}"),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text("الرياضة")),
            DataColumn(label: Text("العدد")),
            DataColumn(label: Text("معدل\n العمر")),
            DataColumn(label: Text("معدل\n الوزن")),
          ],
          rows: getLDR(context),
        ),
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
    dRow.forEach((k, v) {
      dC.add(DataCell(Text("${k == "AvAge" ? DateTime.now().year - v : v}")));
    });

    return DataRow(cells: dC);
  }
}

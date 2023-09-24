import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/data/repos/subscriber_repo.dart';
import 'package:meta/meta.dart';

part 'subs_state.dart';

class SubsCubit extends Cubit<SubsState> {
  SubsCubit() : super(SubsInitial());
  SubsRepo subsRepo = SubsRepo();
  List<SubscriberModel>? allsubs;
  List<SubscriberModel>? allActiveSubs;
  List<SubscriberModel>? classActiveSubs;
  List<SubscriberModel>? allArchiveSubs;
  List<Map>? infoCatg;
  fetchAllSubs() async {
    allsubs = await subsRepo.getSubs();
    emit(SubsSuccess());
  }

  fetchArchiveSubs() async {
    allArchiveSubs = await subsRepo.getActiveSubs(archive: 1);

    emit(SubsSuccess());
  }

  fetchActiveSubs({String cate = "All"}) async {
    allActiveSubs = await subsRepo.getActiveSubs();
    classActiveSubs = await subsRepo.getCategorySubs(category: cate);
    infoCatg = await subsRepo.infoCatg();
    emit(SubsSuccess());
  }

  archiveSubs(int id) async {
    await subsRepo.archiveSub(id);
    emit(SubsSuccess());
  }

  renewalSubs(int id, String newDate) async {
    await subsRepo.renewalSub(id, newDate);
    fetchActiveSubs();
    emit(SubsSuccess());
  }

  deleteSub(int id) {
    subsRepo.delete(id);
  }

  delDB() {
    subsRepo.deleteDB();
  }
}

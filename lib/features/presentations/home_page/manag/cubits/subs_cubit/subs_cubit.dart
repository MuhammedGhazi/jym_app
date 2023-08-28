import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/data/repos/subscriber_repo.dart';
import 'package:meta/meta.dart';

part 'subs_state.dart';

class SubsCubit extends Cubit<SubsState> {
  SubsCubit() : super(SubsInitial());
  SubsRepo subsRepo = SubsRepo();
  List<SubscriberModel>? allsubs;
  fetchAllSubs() async {
    allsubs = await subsRepo.getSubs();
    emit(SubsSuccess());
  }
}

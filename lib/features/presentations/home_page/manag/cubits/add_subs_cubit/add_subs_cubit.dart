import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/data/repos/subscriber_repo.dart';
import 'package:meta/meta.dart';

part 'add_subs_state.dart';

class AddSubsCubit extends Cubit<AddSubsState> {
  AddSubsCubit() : super(AddSubsInitial());
  SubsRepo subsRepo = SubsRepo();
  SubscriberModel? allsubs;
  addSub(SubscriberModel subscriberModel) async {
    int a = await subsRepo.add(subscriberModel);
    print(a);
  }

  delDB() {
    subsRepo.deleteDB();
  }

  Future<List<SubscriberModel>> getAllSubs() async {
    List<SubscriberModel> allSubs = await subsRepo.getSubs();
    return allSubs;
  }
}

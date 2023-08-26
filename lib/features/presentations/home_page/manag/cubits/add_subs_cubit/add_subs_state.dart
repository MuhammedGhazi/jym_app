part of 'add_subs_cubit.dart';

@immutable
abstract class AddSubsState {}

class AddSubsInitial extends AddSubsState {}

class AddSubsSuccess extends AddSubsState {}

class AddSubsLoading extends AddSubsState {}

class AddSubsFailure extends AddSubsState {
  final String errMessage;

  AddSubsFailure(this.errMessage);
}

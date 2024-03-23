part of 'tsk_bloc.dart';

@immutable
sealed class TskState {}

final class TskInitial extends TskState {}

final class TskLoaded extends TskState {
  TskLoaded({
    required this.tasksList,
  });

  final List<Task> tasksList;
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/tasks.dart';

part 'tsk_event.dart';
part 'tsk_state.dart';

class TskBloc extends Bloc<TskEvent, TskState> {
  TskBloc() : super(TskInitial()) {
    on<LoadTaskList>((event, emit) {
      final List<Task> tasksList = tasks;
      emit(TskLoaded(tasksList: tasksList));
    });
  }
}

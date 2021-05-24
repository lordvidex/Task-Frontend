import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/models/task.dart';
import '../../domain/usecases/edit_task_status_usecase.dart';
import '../../domain/usecases/fetch_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FetchTasksUsecase _fetchTaskUsecase;
  final EditTaskStatusUsecase _editTaskStatusUsecase;
  TaskBloc(
      {required FetchTasksUsecase fetchTaskUsecase,
      required EditTaskStatusUsecase editTaskStatusUsecase})
      : _fetchTaskUsecase = fetchTaskUsecase,
        _editTaskStatusUsecase = editTaskStatusUsecase,
        super(TaskInitial()) {
    add(FetchTasksEvent());
  }

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is FetchTasksEvent) {
      yield* _mapFetchTasksEventToState(event);
    } else if (event is EditTaskStatusEvent) {
      yield* _mapEditTaskStatusEventToState(event);
    }
  }

  Stream<TaskState> _mapFetchTasksEventToState(FetchTasksEvent event) async* {
    final result = await _fetchTaskUsecase(
        searchTerm: event.searchTerm, status: event.taskStatus);
    yield result.fold((failure) {
      return TaskFailureState(failure.toString());
    }, (tasks) {
      return TaskLoaded(tasks);
    });
  }

  Stream<TaskState> _mapEditTaskStatusEventToState(
      EditTaskStatusEvent event) async* {
    final result = await _editTaskStatusUsecase(event.id, event.status);
    result.fold((failure) async* {
      yield TaskFailureState(failure.toString());
    }, (_) {});
  }
}

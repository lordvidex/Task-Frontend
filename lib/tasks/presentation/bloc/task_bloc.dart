import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/failure.dart';
import '../../domain/models/task.dart';
import '../../domain/usecases/create_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/edit_task_status_usecase.dart';
import '../../domain/usecases/fetch_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FetchTasksUsecase _fetchTaskUsecase;
  final EditTaskStatusUsecase _editTaskStatusUsecase;
  final CreateTaskUsecase _createTaskUsecase;
  final DeleteUsecase _deleteUsecase;
  // storing the last event queries to refetch the stream
  // new data after creating a new task or updating status
  // of an existing task.
  TaskEvent? _lastFetchEvent;

  TaskBloc(
      {required FetchTasksUsecase fetchTaskUsecase,
      required EditTaskStatusUsecase editTaskStatusUsecase,
      required CreateTaskUsecase createTaskUsecase,
      required DeleteUsecase deleteUsecase})
      : _fetchTaskUsecase = fetchTaskUsecase,
        _editTaskStatusUsecase = editTaskStatusUsecase,
        _createTaskUsecase = createTaskUsecase,
        _deleteUsecase = deleteUsecase,
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
    } else if (event is CreateTaskEvent) {
      yield* _mapCreateTaskEventToState(event);
    } else if (event is DeleteTaskEvent) {
      yield* _mapDeleteTaskEventToState(event);
    }
  }

  Stream<TaskState> _mapFetchTasksEventToState(FetchTasksEvent event) async* {
    yield TaskLoading();
    _lastFetchEvent = event;
    final result = await _fetchTaskUsecase(
        searchTerm: event.searchTerm, status: event.taskStatus);
    yield result.fold(_handleFailure, (tasks) {
      return TaskLoaded(tasks);
    });
  }

  Stream<TaskState> _mapEditTaskStatusEventToState(
      EditTaskStatusEvent event) async* {
    final result = await _editTaskStatusUsecase(event.id, event.status);
    yield result.fold(
        _handleFailure,
        (_) => TaskStatusUpdatedState(
            'Task "${event.taskTitle}" has been updated with status ${event.status}'));
  }

  Stream<TaskState> _mapCreateTaskEventToState(CreateTaskEvent event) async* {
    final result = await _createTaskUsecase(event.title, event.description);
    yield result.fold(_handleFailure, (_) {
      add(_lastFetchEvent!);
      return TaskCreatedState('New task ${event.title} added!');
    });
  }

  Stream<TaskState> _mapDeleteTaskEventToState(DeleteTaskEvent event) async* {
    final result = await _deleteUsecase(event.taskId);
    yield result.fold(_handleFailure, (_) {
      add(_lastFetchEvent!);
      return TaskDeletedState('Task ${event.taskTitle} has been deleted!');
    });
  }

  TaskState _handleFailure(Failure failure) =>
      TaskFailureState(failure.toString());
}

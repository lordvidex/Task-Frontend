part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  TaskLoaded(this.tasks);
}

class TaskFailureState extends TaskState {
  final String message;
  TaskFailureState(this.message);
}

class TaskDeletedState extends TaskState {
  final String message;
  TaskDeletedState(this.message);
}

class TaskStatusUpdatedState extends TaskState {
  final String message;
  TaskStatusUpdatedState(this.message);
}

class TaskCreatedState extends TaskState {
  final String message;
  TaskCreatedState(this.message);
}

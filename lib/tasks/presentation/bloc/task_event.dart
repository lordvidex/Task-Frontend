part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class EditTaskStatusEvent extends TaskEvent {
  final int id;
  final TaskStatus status;
  final String taskTitle;
  EditTaskStatusEvent(this.id, this.status, this.taskTitle);
}

class CreateTaskEvent extends TaskEvent {
  final String title;
  final String description;
  CreateTaskEvent({
    required this.title,
    required this.description,
  });
}

class FetchTasksEvent extends TaskEvent {
  final String? searchTerm;
  final String? taskStatus;
  FetchTasksEvent({String? searchTerm, String? taskStatus})
      : this.searchTerm =
            searchTerm == null || searchTerm.trim().isEmpty ? null : searchTerm,
        this.taskStatus =
            taskStatus == TaskStatus.ALL.getStringValue() ? null : taskStatus;
}

class DeleteTaskEvent extends TaskEvent {
  final int taskId;
  final String taskTitle;
  DeleteTaskEvent(this.taskId,this.taskTitle);
}
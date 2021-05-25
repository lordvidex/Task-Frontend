import 'package:taskmanagement_frontend/core/exceptions.dart';

import '../../../domain/models/task.dart';

class TaskResponse {
  final List<Task>? tasks;
  final Task? task;
  TaskResponse({this.tasks, this.task});
  factory TaskResponse.fromJson(dynamic data) {
    if (data is Map<String, dynamic>) {
      // error object returned
      if (data.containsKey('error')) {
        throw TaskException(
          data['message'],
          error: data['error'],
          statusCode: data['statusCode'],
        );
      }
      // single task object returned
      return TaskResponse(task: Task.fromJson(data));
    } else if (data is List) {
      return TaskResponse(tasks: data.map((x) => Task.fromJson(x)).toList());
    }
    throw TaskException('Failed to successfully fetch and parse Tasks');
  }
}

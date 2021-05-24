import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final int id;
  final String title;
  final String description;
  TaskStatus status;
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

enum TaskStatus {
  DONE,
  IN_PROGRESS,
  OPEN,
  ALL
}

extension T on TaskStatus {
  String getStringValue() {
    return this.toString().split('.')[1];
  }
}

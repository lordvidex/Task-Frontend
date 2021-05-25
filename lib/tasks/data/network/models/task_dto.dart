import 'package:json_annotation/json_annotation.dart';

part 'task_dto.g.dart';

@JsonSerializable(createFactory: false)
class TaskDto {
  final String title;
  final String description;

  TaskDto(this.title, this.description);

  Map<String, dynamic> toJson() => _$TaskDtoToJson(this);
}

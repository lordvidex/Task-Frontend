import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:taskmanagement_frontend/tasks/data/network/models/status_dto.dart';
import 'package:taskmanagement_frontend/tasks/data/network/models/task_response.dart';

import '../../../domain/models/task.dart';

part 'task_api.g.dart';

@RestApi()
abstract class TaskApi {
  factory TaskApi(Dio dio, {String baseUrl}) = _TaskApi;

  @GET('/tasks')
  Future<TaskResponse> fetchTasks(
    @Query('search') final String? searchTerm,
    @Query('status') final String? status,
  );

  @GET('/tasks/{id}')
  Future<Task> fetchTaskWithId(@Path('id') final String id);

  @PATCH('/tasks/{id}/status')
  Future<Task> patchTaskStatus(
      @Path('id') final int id, @Body() final StatusDto statusBody);
}

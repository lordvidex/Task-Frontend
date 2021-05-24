import 'package:dartz/dartz.dart' hide Task;
import 'package:dio/dio.dart';
import 'package:taskmanagement_frontend/core/exceptions.dart';
import 'package:taskmanagement_frontend/tasks/data/network/models/status_dto.dart';

import '../../../core/failure.dart';
import '../../domain/models/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../network/api/task_api.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskApi taskApi;
  TaskRepositoryImpl({required this.taskApi});

  @override
  Future<Either<Failure, List<Task>>> fetchTasks(
      {String? searchTerm, String? status}) async {
    try {
      final result = await this.taskApi.fetchTasks(searchTerm, status);
      return Right(result.tasks ?? []);
    } on TaskFetchException catch (e) {
      return Left(TaskFailure(e.toString()));
    } on DioError catch (e) {
      return Left(TaskFailure((e.response as Map<String,dynamic>)['message'] ?? 'An error occured'));
    }
  }

  @override
  Future<Either<Failure, void>> editTaskStatus(
      int id, TaskStatus status) async {
    try {
      await this.taskApi.patchTaskStatus(id, StatusDto(status.getStringValue()));
      return Right(null);
    } catch (e) {
      return Left(TaskFailure('Failed to edit task with id $id'));
    }
  }
}

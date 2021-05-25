import 'package:dartz/dartz.dart' hide Task;
import 'package:dio/dio.dart';

import '../../../core/exceptions.dart';
import '../../../core/failure.dart';
import '../../domain/models/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../network/api/task_api.dart';
import '../network/models/status_dto.dart';
import '../network/models/task_dto.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskApi taskApi;
  TaskRepositoryImpl({required this.taskApi});

  @override
  Future<Either<Failure, List<Task>>> fetchTasks(
      {String? searchTerm, String? status}) async {
    try {
      final result = await this.taskApi.fetchTasks(searchTerm, status);
      return Right(result.tasks ?? []);
    } on TaskException catch (e) {
      return Left(TaskFailure(e.toString()));
    } on DioError catch (e) {
      return Left(TaskFailure(e.errorMessage()));
    }
  }

  @override
  Future<Either<Failure, void>> editTaskStatus(
      int id, TaskStatus status) async {
    try {
      await taskApi.patchTaskStatus(id, StatusDto(status.getStringValue()));
      return Right(null);
    } on DioError catch (e) {
      return Left(
          TaskFailure('Failed to edit task with id $id, ${e.errorMessage()}'));
    }
  }

  @override
  Future<Either<Failure, void>> createTask(
      String title, String description) async {
    try {
      await taskApi.createTask(TaskDto(title, description));
      return Right(null);
    } on DioError catch (e) {
      return Left(TaskFailure(e.errorMessage()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTaskWithId(int id) async {
    try {
      await taskApi.deleteTask(id);
      return Right(null);
    } on DioError catch (e) {
      return Left(TaskFailure(e.errorMessage()));
    }
  }
}

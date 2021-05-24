import 'package:dartz/dartz.dart' hide Task;
import 'package:taskmanagement_frontend/tasks/domain/models/task.dart';

import '../../../core/failure.dart';
import '../repositories/task_repository.dart';

class FetchTasksUsecase {
  final TaskRepository taskRepo;
  FetchTasksUsecase(this.taskRepo);
  Future<Either<Failure, List<Task>>> call(
          {String? searchTerm, String? status}) =>
      taskRepo.fetchTasks(searchTerm: searchTerm, status: status);
}

import 'package:dartz/dartz.dart' hide Task;

import '../../../core/failure.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

class FetchTasksUsecase {
  final TaskRepository taskRepo;
  FetchTasksUsecase(this.taskRepo);
  Future<Either<Failure, List<Task>>> call(
          {String? searchTerm, String? status}) =>
      taskRepo.fetchTasks(searchTerm: searchTerm, status: status);
}

import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

class EditTaskStatusUsecase {
  final TaskRepository taskRepo;
  EditTaskStatusUsecase(this.taskRepo);
  
  Future<Either<Failure, void>> call(int id, TaskStatus status) =>
      taskRepo.editTaskStatus(id, status);
}

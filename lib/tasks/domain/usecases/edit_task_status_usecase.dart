import 'package:dartz/dartz.dart';
import 'package:taskmanagement_frontend/core/failure.dart';
import 'package:taskmanagement_frontend/tasks/domain/models/task.dart';
import 'package:taskmanagement_frontend/tasks/domain/repositories/task_repository.dart';

class EditTaskStatusUsecase {
  final TaskRepository taskRepo;
  EditTaskStatusUsecase(this.taskRepo);
  
  Future<Either<Failure, void>> call(int id, TaskStatus status) =>
      taskRepo.editTaskStatus(id, status);
}

import 'package:dartz/dartz.dart';
import 'package:taskmanagement_frontend/core/failure.dart';
import 'package:taskmanagement_frontend/tasks/domain/repositories/task_repository.dart';

class DeleteUsecase {
  final TaskRepository taskRepo;
  DeleteUsecase(this.taskRepo);
  Future<Either<Failure, void>> call(int id) => taskRepo.deleteTaskWithId(id);
}

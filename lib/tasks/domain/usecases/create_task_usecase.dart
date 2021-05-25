import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../repositories/task_repository.dart';

class CreateTaskUsecase {
  final TaskRepository taskRepo;
  CreateTaskUsecase(this.taskRepo);
  Future<Either<Failure, void>> call(String title, String description)
   => taskRepo.createTask(title,description);
}

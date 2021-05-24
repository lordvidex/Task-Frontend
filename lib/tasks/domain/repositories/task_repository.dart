import 'package:dartz/dartz.dart' hide Task;
import '../models/task.dart';
import '../../../core/failure.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> fetchTasks({String? searchTerm, String? status});

  Future<Either<Failure,void>> editTaskStatus(int id, TaskStatus status);
}

import 'package:dartz/dartz.dart';
import 'package:taskmanagement_frontend/core/failure.dart';
import '../../data/repositories/auth_repository.dart';

class AutoLoginUseCase {
  final AuthRepository authRepo;
  AutoLoginUseCase(this.authRepo);
  Future<Either<Failure, void>> call() => authRepo.autoLogin();
}
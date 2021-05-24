import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepo;
  LogoutUsecase(this.authRepo);
  Future<Either<Failure, void>> call() => authRepo.logout();
}

import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../repositories/auth_repository.dart';

class AutoLoginUsecase {
  final AuthRepository authRepo;
  AutoLoginUsecase(this.authRepo);
  Future<Either<Failure, void>> call() => authRepo.autoLogin();
}

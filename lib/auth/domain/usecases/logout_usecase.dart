import 'package:dartz/dartz.dart';
import '../../data/repositories/auth_repository.dart';
import '../../../core/failure.dart';

class LogoutUseCase {
  final AuthRepository authRepo;
  LogoutUseCase(this.authRepo);
  Future<Either<Failure, void>> call() => authRepo.logout();
}

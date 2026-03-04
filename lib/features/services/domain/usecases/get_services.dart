import 'package:dartz/dartz.dart';
import '../entities/service.dart';
import '../repositories/services_repository.dart';

class GetServices {
  final ServicesRepository repository;
  GetServices(this.repository);

  Future<Either<Exception, List<ServiceEntity>>> call() {
    return repository.getServices();
  }
}

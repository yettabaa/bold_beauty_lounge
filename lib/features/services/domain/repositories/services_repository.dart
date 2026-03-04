import 'package:dartz/dartz.dart';
import '../entities/service.dart';

abstract class ServicesRepository {
  Future<Either<Exception, List<ServiceEntity>>> getServices();
}

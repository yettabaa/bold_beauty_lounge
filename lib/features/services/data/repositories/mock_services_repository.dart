import 'package:dartz/dartz.dart';
import '../../domain/entities/service.dart';
import '../../domain/repositories/services_repository.dart';

class MockServicesRepository implements ServicesRepository {
  @override
  Future<Either<Exception, List<ServiceEntity>>> getServices() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Right([
      const ServiceEntity(
        id: '1',
        name: 'Massage relaxant',
        durationMinutes: 60,
        price: 220,
        description: 'Un massage relaxant pour détendre les muscles et évacuer le stress.',
      ),
      const ServiceEntity(
        id: '2',
        name: 'Soin du visage',
        durationMinutes: 45,
        price: 55,
        description: 'Soin complet du visage pour une peau éclatante.',
      ),
      const ServiceEntity(
        id: '3',
        name: 'Hammam',
        durationMinutes: 30,
        price: 280,
        description: 'Hammam traditionnel pour une purification profonde.',
      ),
      const ServiceEntity(
        id: '4',
        name: 'Manucure',
        durationMinutes: 45,
        price: 40,
        description: 'Soin des mains et pose de vernis.',
      ),
    ]);
  }
}

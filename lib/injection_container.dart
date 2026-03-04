import 'package:get_it/get_it.dart';
import 'features/services/domain/repositories/services_repository.dart';
import 'features/services/data/repositories/mock_services_repository.dart';
import 'features/services/domain/usecases/get_services.dart';
import 'features/services/presentation/bloc/services_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(() => ServicesBloc(getServices: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetServices(sl()));

  // Repository
  sl.registerLazySingleton<ServicesRepository>(() => MockServicesRepository());
}

import 'package:get_it/get_it.dart';
import 'features/services/domain/repositories/services_repository.dart';
import 'features/services/data/repositories/mock_services_repository.dart';
import 'features/services/domain/usecases/get_services.dart';
import 'features/services/presentation/bloc/services_bloc.dart';
import 'config/theme/theme_storage.dart';
import 'config/theme/theme_mode_controller.dart';

final sl = GetIt.instance;

void init() {
  // Theme
  sl.registerLazySingleton(() => ThemeStorage());
  sl.registerLazySingleton(() => ThemeModeController(sl()));

  // Bloc
  sl.registerFactory(() => ServicesBloc(getServices: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetServices(sl()));

  // Repository
  sl.registerLazySingleton<ServicesRepository>(() => MockServicesRepository());
}

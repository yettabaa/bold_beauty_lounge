import os

files = {
    'lib/features/services/presentation/bloc/services_event.dart': '''import 'package:equatable/equatable.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();
  @override
  List<Object> get props => [];
}

class LoadServices extends ServicesEvent {}
''',
    'lib/features/services/presentation/bloc/services_state.dart': '''import 'package:equatable/equatable.dart';
import '../../domain/entities/service.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();
  @override
  List<Object> get props => [];
}

class ServicesInitial extends ServicesState {}
class ServicesLoading extends ServicesState {}
class ServicesLoaded extends ServicesState {
  final List<ServiceEntity> services;
  const ServicesLoaded(this.services);
  @override
  List<Object> get props => [services];
}
class ServicesError extends ServicesState {
  final String message;
  const ServicesError(this.message);
  @override
  List<Object> get props => [message];
}
''',
    'lib/features/services/presentation/bloc/services_bloc.dart': '''import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_services.dart';
import 'services_event.dart';
import 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final GetServices getServices;

  ServicesBloc({required this.getServices}) : super(ServicesInitial()) {
    on<LoadServices>((event, emit) async {
      emit(ServicesLoading());
      final result = await getServices();
      result.fold(
        (failure) => emit(ServicesError(failure.toString())),
        (services) => emit(ServicesLoaded(services)),
      );
    });
  }
}
''',
    'lib/features/services/presentation/pages/home_page.dart': '''import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bold Beauty Lounge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.spa, size: 100, color: Colors.pinkAccent),
            const SizedBox(height: 20),
            const Text(
              'Bienvenue au Bold Beauty Lounge',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => context.push('/services'),
              child: const Text('Voir les services'),
            ),
          ],
        ),
      ),
    );
  }
}
''',
    'lib/features/services/presentation/pages/services_page.dart': '''import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/services_bloc.dart';
import '../bloc/services_event.dart';
import '../bloc/services_state.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nos Services')),
      body: BlocBuilder<ServicesBloc, ServicesState>(
        builder: (context, state) {
          if (state is ServicesLoading || state is ServicesInitial) {
            return const Center(child: CircularProvider());
          } else if (state is ServicesLoaded) {
            return ListView.builder(
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                final service = state.services[index];
                return ListTile(
                  title: Text(service.name),
                  subtitle: Text('${service.durationMinutes} min'),
                  trailing: Text('${service.price} dh'),
                  onTap: () => context.push('/services/detail', extra: service),
                );
              },
            );
          } else if (state is ServicesError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CircularProvider extends StatelessWidget {
  const CircularProvider({super.key});
  @override
  Widget build(BuildContext context) => const CircularProgressIndicator();
}
''',
    'lib/features/services/presentation/pages/service_detail_page.dart': '''import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/service.dart';

class ServiceDetailPage extends StatelessWidget {
  final ServiceEntity service;
  const ServiceDetailPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(service.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('${service.durationMinutes} min | ${service.price} dh', style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 20),
            Text(service.description, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.push('/booking', extra: service),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('Réserver', style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
''',
    'lib/features/booking/presentation/pages/booking_page.dart': '''import 'package:flutter/material.dart';
import '../../../../features/services/domain/entities/service.dart';

class BookingPage extends StatefulWidget {
  final ServiceEntity service;
  const BookingPage({super.key, required this.service});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  String? selectedSlot;
  final List<String> slots = ['9h00', '10h00', '11h00', '14h00', '15h00', '16h00'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Réserver : ${widget.service.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choisissez une date :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (date != null) {
                  setState(() => selectedDate = date);
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(selectedDate == null ? 'Sélectionner une date' : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
            ),
            const SizedBox(height: 20),
            if (selectedDate != null) ...[
              const Text('Choisissez un créneau :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: slots.map((slot) {
                  return ChoiceChip(
                    label: Text(slot),
                    selected: selectedSlot == slot,
                    onSelected: (selected) {
                      setState(() => selectedSlot = selected ? slot : null);
                    },
                  );
                }).toList(),
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (selectedDate != null && selectedSlot != null)
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Réservation confirmée pour le ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} à $selectedSlot')),
                        );
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    : null,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('Confirmer', style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
''',
    'lib/injection_container.dart': '''import 'package:get_it/get_it.dart';
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
''',
    'lib/router.dart': '''import 'package:go_router/go_router.dart';
import 'features/services/presentation/pages/home_page.dart';
import 'features/services/presentation/pages/services_page.dart';
import 'features/services/presentation/pages/service_detail_page.dart';
import 'features/booking/presentation/pages/booking_page.dart';
import 'features/services/domain/entities/service.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/services',
      builder: (context, state) => const ServicesPage(),
      routes: [
        GoRoute(
          path: 'detail',
          builder: (context, state) {
            final service = state.extra as ServiceEntity;
            return ServiceDetailPage(service: service);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/booking',
      builder: (context, state) {
        final service = state.extra as ServiceEntity;
        return BookingPage(service: service);
      },
    ),
  ],
);
''',
    'lib/main.dart': '''import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'router.dart';
import 'features/services/presentation/bloc/services_bloc.dart';
import 'features/services/presentation/bloc/services_event.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ServicesBloc>()..add(LoadServices()),
      child: MaterialApp.router(
        title: 'Bold Beauty Lounge',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          useMaterial3: true,
        ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
'''
}

for filepath, content in files.items():
    os.makedirs(os.path.dirname(filepath), exist_ok=True)
    with open(filepath, 'w') as f:
        f.write(content)

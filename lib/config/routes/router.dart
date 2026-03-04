import 'package:go_router/go_router.dart';
import '../../features/services/presentation/pages/home_page.dart';
import '../../features/services/presentation/pages/services_page.dart';
import '../../features/services/presentation/pages/service_detail_page.dart';
import '../../features/booking/presentation/pages/booking_page.dart';
import '../../features/services/domain/entities/service.dart';

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

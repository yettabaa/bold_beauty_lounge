import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'config/routes/router.dart';
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;
import 'config/routes/router.dart';
import 'features/services/presentation/bloc/services_bloc.dart';
import 'features/services/presentation/bloc/services_event.dart';
import 'config/theme/app_theme.dart';
import 'config/theme/theme_mode_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await di.sl<ThemeModeController>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModeController>.value(
      value: di.sl<ThemeModeController>(),
      child: BlocProvider(
        create: (_) => di.sl<ServicesBloc>()..add(LoadServices()),
        child: Consumer<ThemeModeController>(
          builder: (context, controller, _) {
            return MaterialApp.router(
              title: 'Bold Beauty Lounge',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: controller.themeMode,
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('fr', 'FR'), Locale('en', 'US')],
            );
          },
        ),
      ),
    );
  }
}

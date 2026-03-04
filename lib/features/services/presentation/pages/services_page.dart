import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/services_bloc.dart';
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

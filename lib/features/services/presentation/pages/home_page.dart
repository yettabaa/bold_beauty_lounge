import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Overlay
          Positioned.fill(
            child: Image.asset('assets/images/spa.jpg', fit: BoxFit.cover),
          ),

          SafeArea(
            child: Column(
              children: [
                // Logo at the top
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  child: Image.asset(
                    'assets/logos/logo bold blanc.png',
                    width: 220,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),

                const Spacer(),

                // Button pinned to the bottom
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 0, 48, 48),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () => context.push('/services'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black54,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child:
                           
                          Text(
                            'Voir les services',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

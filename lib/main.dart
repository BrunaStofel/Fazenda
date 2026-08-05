import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants/app_colors.dart';
import 'features/talhoes/presentation/pages/initial_page.dart';
import 'features/talhoes/data/models/talhao_model.dart';
import 'features/talhoes/data/models/hive_adapters.dart';

Future<void> main() async {
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive adapters
  Hive.registerAdapter(TalhaoModelAdapter());
  Hive.registerAdapter(CustoModelAdapter());
  
  // Open Hive box
  await Hive.openBox<TalhaoModel>('talhoes_box');

  runApp(
    const ProviderScope(
      child: FazendaApp(),
    ),
  );
}

class FazendaApp extends StatelessWidget {
  const FazendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fazenda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFFE3DACB),
        scaffoldBackgroundColor: Color(0xFF036746),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE3DACB),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE3DACB),
            foregroundColor: Color(0xFF036746),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Color(0xFFE3DACB),
            side: const BorderSide(color: Color(0xFFE3DACB)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE3DACB), width: 2),
          ),
          prefixIconColor: Color(0xFFE3DACB),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFE3DACB),
          foregroundColor: Colors.white,
        ),
      ),
      home: const InitialPage(),
    );
  }
}

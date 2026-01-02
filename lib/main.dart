import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/tabs_screen.dart';

// 1. Глобальний ключ для доступу до ScaffoldMessenger з будь-якого місця
final messengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 2. ЦЕ НАЙВАЖЛИВІШЕ: прив'язуємо ключ до MaterialApp
      scaffoldMessengerKey: messengerKey, 
      
      title: 'Music App',
      debugShowCheckedModeBanner: false, // Прибираємо банер "Debug" для чистого вигляду
      
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        // 3. Налаштовуємо шрифт Lato для темної теми (вимога ЛР №3)
        textTheme: GoogleFonts.latoTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const TabsScreen(),
    );
  }
}
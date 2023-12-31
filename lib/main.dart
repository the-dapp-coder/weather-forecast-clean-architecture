import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/weather_forcast/presentation/ui/home_page.dart';
import 'injection_container.dart' as injection_ontainer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection_ontainer.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 224, 233, 250),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.blue,
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              TextStyle(
                fontFamily: 'roboto',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            backgroundColor: MaterialStatePropertyAll(Colors.blue),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

import 'package:budget_app/firebase_options.dart';
import 'package:budget_app/responsive_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Esta linea de codigo es para que las rutas de la aplicacion sean mas limpias
  setPathUrlStrategy();

  // Inicializamos Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Esta linea de codigo es para que no se descarguen las fuentes de google fonts en tiempo de ejecucion
  // sino que se descarguen en tiempo de compilacion
  // GoogleFonts.config.allowRuntimeFetching = false;

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ResponsiveHandler(),
    );
  }
}

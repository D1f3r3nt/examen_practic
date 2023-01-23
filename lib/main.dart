import 'package:examen_practic/preferences/db_preferences.dart';
import 'package:examen_practic/provider/despesa_list_provider.dart';
import 'package:examen_practic/screens/add.dart';
import 'package:examen_practic/screens/home_screen.dart';
import 'package:examen_practic/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'preferences/preferences.dart';

void main() async {
  /// Inicializacion general
  WidgetsFlutterBinding.ensureInitialized();

  /// Inicializacion de las preferencias
  await Preferences.init();
  await DBPreferences.db.initDb();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DespesaListProvider(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Practic',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        'new': (context) => Add(),
      },
    );
  }
}

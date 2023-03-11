import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:things/viewmodels/auth_view_model.dart';
import 'package:things/viewmodels/local_storage_view_model.dart';
import 'package:things/viewmodels/things_view_model.dart';
import 'package:things/views/auth_view.dart';
import 'package:things/views/things_view.dart';
import 'package:things/views/welcome_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider<ThingViewModel>(
          create: (context) => ThingViewModel(),
        ),
        ChangeNotifierProvider<LocalStorageViewModel>(
          create: (context) => LocalStorageViewModel(),
        )
      ],
      child: const Things(),
    ),
  );
}

class Things extends StatelessWidget {
  const Things({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Things',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<LocalStorageViewModel>(
        builder: (context, localStorage, _) => FutureBuilder<bool?>(
            future: localStorage.getUserAuthenticationStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const WelcomeView();
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const AuthView();
              }
              return const ThingsView();
            }),
      ),
    );
  }
}

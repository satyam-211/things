import 'package:flutter/material.dart';
import 'package:things/core/routes_constants.dart';
import 'package:things/models/thing.dart';
import 'package:things/views/addThing/add_thing_view.dart';
import 'package:things/views/auth/auth_view.dart';
import 'package:things/views/things/things_view.dart';
import 'package:things/views/welcome_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case kWelcome:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const WelcomeView(),
      );
    case kAuth:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const AuthView(),
      );
    case kThings:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ThingsView(),
      );
    case kAddThing:
      final maybeThing = settings.arguments as Thing?;
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => AddThingView(
          thing: maybeThing,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const WelcomeView(),
      );
  }
}

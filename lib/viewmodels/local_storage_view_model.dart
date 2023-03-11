import 'package:flutter/material.dart';

import 'package:things/services/local_storage_service.dart';

class LocalStorageViewModel extends ChangeNotifier {
  final LocalStorageService _localStorageServices = LocalStorageService();

  Future<bool?> getUserAuthenticationStatus() async {
    return await LocalStorageService.isAuthenticatedUser();
  }

  void authenticateUser() {
    _localStorageServices.authenticateUser();
    notifyListeners();
  }
}

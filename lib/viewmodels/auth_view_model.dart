import 'package:flutter/foundation.dart';
import 'package:things/core/response_status.dart';
import 'package:things/services/firebase_auth_service.dart';
import 'package:things/services/local_storage_service.dart';

class AuthViewModel with ChangeNotifier {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final LocalStorageService _localAuthStatusService = LocalStorageService();
  ResponseStatus responseStatus = ResponseStatus.none();

  Future<bool> signIn(String userEmail, String userPassword) async {
    responseStatus = ResponseStatus.loading();
    notifyListeners();
    responseStatus = await _firebaseAuthService.signInUserWithEmailAndPassword(
      userEmail,
      userPassword,
    );
    if (responseStatus.status == Status.completed) {
      _localAuthStatusService.authenticateUser();
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<bool> signUp(String userEmail, String userPassword) async {
    responseStatus = ResponseStatus.loading();
    notifyListeners();
    responseStatus = await _firebaseAuthService.createUserWithEmailAndPassword(
      userEmail,
      userPassword,
    );
    if (responseStatus.status == Status.completed) {
      _localAuthStatusService.authenticateUser();
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<bool> signOut() async {
    responseStatus = ResponseStatus.loading();
    notifyListeners();
    responseStatus = await _firebaseAuthService.logOut();
    if (responseStatus.status == Status.completed) {
      _localAuthStatusService.unAuthenticateUser();
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }
}

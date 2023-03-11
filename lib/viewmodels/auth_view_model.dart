import 'package:flutter/foundation.dart';
import 'package:things/services/firebase_auth_service.dart';
import 'package:things/services/local_storage_service.dart';

class AuthViewModel with ChangeNotifier {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final LocalStorageService _localAuthStatusService = LocalStorageService();

  void signIn(String userEmail, String userPassword) async {
    await _firebaseAuthService.signInUserWithEmailAndPassword(
      userEmail,
      userPassword,
    );
    _localAuthStatusService.authenticateUser();
    notifyListeners();
  }

  void signUp(String userEmail, String userPassword) async {
    await _firebaseAuthService.createUserWithEmailAndPassword(
      userEmail,
      userPassword,
    );
    _localAuthStatusService.authenticateUser();
    notifyListeners();
  }

  void signOut() async {
    await _firebaseAuthService.logOut();
    _localAuthStatusService.unAuthenticateUser();
  }

  void addUserName(String newUserName) async {
    await _firebaseAuthService.addUserName(newUserName);
    notifyListeners();
  }

  String getUserName() {
    return _firebaseAuthService.username();
  }
}

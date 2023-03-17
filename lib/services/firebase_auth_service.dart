import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:things/core/response_status.dart';

import 'package:things/constants/constants.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<ResponseStatus> createUserWithEmailAndPassword(
    String userEmail,
    String userPassword,
  ) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      return ResponseStatus.completed();
    } on FirebaseAuthException catch (exception) {
      debugPrint(exception.message);
      return ResponseStatus.error(exception.message ?? Constants.kError);
    } catch (e) {
      return ResponseStatus.error(e.toString());
    }
  }

  Future<ResponseStatus> signInUserWithEmailAndPassword(
    String userEmail,
    String userPassword,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: userEmail.trim(),
        password: userPassword,
      );
      return ResponseStatus.completed();
    } on FirebaseAuthException catch (exception) {
      debugPrint(exception.message);
      return ResponseStatus.error(exception.message ?? Constants.kError);
    } catch (e) {
      return ResponseStatus.error(e.toString());
    }
  }

  Future<ResponseStatus> logOut() async {
    try {
      await _firebaseAuth.signOut();
      return ResponseStatus.completed();
    } catch (e) {
      debugPrint(e.toString());
      return ResponseStatus.error(e.toString());
    }
  }

  Future<ResponseStatus> googleSignIn() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      if (googleSignInAuthentication == null) {
        return ResponseStatus.error();
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return ResponseStatus.completed();
    } on FirebaseAuthException catch (exception) {
      debugPrint(exception.message);
      return ResponseStatus.error(exception.message ?? Constants.kError);
    } catch (e) {
      return ResponseStatus.error(e.toString());
    }
  }
}

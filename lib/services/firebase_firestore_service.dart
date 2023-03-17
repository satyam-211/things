import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:things/constants/constants.dart';
import 'package:things/core/response_status.dart';
import 'package:things/models/thing.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? firebaseUser;

  Future<ResponseStatus> addThing(Thing newThing,
      [bool isCompleted = false]) async {
    try {
      firebaseUser = FirebaseAuth.instance.currentUser;
      await _firestore
          .collection(Constants.kUsers)
          .doc(firebaseUser!.uid)
          .collection(
            isCompleted
                ? Constants.kCompletedThings
                : Constants.kIncompleteThings,
          )
          .doc(newThing.id)
          .set(newThing.toMap());
      return ResponseStatus.completed();
    } on FirebaseException catch (exception) {
      return ResponseStatus.error(exception.message ?? Constants.kError);
    } catch (e) {
      return ResponseStatus.error();
    }
  }

  Future<ResponseStatus<QuerySnapshot<Map<String, dynamic>>>> getThings(
      [bool completed = false]) async {
    try {
      firebaseUser = FirebaseAuth.instance.currentUser;
      final data = await _firestore
          .collection(Constants.kUsers)
          .doc(firebaseUser!.uid)
          .collection(
            completed
                ? Constants.kCompletedThings
                : Constants.kIncompleteThings,
          )
          .get();
      return ResponseStatus.completed(data);
    } on FirebaseException catch (exception) {
      return ResponseStatus.error(exception.message ?? Constants.kError);
    } catch (e) {
      return ResponseStatus.error();
    }
  }

  Future<ResponseStatus> deleteThing(String thingID) async {
    try {
      firebaseUser = FirebaseAuth.instance.currentUser;
      await _firestore
          .collection(Constants.kUsers)
          .doc(firebaseUser!.uid)
          .collection(Constants.kIncompleteThings)
          .doc(thingID)
          .delete();
      return ResponseStatus.completed();
    } on FirebaseException catch (exception) {
      return ResponseStatus.error(exception.message ?? Constants.kError);
    } catch (e) {
      return ResponseStatus.error();
    }
  }

  Future<ResponseStatus> updateThingIsDone(
    Thing thing,
  ) async {
    try {
      addThing(thing, true);
      deleteThing(thing.id!);
      return ResponseStatus.completed();
    } on FirebaseException catch (exception) {
      return ResponseStatus.error(
        exception.message ?? Constants.kError,
      );
    } catch (e) {
      return ResponseStatus.error();
    }
  }

  Future<ResponseStatus> updateThing(String thingId, Thing newThing) async {
    try {
      firebaseUser = FirebaseAuth.instance.currentUser;
      await _firestore
          .collection(Constants.kUsers)
          .doc(firebaseUser!.uid)
          .collection(Constants.kIncompleteThings)
          .doc(thingId)
          .update(newThing.toMap());
      return ResponseStatus.completed();
    } on FirebaseException catch (exception) {
      return ResponseStatus.error(exception.message ?? Constants.kError);
    } catch (e) {
      return ResponseStatus.error();
    }
  }
}

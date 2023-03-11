import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:things/constants/constants.dart';
import 'package:things/models/thing.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> addThing(Thing newThing) async {
    final thingMap = newThing.toMap();
    thingMap.addAll(Constants.kIsThingDone);
    await _firestore
        .collection(Constants.kUsers)
        .doc(firebaseUser!.uid)
        .collection(Constants.kThings)
        .doc(newThing.id)
        .set(thingMap);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getThings() async {
    return await _firestore
        .collection(Constants.kUsers)
        .doc(firebaseUser!.uid)
        .collection(Constants.kThings)
        .get();
  }

  Future<void> deleteThing(String thingID) async {
    await _firestore
        .collection(Constants.kUsers)
        .doc(firebaseUser!.uid)
        .collection(Constants.kThings)
        .doc(thingID)
        .delete();
  }

  Future<void> updateThingIsDone(String thingID, bool newIsDone) async {
    await _firestore
        .collection(Constants.kUsers)
        .doc(firebaseUser!.uid)
        .collection(Constants.kThings)
        .doc(thingID)
        .update({
      "isDone": newIsDone,
    });
  }

  Future<void> updateThing(String thingId, Thing newThing) async {
    await _firestore
        .collection(Constants.kUsers)
        .doc(firebaseUser!.uid)
        .collection(Constants.kThings)
        .doc(thingId)
        .update(newThing.toMap());
  }
}

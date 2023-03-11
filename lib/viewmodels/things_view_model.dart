import 'package:flutter/foundation.dart';
import 'package:things/models/thing.dart';
import 'package:things/services/firebase_firestore_service.dart';

class ThingViewModel with ChangeNotifier {
  final FirebaseFirestoreService _firebaseFirestoreService =
      FirebaseFirestoreService();

  void addThing(Thing newThing) {
    _firebaseFirestoreService.addThing(newThing);
    notifyListeners();
  }

  Future<List<Thing>> getThings() async {
    final things = <Thing>[];
    final fireStoreThings = await _firebaseFirestoreService.getThings();
    for (final fireStoreThing in fireStoreThings.docs) {
      things.add(Thing.fromJson(fireStoreThing.data()));
    }
    return things;
  }

  void deleteThing(String thingID) {
    _firebaseFirestoreService.deleteThing(thingID);
  }

  void updateThing(String thingId, Thing newThing) {
    _firebaseFirestoreService.updateThing(thingId, newThing);
  }

  void updateIsDone(String thingId, bool isDone) {
    _firebaseFirestoreService.updateThingIsDone(thingId, isDone);
  }
}

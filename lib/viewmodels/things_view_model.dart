import 'package:flutter/foundation.dart';
import 'package:things/core/response_status.dart';
import 'package:things/models/thing.dart';
import 'package:things/services/firebase_firestore_service.dart';

class ThingViewModel with ChangeNotifier {
  final FirebaseFirestoreService _firebaseFirestoreService =
      FirebaseFirestoreService();

  ResponseStatus responseStatus = ResponseStatus.none();

  List<Thing> completedThings = [];

  List<Thing> incompleteThings = [];

  int personalThings = 0;
  int businessThings = 0;

  Future<void> addThing(Thing newThing) async {
    responseStatus = ResponseStatus.loading();
    responseStatus = await _firebaseFirestoreService.addThing(newThing);
    if (responseStatus.status == Status.completed) {
      incompleteThings.add(newThing);
      _updateInCompleteThings(incompleteThings);
      return;
    }
    notifyListeners();
  }

  Future<void> getThings([bool completed = false]) async {
    responseStatus = ResponseStatus.loading();
    final things = <Thing>[];
    responseStatus = await _firebaseFirestoreService.getThings(completed);
    if (responseStatus.status == Status.completed) {
      final fireStoreThings = responseStatus.data;
      for (final fireStoreThing in fireStoreThings.docs) {
        things.add(Thing.fromJson(fireStoreThing.data()));
      }
    }
    if (completed) {
      _updateCompletedThings(things);
    } else {
      _updateInCompleteThings(things);
    }
  }

  void _updateCompletedThings(List<Thing> things) {
    completedThings = things;
    notifyListeners();
  }

  void _updateInCompleteThings(List<Thing> things) {
    incompleteThings = things;
    personalThings = incompleteThings
        .where(
          (thing) => thing.type == ThingType.personal,
        )
        .length;
    businessThings = incompleteThings
        .where(
          (thing) => thing.type == ThingType.business,
        )
        .length;
    notifyListeners();
  }

  Future<void> deleteThing(String thingID) async {
    responseStatus = ResponseStatus.loading();
    responseStatus = await _firebaseFirestoreService.deleteThing(thingID);
    if (responseStatus.status == Status.completed) {
      incompleteThings.removeWhere((thing) => thing.id == thingID);
      _updateInCompleteThings(incompleteThings);
    }
  }

  Future<void> updateThing(String thingId, Thing newThing) async {
    responseStatus = ResponseStatus.loading();
    responseStatus =
        await _firebaseFirestoreService.updateThing(thingId, newThing);
    if (responseStatus.status == Status.completed) {
      incompleteThings.removeWhere((thing) => thing.id == thingId);
      incompleteThings.add(newThing);
      _updateInCompleteThings(incompleteThings);
    }
  }

  Future<void> updateIsDone(Thing completedThing) async {
    responseStatus = ResponseStatus.loading();
    responseStatus =
        await _firebaseFirestoreService.updateThingIsDone(completedThing);
    if (responseStatus.status == Status.completed) {
      incompleteThings.remove(completedThing);
      completedThings.add(completedThing);
      _updateInCompleteThings(incompleteThings);
    }
  }
}

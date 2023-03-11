import 'package:cloud_firestore/cloud_firestore.dart';

class Thing {
  final String? id;
  final ThingType? type;
  final String? description;
  final String? place;
  final DateTime? time;
  final DateTime? notification;

  const Thing({
    this.id,
    this.type,
    this.description,
    this.place,
    this.time,
    this.notification,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Thing &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          description == other.description &&
          place == other.place &&
          time == other.time &&
          notification == other.notification);

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      description.hashCode ^
      place.hashCode ^
      time.hashCode ^
      notification.hashCode;

  @override
  String toString() {
    return 'Thing{ id: $id, type: $type, description: $description, place: $place, time: $time, notification: $notification,}';
  }

  Thing copyWith({
    String? id,
    ThingType? type,
    String? description,
    String? place,
    DateTime? time,
    DateTime? notification,
  }) {
    return Thing(
      id: id ?? this.id,
      type: type ?? this.type,
      description: description ?? this.description,
      place: place ?? this.place,
      time: time ?? this.time,
      notification: notification ?? this.notification,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type?.name,
      'description': description,
      'place': place,
      'time': time != null ? Timestamp.fromDate(time!) : null,
      'notification':
          notification != null ? Timestamp.fromDate(notification!) : null,
    };
  }

  factory Thing.fromJson(Map<String, dynamic> json) {
    return Thing(
      id: json['id'],
      type: (json['type'] as String?)?.toThingType,
      description: json['description'],
      place: json['place'],
      time: (json['time'] as Timestamp?)?.toDate(),
      notification: (json['notification'] as Timestamp?)?.toDate(),
    );
  }
}

enum ThingType { business, personal }

extension StrToThingType on String {
  ThingType? get toThingType {
    switch (this) {
      case 'business':
        return ThingType.business;
      case 'personal':
        return ThingType.personal;
      default:
        return null;
    }
  }
}

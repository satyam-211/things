import 'package:uuid/uuid.dart';

class Utils {
  static String getRandomId() {
    return const Uuid().v4();
  }
}

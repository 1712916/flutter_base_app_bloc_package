import 'package:intl/intl.dart';

extension ParseFromString on String? {

  int? parseInt() {
    if (this == null) {
      return null;
    }

    return int.tryParse(this!);
  }

  double? parseDouble() {
    if (this == null) {
      return null;
    }

    return double.tryParse(this!);
  }

  bool? parseBool() {
    if (this == null) {
      return null;
    }
    if (this == 'true') {
      return true;
    } else if (this == 'false') {
      return false;
    }

    return null;
  }

  DateTime? parseDate() {
    if (this == null) {
      return null;
    }
    try {
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(this!);
    } catch (_) {
      return null;
    }
  }

  DateTime? parseDateTime() {
    if (this == null) {
      return null;
    }
    return DateTime.tryParse(this!);
  }
}
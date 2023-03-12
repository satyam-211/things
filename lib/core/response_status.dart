import 'package:things/constants/constants.dart';

class ResponseStatus<T> {
  final Status status;
  final String? error;
  final T? data;

  const ResponseStatus({
    required this.status,
    this.error,
    this.data,
  });

  factory ResponseStatus.none() {
    return const ResponseStatus(status: Status.none);
  }

  factory ResponseStatus.loading() {
    return const ResponseStatus(status: Status.loading);
  }

  factory ResponseStatus.completed([T? data]) {
    return ResponseStatus(
      status: Status.completed,
      data: data,
    );
  }

  factory ResponseStatus.error([String error = Constants.kError]) {
    return ResponseStatus(
      status: Status.error,
      error: error,
    );
  }
}

enum Status { loading, completed, error, none }

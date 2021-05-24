class TaskFetchException implements Exception {
  final String message;
  final int? statusCode;
  final String? error;
  TaskFetchException(this.message, {this.statusCode, this.error});
  @override
  String toString() {
    String x = message;
    if (error != null) {
      x = '$error, $x';
    }
    if (statusCode != null) {
      x = '$statusCode $x';
    }
    return x;
  }
}

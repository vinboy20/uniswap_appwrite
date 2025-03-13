class TAppwriteException implements Exception {
  final String message;

  TAppwriteException(this.message);

  @override
  String toString() => message;
}
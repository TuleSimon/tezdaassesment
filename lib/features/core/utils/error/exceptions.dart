class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class InputException implements Exception {
  final String message;
  InputException({required this.message});
}

class NetworkException implements Exception {}

class TimeoutException implements Exception {}

class CancelException implements Exception {}

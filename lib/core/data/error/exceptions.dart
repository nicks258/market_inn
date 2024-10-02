import '../network/error_message_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;

  const ServerException({required this.errorMessageModel});
}

class WebSocketException implements Exception {
  final ErrorMessageModel errorMessageModel;

  const WebSocketException({required this.errorMessageModel});
}
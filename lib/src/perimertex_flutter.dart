import 'dart:convert';

import 'package:perimeterx_flutter_plugin/src/pigeon/messages.pigeon.dart';

import 'perimeterx_result.dart';

extension _XString on String {
  PerimeterxResult get toPerimeterxResult {
    switch (this) {
      case 'solved':
        return PerimeterxResult.solved;
      case 'failed':
        return PerimeterxResult.failed;
      case 'cancelled':
        return PerimeterxResult.cancelled;
      default:
        return PerimeterxResult.failed;
    }
  }
}

abstract class IPerimeterXFlutter {
  Future<Map<String, String>> getHeaders();

  Future<PerimeterxResult> handleResponse({
    required Object? response,
    required String url,
  });
}

class PerimeterXFlutter implements IPerimeterXFlutter {
  final PerimeterXHostApi _hostApi;

  PerimeterXFlutter() : _hostApi = PerimeterXHostApi();

  /// *Adding SDK's HTTP headers to your URL requests:*
  /// Called before sending your URL request, take HTTP headers from the SDK and add them to your request.
  /// add those headers to your URL request
  /// **Note: Headers should not be empty. When no headers are returned, it means that something went wrong with the SDK integration.**
  /// **Be careful: Don't cache headers from the headersForURLRequest function!
  /// You should not cache those headers function. Those headers contain a token with expiration date. The SDK manages this token to be up-to-date.***
  @override
  Future<Map<String, String>> getHeaders() async {
    try {
      return await _hostApi.getHeaders();
    } on Exception {
      // if an error occurs, return an empty map
      return <String, String>{};
    }
  }

  /// *Handle block responses from your server:*
  /// After receiving an error in the server's response, pass the information to SDK with the [handleResponse] function.
  /// If the response cannot be handled by the SDK, this function will return [PerimeterxResult.failed].
  /// This function returns [PerimeterxResult.solved] or [PerimeterxResult.cancelled] when the response was handled by the SDK. That means that a challenge will be presented to the user. After the user solved/cancelled the challenge, the handler code will be called with the proper result. You may use this handler to retry your request.
  /// Resuming the request after a challenge:
  /// [PerimeterxResult.solved] - The user solved the challenge. You can retry your request.
  /// [PerimeterxResult.cancelled] - The user cancelled the challenge.
  /// [PerimeterxResult.failed] - The response could not be handled by the SDK. Check your integration or the [response] object.
  @override
  Future<PerimeterxResult> handleResponse({
    required Object? response,
    required String url,
  }) async {
    try {
      if (response == null) {
        return PerimeterxResult.failed;
      }
      String responseString = '';

      if (response is String) {
        responseString = response;
      } else if (response is Map<String, dynamic>) {
        responseString = jsonEncode(response);
      }

      final result = await _hostApi.handleResponse(
        response: responseString,
        url: url,
      );

      return result.toPerimeterxResult;
    } catch (e) {
      return PerimeterxResult.failed;
    }
  }
}

// Fake for testing purposes.
class FakePerimeterXFlutter implements IPerimeterXFlutter {
  @override
  Future<Map<String, String>> getHeaders() => Future.value({});

  @override
  Future<PerimeterxResult> handleResponse({
    required Object? response,
    required String url,
  }) =>
      Future.value(
        PerimeterxResult.failed,
      );
}

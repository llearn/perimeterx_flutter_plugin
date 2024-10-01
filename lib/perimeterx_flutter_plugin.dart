import 'package:perimeterx_flutter_plugin/src/pigeon/messages.pigeon.dart';

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

enum PerimeterxResult {
  solved,
  failed,
  cancelled,
}

class PerimeterxFlutterPlugin {
  final PerimeterxHostApi _hostApi;

  static PerimeterxFlutterPlugin? _instance;

  const PerimeterxFlutterPlugin._(this._hostApi);

  static PerimeterxFlutterPlugin get instance {
    _instance ??= PerimeterxFlutterPlugin._(PerimeterxHostApi());
    return _instance!;
  }

  Future<Map<String, String>> getPerimeterxHeaders() =>
      _hostApi.getPerimeterxHeaders();

  Future<PerimeterxResult> handlePerimeterxResponse({
    required String response,
    String? url,
  }) async {
    final result = await _hostApi.handlePerimeterxResponse(
      response: response,
      url: url,
    );

    return result.toPerimeterxResult;
  }
}

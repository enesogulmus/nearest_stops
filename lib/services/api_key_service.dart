import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKeyService {
  static const _apiKeyKey = 'OPEN_ROUTE_SERVICE_API_KEY';

  // API anahtarını getir
  static String? getApiKey() {
    return dotenv.env[_apiKeyKey];
  }

  // API anahtarının kayıtlı olup olmadığını kontrol et
  static bool hasApiKey() {
    final apiKey = getApiKey();
    return apiKey != null && apiKey.isNotEmpty;
  }
} 
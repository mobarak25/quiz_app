import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.get('API_URL', fallback: 'http://localhost/');

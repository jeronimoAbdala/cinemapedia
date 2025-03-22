import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDbKey = dotenv.env['THM_MOVIE_DB'] ?? 'No hat API';
}
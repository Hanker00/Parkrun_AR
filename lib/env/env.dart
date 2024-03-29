// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'MAPKEY', obfuscate: true)
  static final mapkey = _Env.mapkey;
  @EnviedField(varName: 'MAPBOX_DOWNLOADS_TOKEN', obfuscate: true)
  static final secretToken = _Env.secretToken;
}

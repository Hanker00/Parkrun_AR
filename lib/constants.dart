import 'package:latlong2/latlong.dart';

import 'env/env.dart';

class AppConstants {
  static final String mapBoxAccessToken = Env.mapkey;
  static final String mapBoxDownloadsToken = Env.secretToken;
  static const String mapBoxStyleId = 'cldk8iumu001f01p6yg8vw5tg';
  static final myLocation = LatLng(57.706650769336136, 12.052258936808373);
  // 57.688316871902536, 11.979222935581918
}

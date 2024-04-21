import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/provider/urlProvider.dart';
import 'package:provider/provider.dart';

import '../utility/sensorData.dart';

class PathProvider extends ChangeNotifier {
  List<String> _path = [];
  bool isDone = false;

  PathProvider();

  Future<void> loadData(BuildContext context) async {
    var urlProvider = Provider.of<UrlProvider>(context, listen: false);

    _points = await SensorData.readSensorData("${urlProvider.url}/$room.json");

    notifyListeners();
  }
}

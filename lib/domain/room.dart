import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/util/data.dart';

import 'sensorData.dart';
import 'branch.dart';

class Room {
  Branch branch;
  String name;

  List<SensorData>? data;

  Room(this.branch, this.name);

  Future<List<SensorData>> fetchData(BuildContext context) async {
    return data ??=
        await DataFetcher.getSensorData(context, this, DateTime(2024, 4, 14));
  }
}

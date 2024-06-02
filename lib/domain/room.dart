import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/domain/filterData.dart';
import 'package:flutter_htl_charts/util/data.dart';

import 'sensorData.dart';
import 'branch.dart';

class Room {
  Branch branch;
  String name;

  FilterData? filter;
  List<SensorData>? data;

  Room(this.branch, this.name);

  Future<List<SensorData>> fetchData(
      BuildContext context, FilterData filter) async {
    if (this.filter == filter) {
      return data!;
    }

    return data = await DataFetcher.getSensorData(context, this, filter);
  }
}

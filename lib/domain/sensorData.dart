import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/provider/urlProvider.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'room.dart';

class SensorData {
  DateTime time;
  int co2;
  double humidity;
  double temperature;

  SensorData(this.co2, this.humidity, this.temperature, this.time);
}

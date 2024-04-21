import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/provider/urlProvider.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class SensorData {
  static int idCount = 0;
  static int minCO2Value = 99999;
  static int maxCO2Value = 0;

  late int id;

  String time;
  int co2;
  double humidity;
  double temperature;

  SensorData(this.co2, this.humidity, this.temperature, this.time) {
    id = idCount++;

    if (minCO2Value > co2) {
      minCO2Value = co2;
    }

    if (maxCO2Value < co2) {
      maxCO2Value = co2;
    }
  }

  @override
  String toString() {
    return 'SensorData{time: $time, c02: $co2, humidity: $humidity, temperature: $temperature}';
  }

  static Future<List<SensorData>> isFinishedPath(
      BuildContext context, List<String> path) async {
    var urlProvider = Provider.of<UrlProvider>(context);

    var url = urlProvider.url;

    for (var value in path) {
      url += "/";
      url += value;
    }

    url += ".json";

    var data = await get(Uri.parse(url));
    var rawData = jsonDecode(data.body) as Map<String, dynamic>;

    List<SensorData> elements = [];

    for (var data in rawData.entries) {
      var sensorData = data.value as Map<String, dynamic>;

      elements.add(SensorData(sensorData["co2"], sensorData["humidity"],
          sensorData["temperature"], data.key));
    }

    return elements;
  }

  static Future<List<SensorData>> readSensorData(String path) async {
    idCount = 0;
    minCO2Value = 99999;
    maxCO2Value = 0;

    print(path);

    var data = await get(Uri.parse(path));
    var rawData = jsonDecode(data.body) as Map<String, dynamic>;

    List<SensorData> elements = [];

    for (var data in rawData.entries) {
      var sensorData = data.value as Map<String, dynamic>;

      elements.add(SensorData(sensorData["co2"], sensorData["humidity"],
          sensorData["temperature"], data.key));
    }

    return elements;
  }

  static Future<List<String>> readOnlyAllRooms(String path) async {
    var data = await get(Uri.parse("$path?shallow=true"));
    var rawRooms = jsonDecode(data.body) as Map<String, dynamic>;

    List<String> rooms = [];

    for (var value in rawRooms.keys) {
      rooms.add(value);
    }

    return rooms;
  }
}

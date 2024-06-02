import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/domain/filterData.dart';
import 'package:flutter_htl_charts/domain/sensorData.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../domain/branch.dart';
import '../domain/room.dart';
import '../domain/school.dart';
import '../provider/urlProvider.dart';

class DataFetcher {
  static Future<List<School>> getSchools(BuildContext context) async {
    final url =
        "${Provider.of<UrlProvider>(context, listen: false).url}/sensorData_2.json?shallow=true";

    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      var rawData = jsonDecode(response.body) as Map<String, dynamic>;

      List<School> elements = [];

      for (var data in rawData.entries) {
        elements.add(School(data.key));
      }

      return elements;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Branch>> getBranches(
      BuildContext context, School school) async {
    final url =
        "${Provider.of<UrlProvider>(context, listen: false).url}/sensorData_2/${school.name}.json?shallow=true";

    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      var rawData = jsonDecode(response.body) as Map<String, dynamic>;

      List<Branch> elements = [];

      for (var data in rawData.entries) {
        elements.add(Branch(school, data.key));
      }

      return elements;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Room>> getRooms(
      BuildContext context, Branch branch) async {
    final url =
        "${Provider.of<UrlProvider>(context, listen: false).url}/sensorData_2/${branch.school.name}/${branch.name}.json?shallow=true";

    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      var rawData = jsonDecode(response.body) as Map<String, dynamic>;

      List<Room> elements = [];

      for (var data in rawData.entries) {
        elements.add(Room(branch, data.key));
      }

      return elements;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<SensorData>> getSensorData(
      BuildContext context, Room room, FilterData filter) async {
    final url =
        "${Provider.of<UrlProvider>(context, listen: false).url}/sensorData_2/${room.branch.school.name}/${room.branch.name}/${room.name}/${filter.date.year}/${filter.date.month.toString().padLeft(2, "0")}/${filter.date.day.toString().padLeft(2, "0")}.json";

    var data = await get(Uri.parse(url));
    var rawData = jsonDecode(data.body) as Map<String, dynamic>;

    List<SensorData> elements = [];

    for (var data in rawData.entries) {
      var sensorData = data.value as Map<String, dynamic>;
      var dateSplit = data.key.split(":");

      var time = DateTime(filter.date.year, filter.date.month, filter.date.day,
          int.parse(dateSplit[0]), int.parse(dateSplit[1]));

      elements.add(SensorData(sensorData["co2"], sensorData["humidity"],
          sensorData["temperature"], time));
    }

    return elements;
  }
}

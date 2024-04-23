import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/domain/room.dart';
import 'package:flutter_htl_charts/domain/school.dart';
import 'package:flutter_htl_charts/provider/urlProvider.dart';
import 'package:flutter_htl_charts/util/data.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../domain/sensorData.dart';

class SchoolsProvider extends ChangeNotifier {
  List<School> schools = [];

  SchoolsProvider();

  Future<void> loadData(BuildContext context) async {
    schools = await DataFetcher.getSchools(context);
    notifyListeners();
  }
}

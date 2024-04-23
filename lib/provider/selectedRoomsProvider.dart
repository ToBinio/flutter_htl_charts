import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/domain/room.dart';
import 'package:flutter_htl_charts/provider/urlProvider.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../domain/sensorData.dart';

class SelectedRoomProvider extends ChangeNotifier {
  List<Room> rooms = [];

  SelectedRoomProvider();

  Future<void> addRoom(Room room) async {
    rooms.add(room);
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/domain/room.dart';
import 'package:flutter_htl_charts/domain/school.dart';
import 'package:flutter_htl_charts/util/data.dart';

class Branch {
  School school;
  String name;

  List<Room>? rooms;

  Branch(this.school, this.name);

  Future<List<Room>> fetchRooms(BuildContext context) async {
    return rooms ??= await DataFetcher.getRooms(context, this);
  }
}

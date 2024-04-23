import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_htl_charts/provider/schoolsProvider.dart';
import 'package:flutter_htl_charts/widgets/roomChart.dart';
import 'package:flutter_htl_charts/widgets/roomSelector.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../domain/room.dart';
import '../provider/selectedRoomsProvider.dart';
import '../provider/urlProvider.dart';
import '../domain/sensorData.dart';

/*
Link to DB
'https://fluttertests-9a56e-default-rtdb.europe-west1.firebasedatabase.app/sensorData/htl'
 */

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  List<Room?> selectedRooms = [null, null];

  @override
  void initState() {
    var schoolsProver = Provider.of<SchoolsProvider>(context, listen: false);

    schoolsProver.loadData(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("HTL Sensor Data"),
        ),
        body: ListView(
          children: [
            for (int i = 0; i < selectedRooms.length; i++)
              RoomSelector(callback: (room) {
                selectedRooms[i] = room;
                setState(() {});
              }),
            RoomChart(rooms: selectedRooms)
          ],
        ));
  }
}

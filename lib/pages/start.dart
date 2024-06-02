import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_htl_charts/domain/filterData.dart';
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
  List<Room?> selectedRooms = [null];

  @override
  void initState() {
    var schoolsProver = Provider.of<SchoolsProvider>(context, listen: false);

    schoolsProver.loadData(context);

    String currentFormattedDate = formatDate(DateTime.now());
    formattedDate = currentFormattedDate;
    dateInput.text = currentFormattedDate;

    super.initState();
  }

  String formattedDate = "";
  late DateTime date = DateTime.now();

  TextEditingController dateInput = TextEditingController();

  String formatDate(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
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
              Row(
                children: [
                  RoomSelector(callback: (room) async {
                    selectedRooms[i] = room;
                    await updateData();
                    setState(() {});
                  }),
                  if (i != 0)
                    IconButton(
                        onPressed: () => onRemoveRoom(i),
                        icon: const Icon(Icons.remove))
                ],
              ),
            IconButton(onPressed: onAddRoom, icon: const Icon(Icons.add)),
            RoomChart(
              rooms: selectedRooms,
            ),
            TextField(
                controller: dateInput,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1999),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    formattedDate = formatDate(pickedDate);
                    date = pickedDate;
                    await updateData();
                    setState(() {
                      dateInput.text = formattedDate;
                    });
                  }
                }),
          ],
        ));
  }

  void onAddRoom() {
    selectedRooms.add(null);
    setState(() {});
  }

  void onRemoveRoom(int id) {
    selectedRooms.removeAt(id);
    setState(() {});
  }

  Future<void> updateData() async {
    for (var room in selectedRooms) {
      if (room != null) {
        await room.fetchData(context, FilterData(date));
      }
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../provider/pathProvider.dart';
import '../provider/urlProvider.dart';
import '../utility/sensorData.dart';

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
  TextEditingController dbUrl = TextEditingController();
  List<String> rooms = [];

  @override
  void initState() {
    var urlProver = Provider.of<UrlProvider>(context, listen: false);

    dbUrl.text = urlProver.url;

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
            TextFormField(
              decoration: const InputDecoration(labelText: "db url"),
              controller: dbUrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) {
                var urlProver =
                    Provider.of<UrlProvider>(context, listen: false);
                urlProver.url = value;
              },
            ),
            TextButton(onPressed: onLoadRooms, child: const Text("Load rooms")),
            if (rooms.isNotEmpty) roomSelect(),
            if (rooms.isNotEmpty)
              TextButton(
                  onPressed: () async {
                    var roomProvider =
                        Provider.of<PathProvider>(context, listen: false);

                    await roomProvider.loadData(context);
                    Navigator.pushNamed(context, "/graph");
                  },
                  child: const Text("Show Graph"))
          ],
        ));
  }

  void onLoadRooms() async {
    try {
      rooms = await SensorData.readOnlyAllRooms("${dbUrl.text}.json");
    } catch (e) {
      showErrorDialog();
      return;
    }
    setRoom(rooms.first);

    setState(() {});
  }

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Invalid Url'),
        content: const Text("that was simple not correct..."),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ok ~_~'),
          ),
        ],
      ),
    );
  }

  void setRoom(String room) {
    var roomProvider = Provider.of<PathProvider>(context, listen: false);
    roomProvider.room = room;
  }

  Widget roomSelect() {
    var roomProvider = Provider.of<PathProvider>(context, listen: false);

    return DropdownButton<String>(
      value: roomProvider.room,
      onChanged: (String? value) {
        setState(() {
          roomProvider.room = value!;
          print(roomProvider.room);
        });
      },
      items: rooms.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

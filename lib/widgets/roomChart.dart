import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/domain/sensorData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../domain/room.dart';

class RoomChart extends StatefulWidget {
  List<Room?> rooms;

  bool showTemp;
  bool showHum;
  bool showCo2;

  RoomChart(
      {super.key,
      required this.rooms,
      required this.showCo2,
      required this.showHum,
      required this.showTemp});

  @override
  State<RoomChart> createState() => _RoomChartState();
}

class _RoomChartState extends State<RoomChart> {
  @override
  Widget build(BuildContext context) {
    var rooms = widget.rooms.where((element) => element != null);

    List<CartesianSeries> data = [];

    for (var room in rooms) {
      data.add(LineSeries<SensorData, DateTime>(
          dataSource: room!.data,
          yAxisName: "YAxisHum",
          name: 'Series ${room.name} hum',
          xValueMapper: (SensorData sales, _) => sales.time,
          yValueMapper: (SensorData sales, _) => sales.humidity));
    }

    for (var room in rooms) {
      data.add(LineSeries<SensorData, DateTime>(
          dataSource: room!.data,
          yAxisName: "YAxisTemp",
          name: 'Series ${room.name} temp',
          xValueMapper: (SensorData sales, _) => sales.time,
          yValueMapper: (SensorData sales, _) => sales.temperature));
    }

    for (var room in rooms) {
      data.add(LineSeries<SensorData, DateTime>(
          dataSource: room!.data,
          yAxisName: "YAxisCO2",
          name: 'Series ${room.name} co2',
          xValueMapper: (SensorData sales, _) => sales.time,
          yValueMapper: (SensorData sales, _) => sales.co2));
    }

    //todo hiding no working....
    return SfCartesianChart(
        primaryXAxis: const DateTimeAxis(),
        axes: <ChartAxis>[
          NumericAxis(
            name: 'YAxisTemp',
            title: const AxisTitle(text: 'Temperature'),
            opposedPosition: true,
            isVisible: widget.showTemp,
          ),
          NumericAxis(
            name: 'YAxisCO2',
            title: const AxisTitle(text: 'CO2'),
            isVisible: widget.showCo2,
          ),
          NumericAxis(
            name: 'YAxisHum',
            title: const AxisTitle(text: 'Humidity'),
            opposedPosition: true,
            isVisible: widget.showHum,
          ),
        ],
        series: data);
  }
}

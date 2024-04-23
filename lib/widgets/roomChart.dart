import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/domain/sensorData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../domain/room.dart';

class RoomChart extends StatefulWidget {
  List<Room?> rooms;

  RoomChart({super.key, required this.rooms});

  @override
  State<RoomChart> createState() => _RoomChartState();
}

class _RoomChartState extends State<RoomChart> {
  @override
  Widget build(BuildContext context) {
    var rooms = widget.rooms.where((element) => element != null);

    return SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        axes: const <ChartAxis>[
          NumericAxis(
            name: 'YAxisTemp',
            title: AxisTitle(text: 'Temperature'),
            opposedPosition: true,
          ),
          NumericAxis(
            name: 'YAxisCO2',
            title: AxisTitle(text: 'CO2'),
          ),
          NumericAxis(
            name: 'YAxisHum',
            title: AxisTitle(text: 'Humidity'),
            opposedPosition: true,
          ),
        ],
        series: <CartesianSeries>[
          for (var room in rooms)
            LineSeries<SensorData, DateTime>(
                dataSource: room!.data,
                yAxisName: "YAxisCO2",
                name: 'Series ${room.name}',
                xValueMapper: (SensorData sales, _) => sales.time,
                yValueMapper: (SensorData sales, _) => sales.co2),
          for (var room in rooms)
            LineSeries<SensorData, DateTime>(
                dataSource: room!.data,
                yAxisName: "YAxisHum",
                name: 'Series ${room.name}',
                xValueMapper: (SensorData sales, _) => sales.time,
                yValueMapper: (SensorData sales, _) => sales.humidity),
          for (var room in rooms)
            LineSeries<SensorData, DateTime>(
                dataSource: room!.data,
                yAxisName: "YAxisTemp",
                name: 'Series ${room.name}',
                xValueMapper: (SensorData sales, _) => sales.time,
                yValueMapper: (SensorData sales, _) => sales.temperature)
        ]);
  }
}

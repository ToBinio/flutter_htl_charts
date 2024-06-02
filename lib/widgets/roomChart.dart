import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/domain/sensorData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../domain/room.dart';

class RoomChart extends StatefulWidget {
  List<Room?> rooms;

  RoomChart({
    super.key,
    required this.rooms,
  });

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
          name:
              '${room.branch.school.name} ${room.branch.name} ${room.name} - hum',
          xValueMapper: (SensorData sales, _) => sales.time,
          yValueMapper: (SensorData sales, _) => sales.humidity));
    }

    for (var room in rooms) {
      data.add(LineSeries<SensorData, DateTime>(
          dataSource: room!.data,
          yAxisName: "YAxisTemp",
          name:
              '${room.branch.school.name} ${room.branch.name} ${room.name} - temp',
          xValueMapper: (SensorData sales, _) => sales.time,
          yValueMapper: (SensorData sales, _) => sales.temperature));
    }

    for (var room in rooms) {
      data.add(LineSeries<SensorData, DateTime>(
          dataSource: room!.data,
          yAxisName: "YAxisCO2",
          name:
              '${room.branch.school.name} ${room.branch.name} ${room.name} - co2',
          xValueMapper: (SensorData sales, _) => sales.time,
          yValueMapper: (SensorData sales, _) => sales.co2));
    }

    //todo hiding no working....
    return SfCartesianChart(
        primaryXAxis: const DateTimeAxis(),
        legend: const Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
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
        series: data);
  }
}

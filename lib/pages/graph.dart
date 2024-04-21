import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/pathProvider.dart';
import '../utility/sensorData.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  void initState() {
    super.initState();
  }

  List<SensorData> sensorData = [];

  @override
  Widget build(BuildContext context) {
    var roomProvider = Provider.of<PathProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('CO2 Sensor Data Room ${roomProvider.room}'),
      ),
      body: chart(roomProvider.points),
    );
  }

  Widget chart(List<SensorData> data) {
    return LineChart(
      LineChartData(
          minY: SensorData.minCO2Value - 100,
          maxY: SensorData.maxCO2Value + 100,
          lineBarsData: [
            LineChartBarData(
                spots: data
                    .map((point) =>
                        FlSpot(point.id as double, point.co2 as double))
                    .toList(),
                isCurved: true,
                dotData: FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.2),
                      Colors.green.withOpacity(0.2),
                    ],
                  ),
                )),
          ]),
    );
  }
}

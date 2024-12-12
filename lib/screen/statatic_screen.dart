import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas del Tendedero'),
        backgroundColor: Color(0xFF13596B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Uso Diario del Tendedero', Icons.calendar_today),
              SizedBox(height: 10),
              _buildChartContainer(
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Uso (horas)'),
                    interval: 1,
                  ),
                  title: ChartTitle(text: 'Uso Diario'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<dynamic, dynamic>>[
                    ColumnSeries<UsageData, String>(
                      dataSource: getDailyUsageData(),
                      xValueMapper: (UsageData data, _) => data.day,
                      yValueMapper: (UsageData data, _) => data.usage,
                      name: 'Uso Diario',
                      color: Color(0xFF13596B),
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Uso Semanal del Tendedero', Icons.calendar_view_week),
              SizedBox(height: 10),
              _buildChartContainer(
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Uso (horas)'),
                    interval: 1,
                  ),
                  title: ChartTitle(text: 'Uso Semanal'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<dynamic, dynamic>>[
                    ColumnSeries<UsageData, String>(
                      dataSource: getWeeklyUsageData(),
                      xValueMapper: (UsageData data, _) => data.day,
                      yValueMapper: (UsageData data, _) => data.usage,
                      name: 'Uso Semanal',
                      color: Color(0xFF007BFF),
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Días Lluviosos de la Semana', Icons.cloud),
              SizedBox(height: 10),
              _buildChartContainer(
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Días'),
                    interval: 1,
                  ),
                  title: ChartTitle(text: 'Días Lluviosos'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<dynamic, dynamic>>[
                    ColumnSeries<RainyDaysData, String>(
                      dataSource: getRainyDaysData(),
                      xValueMapper: (RainyDaysData data, _) => data.day,
                      yValueMapper: (RainyDaysData data, _) => data.rainyDays,
                      name: 'Días Lluviosos',
                      color: Color(0xFFFF5722),
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF13596B)),
        SizedBox(width: 8),
        Text(
          title,
          style : TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF13596B)),
        ),
      ],
    );
  }

  Widget _buildChartContainer(Widget chart) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: chart,
      ),
    );
  }

  List<UsageData> getDailyUsageData() {
    return [
      UsageData('Lunes', 5),
      UsageData('Martes', 3),
      UsageData('Miércoles', 4),
      UsageData('Jueves', 2),
      UsageData('Viernes', 6),
      UsageData('Sábado', 7),
      UsageData('Domingo', 1),
    ];
  }

  List<UsageData> getWeeklyUsageData() {
    return [
      UsageData('Semana 1', 20),
      UsageData('Semana 2', 15),
      UsageData('Semana 3', 25),
      UsageData('Semana 4', 30),
    ];
  }

  List<RainyDaysData> getRainyDaysData() {
    return [
      RainyDaysData('Lunes', 1),
      RainyDaysData('Martes', 0),
      RainyDaysData('Miércoles', 2),
      RainyDaysData('Jueves', 0),
      RainyDaysData('Viernes', 1),
      RainyDaysData('Sábado', 3),
      RainyDaysData('Domingo', 0),
    ];
  }
}

class UsageData {
  final String day;
  final int usage;

  UsageData(this.day, this.usage);
}

class RainyDaysData {
  final String day;
  final int rainyDays;

  RainyDaysData(this.day, this.rainyDays);
}
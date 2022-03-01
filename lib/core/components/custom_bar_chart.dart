import 'package:eng_questions/core/component_models/chart_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class CustomBarChart extends StatelessWidget {
  final List<ChartModel> data;

  const CustomBarChart({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChartModel, String>> series = [
      charts.Series(
        id: "values",
        data: data,
        domainFn: (ChartModel model, _) => model.caption,
        measureFn: (ChartModel model, _) => model.value,
      )
    ];

    return Center(
      child: charts.BarChart(
        series,
        animate: false,
      ),
    );
  }
}

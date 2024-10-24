import 'package:flutter/material.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/pages/blank_page.dart';
import 'package:frontend/widgets/bar_chart_widget.dart';
import 'package:frontend/widgets/line_chart_widget.dart';
import 'package:frontend/widgets/pie_chart_preview_widget.dart';
import 'package:frontend/widgets/table_preview_widget.dart';

import 'dashboard_card_data.dart';

class ReportCardFixedData {
  List<(double, EventCategory)> categoryRatingTable;
  String ratingSubtitle;
  String timeAllocationMainValue;
  String timeAllocationSubTitle;
  String bestPlaceMainValue;
  String bestPlaceSubTitle;
  String averageInterestMainValue;
  String averageInterestSubTitle;

  ReportCardFixedData({
    required this.categoryRatingTable,
    required this.ratingSubtitle,
    required this.timeAllocationMainValue,
    required this.timeAllocationSubTitle,
    required this.bestPlaceMainValue,
    required this.bestPlaceSubTitle,
    required this.averageInterestMainValue,
    required this.averageInterestSubTitle,
  });

  List<DashboardCardData> convertToCardData() {
    var sortedTable = categoryRatingTable..sort((a, b) => b.$1.compareTo(a.$1));

    return [
      DashboardCardData(
        title: "Best performing events",
        mainValue:
            "${sortedTable.first.$2 == EventCategory.artificialIntelligence ? "AI" : sortedTable.first.$2.name}: ${sortedTable.first.$1}",
        subtitle: ratingSubtitle,
        graphFactory: () => SizedBox(
            width: 100,
            height: 80,
            child: TablePreview(data: TablePreviewData.fromVariant(1))),
        pageFactory: () => const BlankPage(),
      ),
      DashboardCardData(
          title: "Time allocation analysis",
          mainValue: timeAllocationMainValue,
          subtitle: timeAllocationSubTitle,
          graphFactory: () => const SimpleBarChart(
              color: Colors.green, pattern: BarChartPattern.normal),
          pageFactory: () => const BlankPage()),
      DashboardCardData(
        title: "Place usage analysis",
        mainValue: bestPlaceMainValue,
        subtitle: bestPlaceSubTitle,
        graphFactory: () =>
            PieChartPreviewWidget(data: PieChartPreviewData.fromVariant(2)),
        pageFactory: () => const BlankPage(),
      ),
      DashboardCardData(
          title: "Average interest",
          mainValue: averageInterestMainValue,
          subtitle: averageInterestSubTitle,
          graphFactory: () => const LineChartWidget(
              color: Colors.green,
              pattern: LineChartPattern.volatile,
              width: 100,
              height: 80),
          pageFactory: () => const BlankPage())
    ];
  }
}

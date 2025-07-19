
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:web_dashboard/DASHBOARD/model/dash_board_model.dart';

class DashBoardRepository {
  Future<List<Map<String, dynamic>>> loadCsvData() async {
    try {
      final rawCsv = await rootBundle.loadString('assets/dummy_dashboard_data_10days.csv');
      final normalizedCsv = rawCsv.replaceAll('\r\n', '\n');

      final csvTable = const CsvToListConverter(eol: '\n').convert(normalizedCsv);

      if (csvTable.length < 2) {
        print("CSV does not have enough rows.");
        return [];
      }

      final headers = csvTable[0].map((e) => e.toString().trim()).toList();
      final rows = csvTable.sublist(1);
      final data = rows.map((row) {
        return {
          for (int i = 0; i < headers.length; i++)
            headers[i]: row[i],
        };
      }).toList();


      return data;
    } catch (e) {
      print("Load Error: $e");
      return [];
    }
  }


  // Future<List<DashBoardModel>> fetchData() async {
  //   final data = await loadCsvData();
  //   return data.map((e) => DashBoardModel.fromJson(e)).toList();
  // }

  Future<List<DashBoardModel>> fetchData({
    String? site,
    String? individual,
    String? date,
  }) async {
    final data = await loadCsvData();

    final filtered = data.where((item) {
      final matchSite = site == null || item['Site']?.toString() == site || site == "";
      final matchIndividual = individual == null || item['Individual']?.toString() == individual || individual == "";
      final matchDate = date == null || item['Date']?.toString() == date || date == "";
      return matchSite && matchIndividual && matchDate;
    }).toList();

    return filtered.map((e) => DashBoardModel.fromJson(e)).toList();
  }

}

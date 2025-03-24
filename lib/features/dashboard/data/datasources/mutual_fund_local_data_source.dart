import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:khazana_fintech_task/features/dashboard/data/model/mutual_fund_model.dart';

abstract class MutualFundLocalDataSource {
  Future<List<MutualFundModel>> fetchMutualFunds();
}

class MutualFundLocalDataSourceImpl implements MutualFundLocalDataSource {
  @override
  Future<List<MutualFundModel>> fetchMutualFunds() async {
    try {
      // Load JSON file from assets
      final String response =
          await rootBundle.loadString('assets/mutual_fund.json');
      // Decode JSON
      final jsonData = json.decode(response);
      final List<dynamic> data = jsonData['all_funds'];
      // Convert List<dynamic> to List<MutualFundModel>
      return data.map((json) => MutualFundModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to load data: $e");
    }
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:trade/core/constants/app_constants.dart';

class ApiService {


  Future<List<Map<String, dynamic>>> fetchWatchlist(
      String name) async {

    print('API watchlist $name');
    await Future.delayed(const Duration(milliseconds: 500));

    return AppConstants.watchlists[name] ?? [];
  }

  Future<void> saveWatchlist(
      String name, List<Map<String, dynamic>> data) async {
    await Future.delayed(const Duration(milliseconds: 300));

    AppConstants.watchlists[name] = data;
  }
}
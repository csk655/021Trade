import '../../../../core/network/api_service.dart';
import '../models/stock_model.dart';

class WatchlistLocalDataSource {
  final ApiService api;

  WatchlistLocalDataSource(this.api);

  Future<List<StockModel>> getWatchlist(String name) async {
    final response = await api.fetchWatchlist(name);

    return response.map((e) => StockModel.fromJson(e)).toList();
  }

  Future<void> saveWatchlist(
      String name, List<StockModel> items) async {
    final json = items.map((e) => e.toJson()).toList();

    await api.saveWatchlist(name, json);
  }
}
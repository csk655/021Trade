import '../entities/stock.dart';

abstract class WatchlistRepository {
  Future<List<Stock>> getWatchlist(String watchlistName);
  Future<void> saveWatchlist(String name, List<Stock> items);
}
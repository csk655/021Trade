import '../entities/stock.dart';
import '../repositories/watchlist_repository.dart';

class SaveWatchlist {
  final WatchlistRepository repository;

  SaveWatchlist(this.repository);

  Future<void> call(String name, List<Stock> items) async {
    await repository.saveWatchlist(name, items);
  }
}
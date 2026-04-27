import '../entities/stock.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlist {
  final WatchlistRepository repository;

  GetWatchlist(this.repository);

  Future<List<Stock>> call(String watchlistName) async {
    return await repository.getWatchlist(watchlistName);
  }
}
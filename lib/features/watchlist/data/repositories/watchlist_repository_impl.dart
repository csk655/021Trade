import '../../domain/entities/stock.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../datasource/watchlist_local_data_source.dart';

import '../models/stock_model.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource localDataSource;

  WatchlistRepositoryImpl(this.localDataSource);

  @override
  Future<List<Stock>> getWatchlist(String watchlistName) async {
    try {
      final List<StockModel> models = await localDataSource.getWatchlist(
        watchlistName,
      );

      return models.map((model) {
        return Stock(
          stockId: model.stockId,
          name: model.name,
          type: model.type,
          price: model.price,
          change: model.change,
          percent: model.percent,
        );
      }).toList();
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  @override
  Future<void> saveWatchlist(String name, List<Stock> items) async {
    final stockModels = items
        .map(
          (model) => StockModel(
            stockId: model.stockId,
            name: model.name,
            type: model.type,
            price: model.price,
            change: model.change,
            percent: model.percent,
          ),
        )
        .toList();

    await localDataSource.saveWatchlist(name, stockModels);
  }
}

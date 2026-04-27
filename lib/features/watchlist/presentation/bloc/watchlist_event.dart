abstract class WatchlistEvent {}

class LoadWatchlist extends WatchlistEvent {
  final String name;

  LoadWatchlist(this.name);
}

class SearchWatchlist extends WatchlistEvent {
  final String query;
  SearchWatchlist(this.query);
}
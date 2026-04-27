import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/stock.dart';
import '../../domain/usecases/get_watchlist.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';
import 'dart:async';


class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlist getWatchlist;

  List<Stock> _allStocks = [];


  WatchlistBloc(this.getWatchlist) : super(WatchlistInitial()) {
    on<LoadWatchlist>(_onLoad);
    on<SearchWatchlist>(_onSearch);
  }

  Future<void> _onLoad(
      LoadWatchlist event,
      Emitter<WatchlistState> emit,
      ) async {
    emit(WatchlistLoading());

    try {
      final data = await getWatchlist(event.name);
      _allStocks = data;

      emit(WatchlistLoaded(data));
    } catch (e) {
      print("ERROR: $e");
      emit(WatchlistError());
    }
  }
  void _onSearch(SearchWatchlist event,Emitter<WatchlistState> emit,) {
    final query = event.query.toLowerCase();

    final filtered = _allStocks.where((stock) {
      return stock.name.toLowerCase().contains(query);
    }).toList();

    emit(WatchlistLoaded(filtered));
  }

}
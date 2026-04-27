import '../../domain/entities/stock.dart';

class EditWatchlistState {
  final List<Stock> items;
  final bool isSaving;
  final bool isLoading;

  EditWatchlistState({
    required this.items,
    this.isSaving = false,
    this.isLoading = false,
  });

  EditWatchlistState copyWith({
    List<Stock>? items,
    bool? isSaving,
    bool? isLoading,
  }) {
    return EditWatchlistState(
      items: items ?? this.items,
      isSaving: isSaving ?? this.isSaving,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/*
class EditWatchlistState {
  final List<Stock> items;
  final bool isSaving;


  EditWatchlistState({
    required this.items,
    this.isSaving = false,
  });

  EditWatchlistState copyWith({
    List<Stock>? items,
    bool? isSaving,
  }) {
    return EditWatchlistState(
      items: items ?? this.items,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}*/

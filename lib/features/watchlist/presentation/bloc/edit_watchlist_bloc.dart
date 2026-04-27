

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';
import 'edit_watchlist_event.dart';
import 'edit_watchlist_state.dart';

class EditWatchlistBloc
    extends Bloc<EditWatchlistEvent, EditWatchlistState> {
  final GetWatchlist getWatchlist;
  final SaveWatchlist saveWatchlist;

  String currentName = "";

  EditWatchlistBloc(this.getWatchlist, this.saveWatchlist)
      : super(EditWatchlistState(items: [])) {
    print("BLOC CREATED");
    on<LoadEditWatchlist>(_onLoad);
    on<ReorderItems>(_onReorder);
    on<DeleteItem>(_onDelete);
    on<SaveItems>(_onSave);
  }


  Future<void> _onLoad(
      LoadEditWatchlist event, Emitter emit) async {

    emit(state.copyWith(isLoading: true));
    currentName = event.name;

    final data = await getWatchlist(event.name);
    print("data fetched");
    if (emit.isDone) return;

    emit(state.copyWith(
      items: data,
      isLoading: false,
    ));
  }

  void _onReorder(
      ReorderItems event, Emitter emit) {
    final list = [...state.items];

    int newIndex = event.newIndex;
    if (newIndex > event.oldIndex) newIndex--;

    final item = list.removeAt(event.oldIndex);
    list.insert(newIndex, item);

    emit(state.copyWith(items: list));
  }

  void _onDelete(DeleteItem event, Emitter emit) {
    final list = [...state.items]..removeAt(event.index);
    emit(state.copyWith(items: list));
  }

  Future<void> _onSave(
      SaveItems event, Emitter emit) async {

    if (state.isSaving) return;

    emit(state.copyWith(isSaving: true));

    await saveWatchlist(currentName, state.items);

    if (emit.isDone) return;

    emit(state.copyWith(isSaving: false));
  }
}
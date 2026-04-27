abstract class EditWatchlistEvent {}

class LoadEditWatchlist extends EditWatchlistEvent {
  final String name;
  LoadEditWatchlist(this.name);
}

class ReorderItems extends EditWatchlistEvent {
  final int oldIndex;
  final int newIndex;

  ReorderItems(this.oldIndex, this.newIndex);
}

class DeleteItem extends EditWatchlistEvent {
  final int index;
  DeleteItem(this.index);
}

class SaveItems extends EditWatchlistEvent {}
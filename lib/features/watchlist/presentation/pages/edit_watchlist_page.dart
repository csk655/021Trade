import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/edit_watchlist_bloc.dart';
import '../bloc/edit_watchlist_event.dart';
import '../bloc/edit_watchlist_state.dart';

class EditWatchlistPage extends StatefulWidget {
  final String watchlistName;

  const EditWatchlistPage({super.key, required this.watchlistName});

  @override
  State<EditWatchlistPage> createState() => _EditWatchlistPageState();
}

class _EditWatchlistPageState extends State<EditWatchlistPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.watchlistName);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditWatchlistBloc>().add(
        LoadEditWatchlist(widget.watchlistName),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: Text("Edit ${widget.watchlistName}"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<EditWatchlistBloc, EditWatchlistState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildNameField(),
              Expanded(child: _buildList(state)),
              _buildBottomButtons(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const Icon(Icons.edit, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildList(EditWatchlistState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.items.isEmpty) {
      return const Center(child: Text("No instruments"));
    }

    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      itemCount: state.items.length,
      onReorder: (oldIndex, newIndex) {
        context.read<EditWatchlistBloc>().add(ReorderItems(oldIndex, newIndex));
      },
      itemBuilder: (context, index) {
        final item = state.items[index];

        return Container(
          key: ValueKey(item.stockId),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA))),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),

            leading: ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_handle),
            ),

            title: Text(
              item.name,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),

            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<EditWatchlistBloc>().add(DeleteItem(index));
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomButtons(BuildContext context, EditWatchlistState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFEAEAEA))),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Edit other watchlist",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.isSaving
                  ? null
                  : () {
                      context.read<EditWatchlistBloc>().add(SaveItems());

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Watchlist saved")),
                      );

                      Navigator.pop(context, true);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: state.isSaving
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "Save Watchlist",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

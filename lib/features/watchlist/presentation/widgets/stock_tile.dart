import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/stock.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../pages/edit_watchlist_page.dart';

class StockTile extends StatelessWidget {
  final Stock stock;
  final String watchListName;

  const StockTile({
    super.key,
    required this.stock,
    required this.watchListName,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = stock.change >= 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: InkWell(
        onLongPress: () async {


          print('watchlist $watchListName');

          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EditWatchlistPage(watchlistName: watchListName),
            ),
          );

          if (result == true) {
            context.read<WatchlistBloc>().add(LoadWatchlist(watchListName));
          }
        },
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stock.type,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stock.price.toStringAsFixed(2),
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${stock.change.toStringAsFixed(2)} (${stock.percent.toStringAsFixed(2)}%)",
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

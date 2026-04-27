import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';
import '../widgets/stock_tile.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  int selectedTab = 0;

  final tabs = ['Watchlist 1', 'Watchlist 2', 'Watchlist 3'];

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WatchlistBloc>().add(
        LoadWatchlist(tabs[selectedTab]),
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildMarketStrip(),
            _buildSearchBar(),
            _buildTabs(),
            _buildSortButton(),
            Expanded(child: _buildList()),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketStrip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _marketItem("SENSEX 24TH SEP", "1,225.55", "130", true),
          //const SizedBox(width: 20),

          Container(
            width: 1,
            height: 50,
            color: Color(0xFFEAEAEA),
          ),
          _marketItem("NIFTY BANK", "54,172.15", "-14.75", false),
        ],
      ),
    );
  }

  Widget _marketItem(String title, String price, String change, bool positive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        Row(
          children: [
            Text(price, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              change,
              style: TextStyle(
                color: positive ? Colors.green : Colors.red,
                fontSize: 13,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search for instruments",
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  context
                      .read<WatchlistBloc>()
                      .add(SearchWatchlist(value));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTabs() {
    return SizedBox(
      height: 40,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedTab;
          return GestureDetector(
            onTap: () {
              setState(() => selectedTab = index);

              context.read<WatchlistBloc>().add(
                LoadWatchlist(tabs[index]),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    tabs[index],
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (isSelected)
                    Container(
                      height: 2,
                      width: 60,
                      color: Colors.black,
                    )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }


  Widget _buildSortButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.tune, size: 18),
              SizedBox(width: 6),
              Text("Sort by"),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildList() {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state is WatchlistLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WatchlistLoaded) {
          if (state.stocks.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.separated(
            itemCount: state.stocks.length,
            separatorBuilder: (context, int) => const Divider(height: 1),
            itemBuilder: (context, index) =>
                StockTile(stock: state.stocks[index],watchListName: tabs[selectedTab]),
          );
        }

        return const Center(child: Text("Something went wrong"));
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.bookmark_border, size: 50, color: Colors.grey),
          const SizedBox(height: 10),
          const Text(
            "No Stocks",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          const Text(
            "Add Stocks to this watchlist",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {

            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }
}
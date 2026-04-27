import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade/core/network/api_service.dart';

import 'features/watchlist/data/datasource/watchlist_local_data_source.dart';
import 'features/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'features/watchlist/domain/repositories/watchlist_repository.dart';
import 'features/watchlist/domain/usecases/get_watchlist.dart';
import 'features/watchlist/domain/usecases/save_watchlist.dart';
import 'features/watchlist/presentation/bloc/edit_watchlist_bloc.dart';

import 'features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'features/watchlist/presentation/pages/watchlist_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => ApiService()),

        RepositoryProvider(
          create: (context) => WatchlistLocalDataSource(
            context.read<ApiService>(),
          ),
        ),

        RepositoryProvider<WatchlistRepository>(
          create: (context) => WatchlistRepositoryImpl(
            context.read<WatchlistLocalDataSource>(),
          ),
        ),

        RepositoryProvider(
          create: (context) => GetWatchlist(
            context.read<WatchlistRepository>(),
          ),
        ),

        RepositoryProvider(
          create: (context) => SaveWatchlist(
            context.read<WatchlistRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WatchlistBloc(
              context.read<GetWatchlist>(),
            ),
          ),
          BlocProvider(
            create: (context) => EditWatchlistBloc(
              context.read<GetWatchlist>(),
              context.read<SaveWatchlist>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Trade App',
        //  theme: _buildLightTheme(),
          home: const HomePage(),
        ),
      ),
    );
  }
}

ThemeData _buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 14)),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final _pages = const [
    WatchlistPage(),
    OrdersPage(),
    GttPage(),
    PortfolioPage(),
    FundsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on_outlined),
            label: 'GTT+',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Funds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

//sample tabs, created here ,will move in proper pages  while implementation

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Orders'));
  }
}

class GttPage extends StatelessWidget {
  const GttPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('GTT+'));
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Portfolio'));
  }
}

class FundsPage extends StatelessWidget {
  const FundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Funds'));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile'));
  }
}

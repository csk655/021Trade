Trading App (Flutter)
(App Recording is also added in repo, Pls go through the  application  and its implementation)

A simple Flutter app to manage stock watchlists.
Built mainly to practice Bloc, clean architecture, and keeping the codebase structured as it grows.

**NOTE : On LONG PRESS  OF ANY LIST ITEM the WATCHLIST EDIT/REORDER SCREEN WILL OPEN.**

---

**Features**
Multiple watchlists (Watchlist 1, Watchlist 2, etc.)
Search stocks inside a watchlist
Edit watchlist (reorder items, remove items, save changes)
Uses Bloc for state management
Structured using repository pattern

---

**Tech Stack**
Flutter SDK: ^3.11.4
flutter_bloc: ^8.1.3




I followed a basic clean architecture approach to keep things separated:

UI → only handles rendering
Bloc → handles state and events
Usecases → contain business logic
Repository → abstraction layer
DataSource → actual data (currently static)

Flow looks like this:

UI → Bloc → UseCase → Repository → DataSource



---

**Data source**

Right now data is static, used from App Constants

static final Map<String, List<Map<String, dynamic>>> watchlists = {
  "Watchlist 1": [],
  "Watchlist 2": [],
  "Watchlist 3": [],
};

Can be easily replaced with API later.

**Bloc usage**
  1. WatchlistBloc
      Load watchlist
      Search inside list
  2. EditWatchlistBloc
      Load editable data
      Reorder items
      Delete items
      Save updated list



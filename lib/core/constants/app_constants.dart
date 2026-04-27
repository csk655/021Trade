class AppConstants {
  static const String appName = "Trade App";

  static final Map<String, List<Map<String, dynamic>>> watchlists = {
    "Watchlist 1": [
      {
        "stockId":1,
        "name": "HDFCBANK",
        "price": 966.95,
        "change": 0.95,
        "percent": 0.10,
        "type":"NSE | EQ"
      },
      {"stockId":2,
        "name": "ASIANPAINT",
        "price": 2537.40,
        "change": 6.60,
        "percent": 0.26,
        "type":"NSE | EQ"
      },
      {
        "stockId":3,
        "name": "RELIANCE",
        "price": 1374.10,
        "change": -4.40,
        "percent": -0.32,
        "type":"NSE | EQ"
      },
      {"stockId":4,
        "name": "Nifty IT",
        "price": 35184.30,
        "change": 873.86,
        "percent": 2.55,
        "type":"IDX"
      },
      {
        "stockId":5,
        "name": "RELIANCE SEP 1370 PE",
        "price": 19.20,
        "change": 1.00,
        "percent": 5.49,
        "type":"NSE | Monthly"
      },
      {
        "stockId":6,
        "name": "MRF",
        "price": 147439.45,
        "change": 463.80,
        "percent": 0.32,
        "type":"BSE | EQ"
      },
      {
        "stockId":7,
        "name": "MRF",
        "price": 1474625.00,
        "change": 46.80,
        "percent": 0.32,
        "type":"NSE | EQ"
      }
    ],

    "Watchlist 2": [
      {
      "stockId":8,
      "name": "INFY",
      "price": 1154.60,
      "change": -86.1,
      "percent": -6.46,
      "type":"NSE | EQ"
    }
    ],
    "Watchlist 3": [],
  };
}
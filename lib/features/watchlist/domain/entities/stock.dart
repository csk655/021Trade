class Stock {
  final int stockId;
  final String name;
  final String type;
  final double price;
  final double change;
  final double percent;

  Stock({
    required this.name,
    required this.stockId,
    required this.type,
    required this.price,
    required this.change,
    required this.percent,
  });
}
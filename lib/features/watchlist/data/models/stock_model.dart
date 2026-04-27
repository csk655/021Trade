import '../../domain/entities/stock.dart';

class StockModel extends Stock {
  StockModel({
    required super.stockId,
    required super.name,
    required super.type,
    required super.price,
    required super.change,
    required super.percent,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      stockId: json['stockId'],
      name: json['name'],
      type: json['type'],
      price: json['price'],
      change: json['change'],
      percent: json['percent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "stockId": stockId,
      "name": name,
      "type": type,
      "price": price,
      "change": change,
      "percent": percent,
    };
  }
}
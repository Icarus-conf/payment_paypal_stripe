class ItemsModel {
  List<OrderItemsModel>? items;

  ItemsModel({this.items});

  ItemsModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <OrderItemsModel>[];
      json['items'].forEach((v) {
        items!.add(OrderItemsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItemsModel {
  String? name;
  int? quantity;
  String? price;
  String? currency;

  OrderItemsModel({this.name, this.quantity, this.price, this.currency});

  OrderItemsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['currency'] = currency;
    return data;
  }
}

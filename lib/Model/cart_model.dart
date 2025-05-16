class CartModel {
  String? title;
  double? price;
  int? quantity;
  String? image;
  double? fixedPrice;
  String? subtitle;

  CartModel(
      {this.title,
      this.price,
      this.quantity,
      this.image,
      this.fixedPrice,
      this.subtitle});

  CartModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
    fixedPrice = json['fixedPrice'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['quantity'] = quantity;
    data['image'] = image;
    data['fixedPrice'] = fixedPrice;
    data['subtitle'] = subtitle;
    return data;
  }
}

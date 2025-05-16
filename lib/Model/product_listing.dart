class ProductListingModel {
  String? title;
  double? price;
  double? fixedPrice;
  String? subtitlee;
  String? image;
  int? bags;

  ProductListingModel(
      {this.title, this.price, this.subtitlee,this.fixedPrice, this.image, this.bags});

  ProductListingModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    fixedPrice = json['fixedPrice'];
    subtitlee = json['subtitlee'];
    image = json['image'];
    bags = json['bags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['fixedPrice'] = fixedPrice;
    data['subtitlee'] = subtitlee;
    data['image'] = image;
    data['bags'] = bags;
    return data;
  }
}

class Product{
  int? id;
  int? categoryId;
  String? productName;
  String? quantityPerUnit;
  double? unitPrice;
  int? unitsInStock;

  Product(this.id, this.categoryId, this.productName, this.quantityPerUnit,
      this.unitPrice, this.unitsInStock);

  Product.fromJson(Map json) {
    id =  json["id"];
    categoryId = json["categoryId"];
    productName = json["productName"];
    quantityPerUnit = json["quantityPerUnit"];
    // Convert unitPrice to double if it's a String
    if (json["unitPrice"] is String) {
      unitPrice = double.tryParse(json["unitPrice"] as String);
    } else {
      unitPrice = json["unitPrice"]?.toDouble();
    }

    // Handle unitsInStock, assuming it could also be a String
    if (json["unitsInStock"] is String) {
      unitsInStock = int.tryParse(json["unitsInStock"] as String);
    } else {
      unitsInStock = json["unitsInStock"];
    }
  }

  Map toJson() {
    return {"id": id,//
      "categoryId": categoryId,//
      "productName": productName,//
      "quantityPerUnit" : quantityPerUnit,//
      "unitPrice" : unitPrice, //
      "unitsInStock": unitsInStock};
  }

}
class Item {
  late String productName;
  late int id;
  late String image;
  String? from;
  String? nutrients;
  String? quantity;
  late String price;
  bool? organic;
  late String description;

  Item(
      {required this.productName,
      required this.id,
      required this.image,
      this.from,
      this.nutrients,
      this.quantity,
      required this.price,
      this.organic,
      required this.description});
}

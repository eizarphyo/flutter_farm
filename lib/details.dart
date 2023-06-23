import 'package:flutter/material.dart';
import 'package:msi_farm/model/item_list.dart';

class Details extends StatelessWidget {
  Details({super.key, required this.id});

  int id;
  int index = 0;
  ItemList items = ItemList();

  List<String> nutrients = [];

  bool gotNutrients() {
    String nutrients;
    if (items.getNutrients(index) != null) {
      nutrients = items.getNutrients(index)!;
      this.nutrients = nutrients.split(",");
      // debugPrint("${this.nutrients}");
      return true;
    }
    return false;
  }

  bool gotIndex() {
    // debugPrint("id >>>>>>>>>>>>>>>>> $id");
    for (int i = 0; i < items.getItemsLength(); i++) {
      if (id == items.getId(i)) {
        index = i;
        // debugPrint(">>>>>>>>>>>>>>>>> $index");
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Center(
        child: gotIndex()
            ? Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${items.getImage(index)}${items.getImage(index)}",
                        style: const TextStyle(fontSize: 70),
                      ),
                      Column(
                        children: [
                          Text(
                            items.getProductName(index),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          gotNutrients()
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (String nutrient in nutrients)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 3),
                                          child: Text(
                                            nutrient,
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),

                      // DESCRIPTION
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Text(
                          items.getDescription(index),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                      // ADD TO CART BUTTON
                      MaterialButton(
                        onPressed: () {},
                        minWidth: MediaQuery.of(context).size.width * 0.35,
                        color: Colors.teal.shade200,
                        child: const Text("Add to Cart"),
                      )
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}

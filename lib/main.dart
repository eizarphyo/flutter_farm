import 'package:flutter/material.dart';
import 'package:msi_farm/details.dart';
import 'package:msi_farm/model/item_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // home: const Farm(),
      initialRoute: "/",
      routes: {
        "/": (context) => const Farm(),
        // "/details": (context) => Details(),
      },
    );
  }
}

class Farm extends StatefulWidget {
  const Farm({super.key});

  @override
  State<Farm> createState() => _FarmState();
}

class _FarmState extends State<Farm> {
  ItemList items = ItemList();
  // int index = 0;
  List<int> itemLength = [];

  void function() {
    for (int i = 0; i < items.getItemsLength(); i++) {
      itemLength.add(i);
      // debugPrint("$itemLength");
    }
  }

  @override
  void initState() {
    super.initState();
    function();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FreshyFarm",
          style: TextStyle(
              fontFamily: "Alkatra",
              color: Colors.teal.shade400,
              fontWeight: FontWeight.bold),
        ),
        // titleTextStyle: TextStyle(fontFamily: "Alkatra"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal.shade50),
              child: Text(""),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   "Welcome!",
                  //   textAlign: TextAlign.start,
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontFamily: "Merriweather",
                  //       fontWeight: FontWeight.w400),
                  // ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Text(
                      "Get groceries without leaving your home!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Merriweather",
                      ),
                    ),
                  ),
                  Text(
                    "\"We provide fresh fruits and vegetables with affordable price\" — James",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontFamily: "Merriweather",
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width * 1,
              //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              //   decoration: const BoxDecoration(
              //       border: Border(bottom: BorderSide(color: Colors.black))),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    child: Text(
                      "Currently in Stocks",
                      style: TextStyle(
                        fontSize: 16.5,
                        fontFamily: "Merriweather",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  for (int index in itemLength)
                    ItemRow(
                      productName: items.getProductName(index),
                      id: items.getId(index),
                      image: items.getImage(index),
                      price: items.getPrice(index),
                      description: items.getDescription(index),
                      onTap: () {
                        int id = items.getId(index);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Details(id: id);
                        }));
                        // Navigator.pushNamed(context, "/details");
                      },
                    ),
                ],
              ),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  ItemRow(
      {super.key,
      required this.onTap,
      required this.productName,
      required this.id,
      required this.image,
      this.from,
      this.nutrients,
      this.quantity,
      required this.price,
      this.organic,
      required this.description});

  String productName;
  int id;
  String image;
  String? from;
  String? nutrients;
  String? quantity;
  String price;
  bool? organic;
  String description;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          border: const Border(
            left: BorderSide(color: Colors.teal, width: 3),
          ),
        ),
        child: ListTile(
          minLeadingWidth: MediaQuery.of(context).size.width * 0.13,
          leading: Text(
            image,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          title: Text(
            productName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Row(children: [Text("$price€")]),
          trailing: MaterialButton(
            onPressed: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Details",
                  style: TextStyle(color: Colors.teal.shade300, fontSize: 14),
                ),
                Icon(
                  Icons.play_arrow_rounded,
                  size: 16,
                  color: Colors.teal.shade300,
                )
              ],
            ),
          ),
        ),
      ),

      // Container(
      //   height: MediaQuery.of(context).size.height * 0.13,
      //   decoration: BoxDecoration(
      //     color: Colors.teal.shade50,
      //     border: const Border(
      //       left: BorderSide(color: Colors.teal, width: 3),
      //     ),
      //   ),
      //   child:
      //       Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 10),
      //         child: Text(
      //           image,
      //           style: const TextStyle(
      //               color: Colors.black,
      //               fontSize: 25,
      //               fontWeight: FontWeight.w500),
      //         ),
      //       ),
      //       Text(
      //         productName,
      //         maxLines: 2,
      //         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      //       ),
      //       Text(
      //         "$price \$",
      //       ),
      //       MaterialButton(
      //           onPressed: onTap,
      //           child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Text(
      //                 "Details",
      //                 style: TextStyle(
      //                     color: Colors.teal.shade300,
      //                     fontSize: 14,
      //                     fontWeight: FontWeight.w500),
      //               ),
      //               Icon(
      //                 Icons.play_arrow_rounded,
      //                 color: Colors.teal.shade300,
      //                 size: 16,
      //               )
      //             ],
      //           )),
      //     ],
      //   ),
      // ),
    );
  }
}

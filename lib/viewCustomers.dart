import 'package:banking_app_sparks/customerDetails.dart';
import 'package:banking_app_sparks/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewCutomers extends StatefulWidget {
  const ViewCutomers({Key? key}) : super(key: key);

  @override
  State<ViewCutomers> createState() => _ViewCutomersState();
}

List<Map<String, dynamic>> listOfCustomers = [];

class _ViewCutomersState extends State<ViewCutomers> {
  getRecords() async {
    List<Map<String, dynamic>> records = [];
    listOfCustomers = [];
    records = await DatabaseHelper.instance.queryAll();
    for (var element in records) {
      setState(() {
        Map<String, dynamic> eachCustomer = {};
        eachCustomer[DatabaseHelper.customerTableCid] =
            element[DatabaseHelper.customerTableCid];
        eachCustomer[DatabaseHelper.customerTableCname] =
            element[DatabaseHelper.customerTableCname];
        eachCustomer[DatabaseHelper.customerTableCemail] =
            element[DatabaseHelper.customerTableCemail];
        eachCustomer[DatabaseHelper.customerTableCaccNo] =
            element[DatabaseHelper.customerTableCaccNo];
        eachCustomer[DatabaseHelper.customerTableCifscNo] =
            element[DatabaseHelper.customerTableCifscNo];
        eachCustomer[DatabaseHelper.customerTableCbalance] =
            element[DatabaseHelper.customerTableCbalance];
        listOfCustomers.add(eachCustomer);
      });
    }
    print(listOfCustomers.length);
    print("In fn : $listOfCustomers");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/banking app bg.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "All",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                " Customers",
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: 35,
            )
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: listOfCustomers.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              CustomerDetails(
                                  customerID: listOfCustomers[index]
                                      [DatabaseHelper.customerTableCid],
                                  customerName: listOfCustomers[index]
                                      [DatabaseHelper.customerTableCname],
                                  customerEmail: listOfCustomers[index]
                                      [DatabaseHelper.customerTableCemail],
                                  customerAccNo: listOfCustomers[index]
                                      [DatabaseHelper.customerTableCaccNo],
                                  customerIFSCNo: listOfCustomers[index]
                                      [DatabaseHelper.customerTableCifscNo],
                                  customerBalance: listOfCustomers[index]
                                      [DatabaseHelper.customerTableCbalance]),
                              duration: const Duration(milliseconds: 300),
                              transition: Transition.zoom,
                            );
                          },
                          child: Card(
                            elevation: 5,
                            color: Colors.transparent,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              title: Text(
                                '${listOfCustomers[index][DatabaseHelper.customerTableCname]}',
                                style: const TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                children: [
                                  const Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    listOfCustomers[index]
                                        [DatabaseHelper.customerTableCemail],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                'Rs ${listOfCustomers[index][DatabaseHelper.customerTableCbalance]}/-',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:banking_app_sparks/databaseHelper.dart';
import 'package:banking_app_sparks/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferToPage extends StatefulWidget {
  final int senderID;
  final String senderName;
  final String senderEmail;
  final String senderAccNo;
  final String senderIFSCNo;
  final int senderBalance;
  final int amountEntered;
  TransferToPage({
    required this.senderID,
    required this.senderName,
    required this.senderEmail,
    required this.senderAccNo,
    required this.senderIFSCNo,
    required this.senderBalance,
    required this.amountEntered,
  });
  @override
  State<TransferToPage> createState() => _TransferToPageState();
}

List<Map<String, dynamic>> listOfCustomers = [];

class _TransferToPageState extends State<TransferToPage> {
  getRecords() async {
    List<Map<String, dynamic>> records = [];
    listOfCustomers = [];
    print("Sender ID: ${widget.senderID}");
    records =
        await DatabaseHelper.instance.queryAllExceptSender(widget.senderID);
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
    print("Amount to be reduced: ${widget.amountEntered}");
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
                "Choose",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                " Receiver",
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
                          onTap: () async {
                            int senderBalance =
                                widget.senderBalance - widget.amountEntered;
                            int receiverBalance = listOfCustomers[index]
                                    [DatabaseHelper.customerTableCbalance] +
                                widget.amountEntered;
                            Map<String, dynamic> senderRow = {
                              DatabaseHelper.customerTableCid: widget.senderID,
                              DatabaseHelper.customerTableCname:
                                  widget.senderName,
                              DatabaseHelper.customerTableCemail:
                                  widget.senderEmail,
                              DatabaseHelper.customerTableCaccNo:
                                  widget.senderAccNo,
                              DatabaseHelper.customerTableCifscNo:
                                  widget.senderIFSCNo,
                              DatabaseHelper.customerTableCbalance:
                                  senderBalance
                            };
                            Map<String, dynamic> receiverRow = {
                              DatabaseHelper.customerTableCid:
                                  listOfCustomers[index]
                                      [DatabaseHelper.customerTableCid],
                              DatabaseHelper.customerTableCname:
                                  listOfCustomers[index]
                                      [DatabaseHelper.customerTableCname],
                              DatabaseHelper.customerTableCemail:
                                  listOfCustomers[index]
                                      [DatabaseHelper.customerTableCemail],
                              DatabaseHelper.customerTableCaccNo:
                                  listOfCustomers[index]
                                      [DatabaseHelper.customerTableCaccNo],
                              DatabaseHelper.customerTableCifscNo:
                                  listOfCustomers[index]
                                      [DatabaseHelper.customerTableCifscNo],
                              DatabaseHelper.customerTableCbalance:
                                  receiverBalance
                            };
                            print("Going to update: $senderRow");
                            print("Receiver Balance: $receiverBalance");
                            int senderRowUpdated =
                                await DatabaseHelper.instance.update(senderRow);
                            int receiverRowUpdated = await DatabaseHelper
                                .instance
                                .update(receiverRow);
                            print("After sender row update: $senderRowUpdated");
                            print(
                                "After receiver row update: $receiverRowUpdated");
                            Map<String, dynamic> transactionRow = {
                              DatabaseHelper.senderName: widget.senderName,
                              DatabaseHelper.receiverName:
                                  listOfCustomers[index]
                                      [DatabaseHelper.customerTableCname],
                              DatabaseHelper.amountTransfered:
                                  widget.amountEntered
                            };
                            int? i = await DatabaseHelper.instance
                                .insertTransactions(transactionRow);
                            Get.offAll(
                              HomePage(),
                              duration: const Duration(seconds: 1),
                              transition: Transition.rightToLeftWithFade,
                            );
                            Get.snackbar('',
                                "Choose customer whom you want to transfer the money.",
                                backgroundColor: Colors.green,
                                titleText: const Text(
                                  "Successfull",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                messageText: const Text(
                                  "Money has been transfered successfully.",
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ));
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

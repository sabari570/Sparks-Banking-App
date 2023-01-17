import 'package:banking_app_sparks/databaseHelper.dart';
import 'package:flutter/material.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

List<Map<String, dynamic>> allTransactions = [];

class _AllTransactionsState extends State<AllTransactions> {
  getTransactions() async {
    List<Map<String, dynamic>> transactionRecords = [];
    allTransactions = [];
    transactionRecords = await DatabaseHelper.instance.queryAllTransactions();
    print("List of Transactions: $transactionRecords");
    for (var element in transactionRecords) {
      setState(() {
        Map<String, dynamic> eachTransactions = {};
        eachTransactions[DatabaseHelper.transactionID] =
            element[DatabaseHelper.transactionID];
        eachTransactions[DatabaseHelper.senderName] =
            element[DatabaseHelper.senderName];
        eachTransactions[DatabaseHelper.receiverName] =
            element[DatabaseHelper.receiverName];
        eachTransactions[DatabaseHelper.amountTransfered] =
            element[DatabaseHelper.amountTransfered];
        allTransactions.add(eachTransactions);
      });
    }
    print("Content in All transactions: $allTransactions");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransactions();
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
                " Transactions",
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
        body: (allTransactions.isEmpty)
            ? Center(
                child: Container(
                  child: const Text(
                    "No Transactions",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              )
            : Container(
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
                            itemCount: allTransactions.length,
                            itemBuilder: ((context, index) {
                              return Card(
                                elevation: 5,
                                color: Colors.transparent,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${allTransactions[index][DatabaseHelper.senderName]}',
                                          style: const TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.arrow_right_alt_outlined,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        Text(
                                          ' ${allTransactions[index][DatabaseHelper.receiverName]}',
                                          style: const TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Text(
                                    'Rs ${allTransactions[index][DatabaseHelper.amountTransfered]}/-',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
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

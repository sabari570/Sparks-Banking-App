import 'package:banking_app_sparks/transferToPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetails extends StatefulWidget {
  final int customerID;
  final String customerName;
  final String customerEmail;
  final String customerAccNo;
  final String customerIFSCNo;
  final int customerBalance;
  CustomerDetails(
      {required this.customerID,
      required this.customerName,
      required this.customerEmail,
      required this.customerAccNo,
      required this.customerIFSCNo,
      required this.customerBalance});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

int amountEntered = 0;

class _CustomerDetailsState extends State<CustomerDetails> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Clicked Customer name: ${widget.customerName}");
    print("Clicked Customer Accno: ${widget.customerAccNo}");
    print("Clicked Customer IFSC: ${widget.customerIFSCNo}");
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
                "Customer",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                " Details",
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
              width: 50,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/profileDP.jpg'))),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Name: ",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.customerName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email: ",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.customerEmail,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Account No: ",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.customerAccNo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "IFSC Code: ",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.customerIFSCNo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Current Balance: ",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rs ${widget.customerBalance.toString()}/-",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 300,
                            decoration: const BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 16,
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter Amount to be transfered";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          amountEntered = int.parse(value);
                                          print(
                                              "Value Enetered is: $amountEntered");
                                        });
                                      },
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: "Enter Money",
                                          errorStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                width: 5,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 0, 33, 122),
                                                width: 2,
                                              ))),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          if (widget.customerBalance >
                                              amountEntered) {
                                            Get.to(
                                              TransferToPage(
                                                senderID: widget.customerID,
                                                senderName: widget.customerName,
                                                senderEmail:
                                                    widget.customerEmail,
                                                senderAccNo:
                                                    widget.customerAccNo,
                                                senderIFSCNo:
                                                    widget.customerIFSCNo,
                                                senderBalance:
                                                    widget.customerBalance,
                                                amountEntered: amountEntered,
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              transition: Transition
                                                  .rightToLeftWithFade,
                                            );
                                            Get.snackbar('',
                                                "Choose customer whom you want to transfer the money.",
                                                titleText: const Text(
                                                  "Transfer To",
                                                  style: TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                messageText: const Text(
                                                  "Choose customer whom you want to transfer the money.",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ));
                                          } else {
                                            Get.snackbar('',
                                                "Choose customer whom you want to transfer the money.",
                                                backgroundColor:
                                                    Colors.redAccent,
                                                titleText: const Text(
                                                  "Insufficient Balance",
                                                  style: TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                messageText: const Text(
                                                  "Amount Entered is greater than the account balance.",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ));
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 0, 33, 122),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "Transfer To",
                                              style: TextStyle(
                                                color: Colors.yellow,
                                                fontSize: 19,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.send_rounded,
                                              color: Colors.greenAccent,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Text(
                      "Transfer Money",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 33, 122),
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

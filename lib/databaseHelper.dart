import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static final databaseName = "bankingDatabase.db";
  static final databaseVersion = 1;
  static final customersTableName = "Customers_table";
  static final customerTableCid = "Customer_Id";
  static final customerTableCname = "Customer_Name";
  static final customerTableCemail = "Customer_Email";
  static final customerTableCaccNo = "Customer_AccNo";
  static final customerTableCifscNo = "Customer_IFSC";
  static final customerTableCbalance = "Customer_Balance";

  static final transactionTableName = "All_Transactions";
  static final transactionID = "TransactionID";
  static final senderName = "SenderName";
  static final receiverName = "ReceiverName";
  static final amountTransfered = "AmountTransfered";

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initiateDatabase();
    return _database;
  }

  Future<Database?> initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, databaseName);
    return await openDatabase(path,
        version: databaseVersion, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE $customersTableName(
        $customerTableCid INTEGER PRIMARY KEY NOT NULL,
        $customerTableCname TEXT NOT NULL,
        $customerTableCemail TEXT NOT NULL,
        $customerTableCaccNo TEXT NOT NULL,
        $customerTableCifscNo TEXT NOT NULL,
        $customerTableCbalance INTEGER
      )
      ''');
    db.execute('''
      CREATE TABLE $transactionTableName(
        $transactionID INTEGER PRIMARY KEY NOT NULL,
        $senderName TEXT NOT NULL,
        $receiverName TEXT NOT NULL,
        $amountTransfered INTEGER
      )
      ''');
    db.execute('''
      INSERT INTO $customersTableName($customerTableCname,$customerTableCemail,$customerTableCaccNo,$customerTableCifscNo,$customerTableCbalance)
      VALUES("Sharon","sharon123@gmail.com","xxxxxxxxxxxx5011","IFSCASDGG8970",12000),
      ("Siddarth","sid234@gmail.com","xxxxxxxxxxxx5012","IFSCSFGDGG7890",55000),
      ("Gautham","gautham656@gmail.com","xxxxxxxxxxxx5013","IFSCIEFGG8965",43000),
      ("Shreya","shreya877@gmail.com","xxxxxxxxxxxx5014","IFSCJEAGG8955",25000),
      ("Varun","varun567@gmail.com","xxxxxxxxxxxx5015","IFSCMNBGG8945",67000),
      ("Rakesh","rakesh425@gmail.com","xxxxxxxxxxxx5016","IFSCPOIGG8922",72000),
      ("Soumya","soumya098@gmail.com","xxxxxxxxxxxx5017","IFSCLKJGG8934",18000),
      ("Thilak","thilak198@gmail.com","xxxxxxxxxxxx5018","IFSCREFDGG8998",23000),
      ("Shah Rukh","shahrukh62@gmail.com","xxxxxxxxxxxx5019","IFSCKGJHGG8900",48000),
      ("Tanya","tanya990@gmail.com","xxxxxxxxxxxx5020","IFSCYTUGG8966",50000)
      ''');
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instance.database;
    return await db!.query(customersTableName);
  }

  Future<List<Map<String, dynamic>>> queryAllExceptSender(int senderID) async {
    Database? db = await instance.database;
    return await db!.query(customersTableName,
        where: '$customerTableCid!=?', whereArgs: [senderID]);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.update(customersTableName, row,
        where: '$customerTableCid=?', whereArgs: [row[customerTableCid]]);
  }

  Future<int?> insertTransactions(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return db!.insert(transactionTableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAllTransactions() async {
    Database? db = await instance.database;
    return await db!.query(transactionTableName);
  }
}

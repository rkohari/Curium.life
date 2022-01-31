import 'package:sqflite/sqflite.dart';


abstract class BaseDatabaseService {

  Future<void> onConfigure(Database db) async {}

  Future<void> onCreate(Database db, int version) async {

    // await db.execute(SalesPersonConstant().createQuery);
    //
    // await db.execute(CustomerConstant().createQuery);
    // await db.execute(AdditionalContactInfoConstant().createQuery);
    // await db.execute(BankDetailConstant().createQuery);
    // await db.execute(AddressConstant().createQuery);
    //
    // await db.execute(ItemConstant().createQuery);
    // await db.execute(CategoryConstant().createQuery);
    //
    //
    // await db.execute(EstimationConstant().createQuery);
    // await db.execute(EstimationLineConstant().createQuery);
    //
    // await db.execute(InvoiceConstant().createQuery);
    // await db.execute(InvoiceLineConstant().createQuery);
    // await db.execute(ReceiptConstant().createQuery);
    // await db.execute(ReceiptLineConstant().createQuery);


  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<void> onOpen(Database db) async {

  }

}


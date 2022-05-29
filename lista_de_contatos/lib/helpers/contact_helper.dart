import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String contatcTable = "contactTable";
const String idColunm = "idColunm";
const String nameColunm = "nameColunm";
const String emailColunm = "emailColunm";
const String phoneColunm = "phoneColunm";
const String imageColunm = "imageColunm";

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  static Database? _db;

  get db async {
    if (_db != null) {
      return _db;
    } else {
      //initDb().then((value) => _db = value);
      return initDb();
    }
  }

  initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contacts.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contatcTable($idColunm INTEGER PRYMARY KEY, $nameColunm TEXT, $emailColunm TEXT, $phoneColunm TEXT, $imageColunm TEXT)");
    });
  }

  saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contatcTable, contact.toJson());

    return contact;
  }

  getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contatcTable,
        columns: [idColunm, nameColunm, emailColunm, phoneColunm, imageColunm],
        where: "$idColunm = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Contact.fromJson(maps.first);
    } else {
      return null;
    }
  }

  deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contatcTable, where: "$idColunm = ?", whereArgs: [id]);
  }

  updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(contatcTable, contact.toJson(),
        where: "$idColunm = ?", whereArgs: [contact.id]);
  }

  getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contatcTable");
    List<Contact> listContact = [];
    for (Map m in listMap) {
      listContact.add(Contact.fromJson(m));
    }
    return listContact;
  }

  getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $contatcTable"));
  }

  close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}

class Contact {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;

  Contact();

  Contact.fromJson(Map map) {
    id = map[idColunm];
    name = map[nameColunm];
    email = map[emailColunm];
    phone = map[phoneColunm];
    image = map[imageColunm];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColunm: name,
      emailColunm: email,
      phoneColunm: phone,
      imageColunm: image
    };
    if (id != null) {}
    return map;
  }

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        nameColunm: name,
        emailColunm: email,
        phoneColunm: phone,
        imageColunm: image,
        idColunm: id,
      };
    } else {
      return {
        nameColunm: name,
        emailColunm: email,
        phoneColunm: phone,
        imageColunm: image,
      };
    }
  }

  @override
  String toString() {
    return "Contact( id: $id, Nome: $name, email: $email ,Phone: $phone, img: $image)";
  }
}

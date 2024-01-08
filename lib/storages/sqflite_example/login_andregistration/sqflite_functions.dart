import 'package:sqflite/sqflite.dart' as sql;

class SQL_Functions {
  //creating db
  //add dependency flutter pub add sqflite in terminal or in pubspec
  //to access sql in flutter we need sqflite for support
  static Future<sql.Database> openOrCreateDb() async {
    //openOrCreateDb we created to check whether the db is opened or not
    //openDatatbase is from sql
    return sql.openDatabase('users', version: 1, onCreate:
        (sql.Database db, int version) //this oncreate need function so (db,int)
        async {
      await createTable(db); //here we have to give the db as it is as database object
    }); //users is a db name
  }

  ///creating table to store user data
  static Future<void> createTable(sql.Database db) async {
    await db.execute(
        'CREATE TABLE UserData (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, email TEXT, password TEXT)'); //to get auto increment for id we are giving autoincrement and it should never be null
  }

  //as we are accessing this method classname.method in registration page
  //so it created as static
  ///adding new user in the table
  static Future<int> addUser(String name, String email, String password) async {
    //as we going tto return id as gave future<int>
    var db = await SQL_Functions.openOrCreateDb(); //to open datatbase
    //passing values as key value pair so it will correctly go to correct column
//so giving in map
    //key is column name
    //value is from we getting input from that TextFromField
    var data = {'name': name, 'email': email, 'password': password};
    // here keys are column names values are values from textformfiled
    // var id =db.insert('UserDate', {'name':name,'email':email,'password':'password'});
    //instead of giving values directly
    //we can just create a map and passing its map name
    //or
    var id = db.insert('UserData', data);
    return id;
  }

  ///to check user exists in db
  /////we can register many user in table
  //as we have many user in the db
  //it will be in list<map>
  //so we have to check tht user from list<map>
  static Future<List<Map>> checkUserExist(String email, String pwd) async {
    var db = await SQL_Functions.openOrCreateDb();
    final data = await db.rawQuery(
        "SELECT * FROM userdata WHERE email ='$email' AND password ='$pwd' ");

    if (data.isNotEmpty) {
      return data;
    } else {
      return data; //we get empty data
    }
  }

  ///to read all the users from the db
  static Future<List<Map<String, dynamic>>> getALlUSer() async {
    var db = await SQL_Functions.openOrCreateDb();
    final allUsers = await db.rawQuery("SELECT * FROM UserData");
    return allUsers;
  }
///check user is already registered
  static Future<List<Map>> checkUser_already_registered(String email) async {
    var db = await SQL_Functions.openOrCreateDb();
    final user =
        await db.rawQuery("SELECT * FROM UserData WHERE email='$email' ");
    if (user.isNotEmpty) {
      return user;
    } else {
      return user;
    }
  }

  ///to delete a user
  static Future<void> dltUser(int id) async {
    var db = await SQL_Functions.openOrCreateDb();
    db.delete('UserData', where: 'id=?', whereArgs: [id]);//if we want to give particular id can give id=1
    //as we dont know which id will receive for delete fro our n number of user
    //we give 'id=?',and pass that id which user click to delete in whereArgs
  }
///to update in database
  static void update(int id,String uname, String uemail) async{
    var db = await SQL_Functions.openOrCreateDb();
    final newData={'name':uname,'email':uemail};
    final newid=db.update('UserData', newData, where: 'id=?', whereArgs: [id]);

  }

  // static updateUser(int id, String text, String text2) {
  //
  // }


}


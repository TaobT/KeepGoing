import 'package:mysql_client/mysql_client.dart';


Future<void> main(List<String> arguments) async {
  print("Connecting to mysql server...");

  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "autorack.proxy.rlwy.net",
    port: 19407,
    userName: "root",
    password: "gjVxtWDHiFbkjAIuokJpFeODAcjBURQF",
    databaseName: "railway", 
  );

  await conn.connect();

  print("Connected");

  

}
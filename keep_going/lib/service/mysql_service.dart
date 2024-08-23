import 'package:mysql_client/mysql_client.dart';

class MySQLService {
  Future<MySQLConnection> getConnection() async {
    print("Conectando a mysql server...");

    final conn = await MySQLConnection.createConnection(
      host: "autorack.proxy.rlwy.net",
      port: 19407,
      userName: "root",
      password: "gjVxtWDHiFbkjAIuokJpFeODAcjBURQF",
      databaseName: "railway",
    );
    await conn.connect();

    print("Conectado a MySQL server con éxito");

    return conn;
  }

  Future<List<Map<String, dynamic>>> getHeartRateData() async {
    final conn = await getConnection();

    // Ejecutar la consulta para obtener los datos del sensor con clave 3 (pulso)
      // "SELECT valor, fechaRegistro FROM tbl_detalle_sensor WHERE cveSensor = 3"
    var res = await conn.execute(
      "SELECT valor, fechaRegistro FROM tbl_detalle_sensor WHERE cveSensor = 3 ORDER BY fechaRegistro DESC LIMIT 1"

    );
    
    print(res);

    List<Map<String, dynamic>> data = [];
    for (final row in res.rows) {
      data.add({
        "frecuencia": row.colAt(0),          // valor del pulso
        "fechaRegistro": row.colAt(1),  // fecha del registro
      });
      //print(data);
    }

    await conn.close();
    return data;
  }

}

 
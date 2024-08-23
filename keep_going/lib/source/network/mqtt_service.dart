import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final MqttServerClient client;

  MqttService(String server)
  : client = MqttServerClient(server, '') {
    // Agregar la version minima del protocolo MQTT

    client.setProtocolV311();

    // Tiempo de espera par la conexión
    client.keepAlivePeriod = 20;

    // Generar un mensaje de conexión
    final connMessage = MqttConnectMessage()
    .withClientIdentifier('aaa11')
    .startClean()
    .withWillQos(MqttQos.exactlyOnce);

    client.connectionMessage = connMessage;
    print('::Inicializado correctamente::');
  }

  Future<void> connect() async {
    try {
      await client.connect();
    } catch (e) {
      print('Error de conexión: $e');
      client.disconnect();
    }

    if (client.connectionStatus?.state != MqttConnectionState.connected) {
      print('Error: No conectado');
      client.disconnect();
    }
  }

  Stream<double> obtenerStreamDeSensor(String topic) async* {
    try{
      await client.connect();
    }catch (e){
      print(e);  
      client.disconnect();
      return;
    }
    //Verificar si el cliente se conecto
    if(client.connectionStatus?.state == MqttConnectionState.connected){
      // Generar la suscripcion al topico
      client.subscribe('iot/resul/temp', MqttQos.exactlyOnce);

      // Obtener los valores del topico
      await for (final c in client.updates!){
        final pubMessage = c[0].payload as MqttPublishMessage;
        final String message = MqttPublishPayload.bytesToString(pubMessage.payload.message);
        yield double.tryParse(message) ?? 0.0;
      }
    } else {
      client.disconnect();
    }


  }

}



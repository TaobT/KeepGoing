import 'package:dio/dio.dart';
import 'package:translator/translator.dart';
import 'package:keep_going/domain/entities/frase.dart';
import 'package:keep_going/infrastructure/models/frase_model.dart';



class FitnessAnswer {
  final Dio _dio = Dio(); 
  final GoogleTranslator _translator = GoogleTranslator();  

  Future<Frase> fraseApi({String toLang = 'es'}) async{
    print('Llamando a la API para obtener la frase');
    final response = await _dio.get(
      'https://api.api-ninjas.com/v1/quotes?category=inspirational',
      options: Options(
          headers: {
            'X-Api-Key': 'evYVTwb8g9UeabUDU1ydzA==f3qi4OakH3LpS2mR', 
          },
        ),

    );
     print('Respuesta sin procesar de la API: ${response.data}');

    final quotesModel = QuotesModel.fromJsonToMap(response.data[0]);
    var translatedQuote = await _translator.translate(quotesModel.quote, to: toLang);

    print('Frase traducida: ${translatedQuote.text}');

    // return quotesModel.toFraseEntity();
    return Frase(
        quote: translatedQuote.text,
        author: quotesModel.author,
        category: quotesModel.category,
    );

  }
}
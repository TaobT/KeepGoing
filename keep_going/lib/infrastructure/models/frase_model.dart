import 'package:keep_going/domain/entities/frase.dart';


class QuotesModel {
    String quote;
    String author;
    String category;

    QuotesModel({
      required this.quote,
      required this.author,
      required this.category,
    });

    factory QuotesModel.fromJsonToMap(Map<String, dynamic> json) => QuotesModel(
        quote: json["quote"],
        author: json["author"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
            "quote": quote,
            "author": author,
            "category": category,
    };

    Frase toFraseEntity() => Frase(
      quote: quote,
      author: author,
      category:category
    );
}



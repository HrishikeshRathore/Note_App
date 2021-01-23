import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier{

  final String id;
  final String title;
  final String description;
  final String date;
  bool archive;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.date,
    this.archive = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'archive': archive ? 1 : 0,
    };
  }

}
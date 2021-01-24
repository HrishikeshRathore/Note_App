import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';
import '../database/database.dart';

class ProviderProducts with ChangeNotifier{

  List<Product> _items = [
    // Product(id: 'a', title: 'Note 1', description: 'This is the testing description for Note1, Kindly cooperate', date: DateFormat.yMMMd().format(DateTime.now())),
    // Product(id: 'b', title: 'Note 2', description: 'This is the testing description for Note2, Kindly cooperate', date: DateFormat.yMMMd().format(DateTime.now())),
    // Product(id: 'c', title: 'Note 3', description: 'This is the testing description for Note3, Kindly cooperate', date: DateFormat.yMMMd().format(DateTime.now())),
    // Product(id: 'd', title: 'Note 4', description: 'This is the testing description for Note4, Kindly cooperate', date: DateFormat.yMMMd().format(DateTime.now())),
  ];

  List<Product> get items {
    return [..._items];
  }



  List<Product> allItems = [];

  bool fetchingArchive = false;

  Future<void> showArchive(bool archive) async{

    List<Map<String, dynamic>> listOfNotes = await DatabaseNote.getNotes();
    _items = listOfNotes.map((note) => Product(
      id: note['id'],
      title: note['title'],
      description: note['description'],
      date: note['date'],
      archive: note['archive'] == 1 ? true : false,
    )
    ).toList();


    // allItems = [..._items];
    // _items = _items.where((element) => element.archive == true);

    if(archive){
     // print(allItems[0].archive);
      var archiveItems = [..._items].where((element) => element.archive == true).toList();
      _items = archiveItems;
      fetchingArchive = true;
    }
    else{
      _items = [..._items].where((element) => element.archive == false).toList();
      fetchingArchive = false;
    }
    notifyListeners();
  }

  Future<void> convertToArchive(String id, bool toArchive) async{
    var items = [..._items];

    Product productToArchive = items.firstWhere((element) => element.id == id);
    int productIndex = items.indexWhere((element) => element.id == id);

    productToArchive.archive = toArchive;
    _items[productIndex] = productToArchive;
    

    await DatabaseNote.updateNote(productToArchive);
    // allItems = [..._items];

    _items.removeAt(productIndex);

    notifyListeners();

  }



  // List<Product> get archiveItems{
  //   return _items.where((element) => element.archive == true).toList();
  // }

  Future<void> removeItem(String id) async {
    _items.removeWhere((element) => element.id == id);
    await DatabaseNote.deleteNote(id);
    notifyListeners();
  }


  Future<Product> findProduct(String id) async{
    //

    List<Map<String, dynamic>> listOfNotes = await DatabaseNote.getNotes();
    _items = listOfNotes.map((note) => Product(
      id: note['id'],
      title: note['title'],
      description: note['description'],
      date: note['date'],
      archive: note['archive'] == 1 ? true : false,
    )
    ).toList();

    return _items.firstWhere((element) => element.id == id);
  }

  void addProduct(Product product) async{
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        date: product.date,
        archive: product.archive,
    );
    _items.insert(0, newProduct);
    await DatabaseNote.insertNote(newProduct);
    notifyListeners();
  }

  Future<void> getNotes() async {
    List<Map<String, dynamic>> listOfNotes = await DatabaseNote.getNotes();
    _items = listOfNotes.map((note) => Product(
        id: note['id'],
        title: note['title'],
        description: note['description'],
        date: note['date'],
        archive: note['archive'] == 1 ? true : false,
    )
    ).toList();

    _items = _items.where((element) => element.archive == false).toList();

    notifyListeners();
  }

  Future<void> updateNote(String id,Product product) async {
    final noteIndex = _items.indexWhere((element) => element.id == id);
    if(noteIndex >= 0){
      _items[noteIndex] = product;
      await DatabaseNote.updateNote(product);
      notifyListeners();
    }
    else{
    print('....');
    }
  }

}
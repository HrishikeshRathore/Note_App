import 'package:flutter/material.dart';
import 'package:new_notes/models/product.dart';
import '../providers/provider_products.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {

  static const routeName = '/detail-screen';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final providerPack = ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(providerPack.title),
      ),

      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            elevation: 5,
            shadowColor: Colors.blueGrey,
            child: Container(
              width: MediaQuery.of(context).size.width * .95,
              margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        providerPack.title,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Divider(
                        height: 40,
                      ),

                      Text(
                        providerPack.description,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete,
                        color: Colors.blueGrey,),
                        onPressed: (){},
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          providerPack.date,
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}

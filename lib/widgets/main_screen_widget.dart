import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_notes/models/product.dart';

import '../providers/provider_products.dart';
import '../providers/provider_products.dart';
import '../screens/edit_note.dart';
import 'package:provider/provider.dart';


class MainScreenWidget extends StatelessWidget {

  final String id;
  final String title;
  final String description;
  final String date;
  final bool archive;

  MainScreenWidget({
    this.id,
    this.title,
    this.description,
    this.date,
    this.archive,
  });

  @override
  Widget build(BuildContext context) {

    final getArch = Provider.of<ProviderProducts>(context).fetchingArchive;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      padding: EdgeInsets.all(4),
      child: Card(
        color: Colors.white54,
        child: GridTile(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(18),
              padding: EdgeInsets.all(2),
              child: Text(description,
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
          header: Container(
            margin: EdgeInsets.only(top: 8),
            transform: Matrix4.rotationZ(-0.02),
            child: GridTileBar(
              backgroundColor: Colors.blueGrey,
              title: SizedBox(),
              leading: Text(title, textAlign: TextAlign.start, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(DateFormat.yMMMd().format(DateTime.parse(date)) ,style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),),
                    Text(DateFormat.Hm().format(DateTime.parse(date)), style: TextStyle(color: Colors.white, fontSize: 10),),
                  ],
              ),
            ),
          ),
          footer: Container(
            transform: Matrix4.rotationZ(-0.02),
            child: GridTileBar(
              backgroundColor: Colors.blueGrey,
              title: SizedBox(
              ),
              leading: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditNote.routeName, arguments: Product(id: id, title: title, description: description, date: date, archive: archive));
                },
                alignment: Alignment.centerLeft,
              ),

              trailing: Row(
                children: [

                  IconButton(
                    icon: Icon(getArch == false ? Icons.archive : Icons.unarchive),
                    onPressed: () {
                      if(getArch == false)
                        Provider.of<ProviderProducts>(context, listen: false)
                            .convertToArchive(id, true);
                      else
                        Provider.of<ProviderProducts>(context, listen: false)
                            .convertToArchive(id, false);
                    },
                    alignment: Alignment.centerRight,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Provider.of<ProviderProducts>(context, listen: false).removeItem(id);
                    },
                    alignment: Alignment.centerRight,
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

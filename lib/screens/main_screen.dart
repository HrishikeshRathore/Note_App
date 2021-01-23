import 'package:flutter/material.dart';
import 'package:new_notes/screens/edit_note.dart';
import '../screens/detail_screen.dart';
import '../providers/provider_products.dart';

import '../widgets/main_screen_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                  Navigator.of(context).pushNamed(EditNote.routeName);
              },
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/note_image.jpg'),
                )
              ),
            ),

            ListTile(
              leading: Icon(Icons.notes),
              title: Text('All'),
              onTap: () {
                Provider.of<ProviderProducts>(context, listen: false).showArchive(false);
                Navigator.of(context).pop();
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.archive),
              title: Text('Archived'),
              onTap: () {
                Provider.of<ProviderProducts>(context, listen: false).showArchive(true);
                Navigator.of(context).pop();
              },
            ),

          ],
        ),
      ),

      body: FutureBuilder(
        future: Provider.of<ProviderProducts>(context, listen: false).getNotes(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {

          return snapshot.connectionState == ConnectionState.waiting ?
              Center(child: CircularProgressIndicator(),)
            : Consumer<ProviderProducts>(
            child: Center(child: Text('No notes found')),
            builder: (ctx, notes, child) {

              return notes.items.length == 0 ?
              child :
                Padding(
                padding: EdgeInsets.all(8),
               child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4/3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    crossAxisCount: 1,
                  ),
                  itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(DetailScreen.routeName, arguments: notes.items[i].id);
                    },

                    child: MainScreenWidget(
                      id: notes.items[i].id,
                      title: notes.items[i].title,
                      description: notes.items[i].description,
                      date: notes.items[i].date,
                      archive: notes.items[i].archive,
                    ),
                  ),
                  itemCount: notes.items.length,
                ),
              );
            },

          );
        },
      ),
    );
  }
}

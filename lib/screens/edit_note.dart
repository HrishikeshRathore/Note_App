import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_notes/providers/provider_products.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class EditNote extends StatefulWidget {

  static const routeName = '/edit-page';

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  final _descriptionFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
      id: null,
      title: '',
      description: '',
      date: DateTime.now().toIso8601String(),
  );

  var _initValues = {
    'title': '',
    'description': '',
    'date': '',
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if(_isInit){
      final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId != null){
        _editedProduct = Provider.of<ProviderProducts>(context).findProduct(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'date': _editedProduct.date,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final _isValid = _form.currentState.validate();
    if(!_isValid){
      return;
    }
    _form.currentState.save();

    if(_editedProduct.id != null){
      Provider.of<ProviderProducts>(context, listen: false).updateNote(_editedProduct.id, _editedProduct);
    }
    else{
      Provider.of<ProviderProducts>(context, listen: false).addProduct(_editedProduct);
    }

   Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value){
                  if(value.isEmpty){
                    return 'Enter a Title';
                  }
                  return null;
                },
                onSaved: (value){
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: value,
                    description: _editedProduct.description,
                    date: _editedProduct.date,
                  );
                },
              ),

              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value){
                  if(value.isEmpty){
                    return 'Enter Description';
                  }
                  if(value.length < 10){
                    return 'Description added is insufficient';
                  }
                  return null;
                },
                onSaved: (value){
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: value,
                    date: _editedProduct.date,
                  );
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}

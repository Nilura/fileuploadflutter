import 'package:blogapp/checkout/widgets/allproducts.dart';

import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';

class HomePage1 extends StatelessWidget {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Personal Journal');
  final FocusNode _textFocusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController.dispose();
    //super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Container(
          decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _textEditingController,
            focusNode: _textFocusNode,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Search here',
                contentPadding: EdgeInsets.all(8)),
            onChanged: (value) {
             /* setState(() {
                foodListSearch = _itemsJson
                    .where(
                        (element) => element.contains(value.toLowerCase()))
                    .toList();
                if (_textEditingController.text.isNotEmpty &&
                    foodListSearch.length == 0) {
                  print('foodListSearch length ${foodListSearch.length}');
                }
              });*/
            },
          ),
        ),
        actions: <Widget>[

          IconButton(icon: Icon(Icons.shopping_cart, size: 30,), onPressed: ()=>Navigator.of(context).pushNamed(CartScreen.routeName))
        ],
      ),

      body:Allproduct()
    );
  }
}
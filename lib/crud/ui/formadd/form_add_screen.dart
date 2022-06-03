import 'package:blogapp/crud/api/api_service.dart';
import 'package:blogapp/crud/model/profile.dart';
import 'package:flutter/material.dart';


final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  Profile profile;

  FormAddScreen({this.profile});

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldNameValid;
  bool _isFieldEmailValid;
  bool _isFieldPriceValid;
  bool _isFieldQtyValid;
  bool _isFieldCatValid;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerdes = TextEditingController();
  TextEditingController _controllerprice = TextEditingController();
  TextEditingController _controllerqty = TextEditingController();
  TextEditingController _controllercategory = TextEditingController();

  @override
  void initState() {
    if (widget.profile != null) {
      _isFieldNameValid = true;
      _controllerName.text = widget.profile.itemname;
      _isFieldEmailValid = true;
      _controllerdes.text = widget.profile.description;
      _isFieldPriceValid = true;
      _controllerprice.text = widget.profile.toString();
      _isFieldQtyValid = true;
      _controllerqty.text = widget.profile.toString();
      _isFieldCatValid = true;
      _controllercategory.text = widget.profile.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.profile == null ? "Form Add" : "Change Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldName(),
                _buildTextFielddescription(),
                _buildTextFieldprice(),
                _buildTextFieldquantity(),
                _buildTextFieldcategory(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.profile == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldNameValid == null ||
                          _isFieldEmailValid == null ||
                          _isFieldPriceValid == null ||
                          !_isFieldNameValid ||
                          !_isFieldEmailValid ||
                          !_isFieldPriceValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String itemname = _controllerName.text.toString();
                      String description = _controllerdes.text.toString();
                      int price = int.parse(_controllerprice.text.toString());
                      int quantity = int.parse(_controllerqty.text.toString());
                      String category = _controllercategory.text.toString();
                      Profile profile =
                          Profile(itemname: itemname, description: description, price: price,quantity:quantity,category:category);
                      if (widget.profile == null) {
                        _apiService.createProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        profile.id = widget.profile.id;
                        _apiService.updateProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldName() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Item name",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFielddescription() {
    return TextField(
      controller: _controllerdes,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Description",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Email is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldprice() {
    return TextField(
      controller: _controllerprice,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Price",
        errorText: _isFieldPriceValid == null || _isFieldPriceValid
            ? null
            : "Age is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPriceValid) {
          setState(() => _isFieldPriceValid = isFieldValid);
        }
      },
    );
  }
  Widget _buildTextFieldquantity() {
    return TextField(
      controller: _controllerqty,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Quantity",
        errorText: _isFieldQtyValid == null || _isFieldQtyValid
            ? null
            : "Age is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldQtyValid) {
          setState(() => _isFieldQtyValid = isFieldValid);
        }
      },
    );
  }
  Widget _buildTextFieldcategory() {
    return TextField(
      controller: _controllercategory,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Category",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Field is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }
}

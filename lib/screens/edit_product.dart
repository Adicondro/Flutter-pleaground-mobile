import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pleaground_mobile/screens/homepage.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  final Map Product;

  EditProduct({required this.Product});
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  Future updateProduct() async {
    final response = await http.post(
        Uri.parse(
            "http://127.0.0.1:8000/api/products/" + Product['id'].toString()),
        body: {
          "name": _nameController.text,
          "description": _descriptionController.text,
          "price": _priceController.text,
          "image_url": _imageUrlController.text
        });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController..text = Product['name'],
              decoration: InputDecoration(labelText: "Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Product Name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController..text = Product['description'],
              decoration: InputDecoration(labelText: "Description"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Product Description";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController..text = Product['price'],
              decoration: InputDecoration(labelText: "Price"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Product Price";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageUrlController..text = Product['image_url'],
              decoration: InputDecoration(labelText: "Image URL"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Product Image URL";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateProduct().then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Produk Berhasil Di Ubah!"),
                      ));
                    });
                  }
                },
                child: Text("Update"))
          ],
        ),
      ),
    );
  }
}

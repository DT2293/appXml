import 'package:bookstore_app/classbook.dart';
import 'package:flutter/material.dart';

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Book'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author(s)'),
            ),
            TextField(
              controller: _yearController,
              decoration: InputDecoration(labelText: 'Year'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addBook();
              },
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }

  void _addBook() {
    final title = _titleController.text;
    final authors = _authorController.text.split(',').map((author) => author.trim()).toList();
    final year = _yearController.text;
    final price = double.parse(_priceController.text);

    if (title.isNotEmpty && authors.isNotEmpty && year.isNotEmpty && price > 0) {
      Navigator.pop(
        context,
        Book(title: title, authors: authors, year: year, price: price),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields correctly.')),
      );
    }
  }
}
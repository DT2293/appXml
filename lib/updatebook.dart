
import 'package:bookstore_app/classbook.dart';
import 'package:flutter/material.dart';

class UpdateBookScreen extends StatefulWidget {
  final Book book;

  UpdateBookScreen({required this.book});

  @override
  _UpdateBookScreenState createState() => _UpdateBookScreenState();
}

class _UpdateBookScreenState extends State<UpdateBookScreen> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _yearController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.authors.join(', '));
    _yearController = TextEditingController(text: widget.book.year);
    _priceController = TextEditingController(text: widget.book.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Book'),
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
                _updateBook();
              },
              child: Text('Update Book'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateBook() {
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
      // Hiển thị thông báo nếu người dùng không điền đầy đủ thông tin
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields correctly.')),
      );
    }
  }
}

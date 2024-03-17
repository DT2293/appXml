import 'dart:io'; // Thêm import này
import 'package:bookstore_app/addbook.dart';
import 'package:bookstore_app/classbook.dart';
import 'package:bookstore_app/updatebook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart' as xml;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookstore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: BookstorePage(),
    );
  }
}

class BookstorePage extends StatefulWidget {
  @override
  _BookstorePageState createState() => _BookstorePageState();
}

class _BookstorePageState extends State<BookstorePage> {
  late List<Book> books;

  @override
  void initState() {
    super.initState();
    loadXML();
  }

  Future<void> loadXML() async {
    try {
      final String data = await rootBundle.loadString('assets/bookstore.xml');
      final document = xml.XmlDocument.parse(data);
      final bookElements = document.findAllElements('book');
      setState(() {
        books = bookElements.map((element) => Book.fromXmlElement(element)).toList();
      });
    } catch (e) {
      print('Error loading XML: $e');
    }
  }

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Bookstore'),
    ),
    body: ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          elevation: 4, 
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
          child: ListTile(
            title: Text(book.title),
            subtitle: Text(
                'Authors: ${book.authors.join(', ')}\nYear: ${book.year}\nPrice: \$${book.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _UpdateBookScreen(context, book);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteBook(index);
                  },
                ),
              ],
            ),
          ),
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        _AddBookScreen(context);
      },
      child: Icon(Icons.add),
    ),
  );
}

  void _AddBookScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBookScreen()),
    );
    if (result != null) {
      setState(() {
        books.add(result);
      });
    }
  }

  void _UpdateBookScreen(BuildContext context, Book book) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateBookScreen(book: book)),
    );
    if (result != null) {
      setState(() {
        // Cập nhật thông tin sách trong danh sách
        final index = books.indexOf(book);
        if (index != -1) {
          books[index] = result;
        }
      });
    }
  }

  void deleteBook(int index) {
    setState(() {
      books.removeAt(index);
    });
  }
}

import 'package:xml/xml.dart' as xml;

class Book {
  final String title;
  final List<String> authors;
  final String year;
  final double price;

  Book({
    required this.title,
    required this.authors,
    required this.year,
    required this.price,
  });

  factory Book.fromXmlElement(xml.XmlElement element) {
    final title = element.findElements('title').single.text;
    final authors = element.findElements('author').map((node) => node.text).toList();
    final year = element.findElements('year').single.text;
    final price = double.parse(element.findElements('price').single.text);
    return Book(title: title, authors: authors, year: year, price: price);
  }
}

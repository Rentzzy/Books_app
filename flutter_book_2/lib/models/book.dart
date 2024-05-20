class Book {
  final String thumbnail;
  final String title;
  final String authors;
  final String description;
  final double rating;
  final int pageCount;
  final String language;

  Book({
    required this.thumbnail,
    required this.title,
    required this.authors,
    required this.description,
    required this.rating,
    required this.pageCount,
    required this.language,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      thumbnail: json['volumeInfo']['imageLinks'] != null
          ? json['volumeInfo']['imageLinks']['thumbnail']
          : 'https://via.placeholder.com/150',
      title: json['volumeInfo']['title'] ?? 'No title available',
      authors: json['volumeInfo']['authors'] != null
          ? (json['volumeInfo']['authors'] as List).join(', ')
          : 'No authors available',
      description:
          json['volumeInfo']['description'] ?? 'No description available',
      rating: json['volumeInfo']['averageRating'] != null
          ? json['volumeInfo']['averageRating'].toDouble()
          : 0.0,
      pageCount: json['volumeInfo']['pageCount'] ?? 0,
      language: json['volumeInfo']['language'] ?? 'N/A',
    );
  }
}


// Future<List<Book>> searchBooks(String query) async {
//   final api = GoogleBooksApi();
//   final response = await api.searchBooks(query);
//   final books = response.items?.map((item) => Book.fromJson(item)).toList();
//   return books ?? [];
// }



// class BookList {
//   String imageUrl;
//   String writers;
//   String title;

//   BookList(
//       {required this.imageUrl, required this.writers, required this.title});
// }

// List<BookList> bookLists = [
//   BookList(
//     imageUrl: 'assets/images/trending_book_1.png',
//     writers: 'Guy Kawasaki',
//     title: 'Enchantment',
//   ),
//   BookList(
//     imageUrl: 'assets/images/trending_book_2.png',
//     writers: 'Aaron Mahnke',
//     title: 'Lore',
//   ),
//   BookList(
//     imageUrl: 'assets/images/trending_book_3.png',
//     writers: 'Spencer Johnson, M.D',
//     title: 'Who Moved My Cheese',
//   ),
//   BookList(
//     imageUrl: 'assets/images/recentbook_1.png',
//     writers: 'Guy',
//     title: 'Ent',
//   ),
// ];

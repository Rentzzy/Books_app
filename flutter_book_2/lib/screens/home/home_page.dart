// lib/screens/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_book_2/API/api_service.dart';
import 'package:flutter_book_2/models/book.dart';
import 'package:flutter_book_2/screens/home/components/recent_book.dart';
import 'package:flutter_book_2/screens/home/components/trending_book.dart';
import 'package:flutter_book_2/screens/home/pages/search_page.dart';
import 'package:flutter_book_2/themes.dart';

class HomePage extends StatefulWidget {
  static const nameRoute = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  List<Book> _bookLists = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All Books',
    'Comic',
    'Novel',
    'Manga',
    'Fantasy',
    'Horor',
    'Darama',
  ];

  int _isSelected = 0;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Book> books;
      if (_isSelected == 0) {
        books = await _apiService.fetchBooks();
      } else {
        books =
            await _apiService.fetchBooksByCategory(_categories[_isSelected]);
      }
      setState(() {
        _bookLists = books;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  void _onSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(query: query),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/profile-pic.png'),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello Sarah,',
                  style: semiBoldText16,
                ),
                Text(
                  'Good Morning',
                  style: regularText14.copyWith(color: greyColor),
                ),
              ],
            ),
            const Spacer(),
            Image.asset(
              'assets/icons/icon-menu.png',
              width: 18,
            ),
          ],
        ),
      );
    }

    Widget searchField() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Find Your Favorite Book',
            hintStyle: mediumText12.copyWith(color: greyColor),
            fillColor: greyColorSearchField,
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(18),
            suffixIcon: InkWell(
              onTap: _onSearch,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Icon(
                  Icons.search_rounded,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget recentBook() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: const [
            RecentBook(
              image: 'assets/images/recentbook_1.png',
              title: 'The Magic',
            ),
            SizedBox(width: 20),
            RecentBook(
              image: 'assets/images/recentbook_2.png',
              title: 'The Martian',
            ),
          ],
        ),
      );
    }

    Widget categories(int index) {
      return InkWell(
        onTap: () {
          setState(() {
            _isSelected = index;
          });
          _fetchBooks();
        },
        child: Container(
          margin: const EdgeInsets.only(top: 30, right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: _isSelected == index ? greenColor : transParentColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            _categories[index],
            style: semiBoldText14.copyWith(
                color: _isSelected == index ? whiteColor : greyColor),
          ),
        ),
      );
    }

    Widget listCategories() {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _categories
              .asMap()
              .entries
              .map((MapEntry map) => categories(map.key))
              .toList(),
        ),
      );
    }

    Widget trendingBookGrid() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : TrendingBooksGrid(
                  books: _bookLists,
                ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                const SizedBox(height: 30),
                searchField(),
                // const SizedBox(height: 30),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 30),
                //   child: Text(
                //     'Recent Book',
                //     style: semiBoldText16.copyWith(color: blackColor),
                //   ),
                // ),
                // const SizedBox(height: 12),
                // recentBook(),
              ],
            ),
          ),
          listCategories(),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30),
            child: Text(
              'Trending Now',
              style: semiBoldText16.copyWith(color: blackColor),
            ),
          ),
          trendingBookGrid(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:book_store/pages/booking_order/tab_cart.dart';
import 'package:book_store/pages/home/tab_home.dart';
import 'package:book_store/pages/wishlist/tab_wishlist.dart';
import 'package:book_store/utils/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentIndexPage = 0;

  //Page List in bottom Navigation
  final List<Widget> _contentPage = [
    const TabHomePage(),
    const TabCartPage(),
    const WishlistPage(),
    // TabTransactionHistoryPage(),
    // TabProfilePAge(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_handelTabSelection);
  }

  void _handelTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _contentPage.map((Widget content) => content).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle:
            TextStyle(fontSize: 10, color: AppConstants.primaryColor),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndexPage,
        onTap: (value) {
          _currentIndexPage = value;
          _pageController.jumpToPage(value);
          FocusScope.of(context).unfocus();
        },
        selectedFontSize: 10,
        unselectedFontSize: 8,
        iconSize: 20,
        items: [
          BottomNavigationBarItem(
            backgroundColor: AppConstants.borderColor,
            icon: Icon(
              Icons.home,
              color: _currentIndexPage == 0
                  ? AppConstants.primaryColor
                  : AppConstants.headingColor,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: _currentIndexPage == 1
                  ? AppConstants.primaryColor
                  : AppConstants.headingColor,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            backgroundColor: AppConstants.borderColor,
            icon: Icon(
              Icons.favorite_border,
              color: _currentIndexPage == 2
                  ? AppConstants.primaryColor
                  : AppConstants.headingColor,
            ),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt_long_sharp,
              color: _currentIndexPage == 3
                  ? AppConstants.primaryColor
                  : AppConstants.headingColor,
            ),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndexPage == 4
                  ? AppConstants.primaryColor
                  : AppConstants.headingColor,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

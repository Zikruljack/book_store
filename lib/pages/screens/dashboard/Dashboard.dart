import 'dart:async';

import 'package:book_store/pages/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:book_store/pages/screens/home/homescreen.dart';
import 'package:book_store/util/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DashBoardScreen extends StatefulWidget {
  final int pageIndex;
  const DashBoardScreen({super.key, required this.pageIndex});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  late bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      const HomeScreen(),
      // WishListScreen(),
      // CartScreen(),
      // OrderScreen(),
      // ProfileScreen(),
    ];

    Future.delayed(const Duration(seconds: 2), () {});

    if (GetPlatform.isMobile) {
      Connectivity().checkConnectivity();
    }
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (_canExit) {
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr,
                  style: const TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
              margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            ));
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      }),
      child: Scaffold(
        key: _scaffoldKey,
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) => _screens[index]),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 5,
          notchMargin: 5,
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Row(
              children: [
                BottomNavItem(
                  iconData: Icons.home,
                  onTap: () => _setPage(0),
                  isSelected: _pageIndex == 0,
                ),
                BottomNavItem(
                  iconData: Icons.favorite,
                  onTap: () => _setPage(1),
                  isSelected: _pageIndex == 1,
                ),
                BottomNavItem(
                  iconData: Icons.shopping_cart,
                  onTap: () => _setPage(2),
                  isSelected: _pageIndex == 2,
                ),
                BottomNavItem(
                  iconData: Icons.receipt_long_outlined,
                  onTap: () => _setPage(3),
                  isSelected: _pageIndex == 3,
                ),
                BottomNavItem(
                  iconData: Icons.person_outline_sharp,
                  onTap: () => _setPage(4),
                  isSelected: _pageIndex == 4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

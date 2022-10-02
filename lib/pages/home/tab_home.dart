import 'package:book_store/pages/detail_product/detail_product.dart';
import 'package:book_store/pages/product_category/product_category.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:book_store/data/models/banner_model.dart';
import 'package:book_store/data/models/category_model.dart';
import 'package:book_store/data/models/recomended_product_model.dart';
import 'package:book_store/pages/components/reusable_widget.dart';
import 'package:book_store/utils/cache_image_network.dart';
import 'package:book_store/utils/const.dart';
import 'package:book_store/utils/global_function.dart';

class TabHomePage extends StatefulWidget {
  const TabHomePage({super.key});

  @override
  State<TabHomePage> createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _globalFunction = GlobalFunction();
  final _reusableWidget = ReusableWidget();

  int _currentImageSlider = 0;

  Color _topIconColor = Colors.white;
  late ScrollController _scrollController;
  late AnimationController _topColorAnimationController;
  late Animation _appBarColor;
  late SystemUiOverlayStyle _appBarSystemOverlayStyle =
      SystemUiOverlayStyle.light;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    _setupAnimateAppbar();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _topColorAnimationController.dispose();
    super.dispose();
  }

  void _setupAnimateAppbar() {
    _topColorAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    _appBarColor =
        ColorTween(begin: Colors.white, end: AppConstants.primaryColor)
            .animate(_topColorAnimationController);
    _scrollController = ScrollController()
      ..addListener(() {
        _topColorAnimationController.animateTo(_scrollController.offset / 120);
        // if scroll for above 150, then change app bar color to white, search button to dark, and top icon color to dark
        // if scroll for below 150, then change app bar color to transparent, search button to white and top icon color to light
        if (_scrollController.hasClients &&
            _scrollController.offset > (150 - kToolbarHeight)) {
          if (_topIconColor != AppConstants.backgroundColor) {
            _topIconColor = AppConstants.backgroundColor;
            _appBarSystemOverlayStyle = SystemUiOverlayStyle.dark;
          }
        } else {
          if (_topIconColor != Colors.white) {
            _topIconColor = Colors.white;
            _appBarSystemOverlayStyle = SystemUiOverlayStyle.light;
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);
    // final double categoryForYouHeightShort = boxImageSize;
    // final double categoryForYouWidthLong = (boxImageSize * 2);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 16),
                      child: const Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _gridCategory(),
                    const Divider(
                      thickness: 1.5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 30, left: 16, right: 16),
                      child: const Text(
                        'Recomended Product',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CustomScrollView(
                      shrinkWrap: true,
                      primary: false,
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.625,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return _recomendedProductCard(index);
                              },
                              childCount: recomendedProductData.length,
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
                )
              ],
            ),
            SizedBox(
              height: 60,
              child: AnimatedBuilder(
                animation: _topColorAnimationController,
                child: const Padding(
                  padding: EdgeInsets.only(left: 50),
                ),
                builder: (context, child) => AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: _appBarColor.value,
                  systemOverlayStyle: _appBarSystemOverlayStyle,
                  elevation: 0,
                  title: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) =>
                              AppConstants.backgroundColor,
                        ),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SearchPage()));
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          Icon(
                            Icons.search,
                            color: Colors.grey[500],
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Search Product',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      )),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ChatUsPage()));
                      },
                      child: Container(
                        // margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.only(right: 10),
                        child: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://via.placeholder.com/150.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createHomeBannerSlider() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          CarouselSlider(
            items: homeBannerData
                .map((item) => Container(
                      child: buildCacheNetworkImage(
                          width: 10, height: 10, url: item.image),
                    ))
                .toList(),
            options: CarouselOptions(
                aspectRatio: 4 / 3,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 6),
                autoPlayAnimationDuration: const Duration(milliseconds: 300),
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageSlider = index;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: homeBannerData.map((item) {
              int index = homeBannerData.indexOf(item);
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageSlider == index
                      ? AppConstants.primaryColor
                      : Colors.grey[300],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _gridCategory() {
    return GridView.count(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      primary: false,
      childAspectRatio: 1.1,
      shrinkWrap: true,
      crossAxisSpacing: 0,
      crossAxisCount: 4,
      mainAxisSpacing: 0,
      children: List.generate(categoryData.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductCategoryPage(
                  categoryId: categoryData[index].id,
                  categoryName: categoryData[index].name,
                ),
              ),
            );
          },
          child: Column(
            children: [
              buildCacheNetworkImage(
                url: categoryData[index].image,
                width: 60,
                height: 60,
                // color: Colors.transparent,
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    categoryData[index].name,
                    style: TextStyle(
                      color: AppConstants.headingColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _recomendedProductCard(index) {
    final double boxImageSize =
        ((MediaQuery.of(context).size.width) - 24) / 2 - 12;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      color: AppConstants.backgroundColor,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                      name: recomendedProductData[index].name,
                      image: recomendedProductData[index].image,
                      price: recomendedProductData[index].price,
                      rating: recomendedProductData[index].rating,
                      review: recomendedProductData[index].review,
                      sale: recomendedProductData[index].sale)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: buildCacheNetworkImage(
                  width: boxImageSize,
                  height: boxImageSize,
                  url: recomendedProductData[index].image),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recomendedProductData[index].name,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppConstants.headingColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Rp ${_globalFunction.removeDecimalZeroFormat(recomendedProductData[index].price)}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          '${recomendedProductData[index].sale} Sale',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppConstants.backgroundColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        _reusableWidget.createRatingBar(
                            rating: recomendedProductData[index].rating,
                            size: 12),
                        Text('(${recomendedProductData[index].review})',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppConstants.headingColor,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:book_store/pages/components/reusable_widget.dart';
import 'package:book_store/utils/const.dart';
import 'package:book_store/utils/global_function.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/cache_image_network.dart';

class ProductDetailPage extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  final double rating;
  final int review;
  final int sale;

  const ProductDetailPage(
      {Key? key,
      this.name = '',
      this.image = '',
      this.price = 24,
      this.rating = 4,
      this.review = 45,
      this.sale = 63})
      : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // initialize global function and reusable widget
  final _globalFunction = GlobalFunction();
  final _reusableWidget = ReusableWidget();

  final List<String> _imgProductSlider = [];
  int _currentImageSlider = 0;

  // size data
  final List<String> _sizeList = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  int _sizeIndex = 0;

  // color data
  final List<String> _colorList = [
    'Red',
    'Black',
    'Green',
    'White',
    'Blue',
    'Yellow',
    'Pink'
  ];
  int _colorIndex = 0;

  // wishlist
  bool _isLove = false;

  // shopping cart count
  int _shoppingCartCount = 3;

  @override
  void initState() {
    // image slider for the product
    _imgProductSlider.add(widget.image);
    _imgProductSlider.add(widget.image);
    _imgProductSlider.add(widget.image);
    _imgProductSlider.add(widget.image);
    _imgProductSlider.add(widget.image);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppConstants.headingColor,
          ),
          elevation: 0,
          titleSpacing: 0.0,
          // create search text field in the app bar
          title: Container(
            margin: const EdgeInsets.only(right: 16),
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) => Colors.grey[100]!,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
                ),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SearchPage()));
                },
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Icon(Icons.search, color: Colors.grey[500], size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Search Product',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal),
                    )
                  ],
                )),
          ),
          backgroundColor: AppConstants.primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [
            IconButton(
                padding: const EdgeInsets.all(0),
                constraints: const BoxConstraints(),
                icon: _customShoppingCart(_shoppingCartCount),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => TabShoppingCartPage()));
                }),
            IconButton(
                icon: _reusableWidget.customNotifIcon(
                    count: 8, notifColor: AppConstants.bodyColor),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => NotificationPage()));
                }),
          ],
          bottom: _reusableWidget.bottomAppBar(),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(true);
          },
          child: Column(
            children: [
              Flexible(
                child: ListView(
                  children: [
                    _createProductSlider(),
                    _createProductPriceTitleEtc(),
                    _createProductVariant(),
                    _createDeliveryEstimated(),
                    _createProductInformation(),
                    _createProductDescription(),
                    // _createProductReview(),
                    const SizedBox(height: 16)
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ChatUsPage()));
                        },
                        child: ClipOval(
                          child: Container(
                              color: AppConstants.primaryColor,
                              padding: const EdgeInsets.all(9),
                              child: const Icon(Icons.chat,
                                  color: Colors.white, size: 16)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _shoppingCartCount++;
                          });
                          Fluttertoast.showToast(
                              msg: 'Item has been added to Shopping Cart',
                              toastLength: Toast.LENGTH_LONG);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 1, color: AppConstants.primaryColor),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      10) //         <--- border radius here
                                  )),
                          child: Text('Add to Shopping Cart',
                              style: TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _customShoppingCart(int count) {
    return Stack(
      children: <Widget>[
        Icon(Icons.shopping_cart, color: AppConstants.bodyColor),
        Positioned(
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(
              minWidth: 14,
              minHeight: 14,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _createProductSlider() {
    return Stack(
      children: [
        CarouselSlider(
          items: _imgProductSlider
              .map((item) => Container(
                    child:
                        buildCacheNetworkImage(width: 0, height: 0, url: item),
                  ))
              .toList(),
          options: CarouselOptions(
              aspectRatio: 1,
              viewportFraction: 1.0,
              autoPlay: false,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageSlider = index;
                });
              }),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            decoration: BoxDecoration(
                color: AppConstants.primaryColor,
                borderRadius: BorderRadius.circular(4)),
            child: Text(
                '${_currentImageSlider + 1}/${_imgProductSlider.length}',
                style: const TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ),
      ],
    );
  }

  Widget _createProductPriceTitleEtc() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('\$${_globalFunction.removeDecimalZeroFormat(widget.price)}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.headingColor,
                  )),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isLove == true) {
                      _isLove = false;
                      Fluttertoast.showToast(
                          msg: 'Item has been deleted from your wishlist',
                          toastLength: Toast.LENGTH_LONG);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Item has been added to your wishlist',
                          toastLength: Toast.LENGTH_LONG);
                      _isLove = true;
                    }
                  });
                },
                child: Icon(Icons.favorite,
                    color: _isLove == true
                        ? AppConstants.primaryColor
                        : AppConstants.headingColor,
                    size: 28),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(widget.name,
              style: const TextStyle(
                fontSize: 14,
              )),
          const SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ProductReviewPage()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[700], size: 18),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(widget.rating.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(
                        width: 3,
                      ),
                      Text('(${widget.review})',
                          style: TextStyle(
                              fontSize: 13, color: AppConstants.bodyColor)),
                    ],
                  ),
                ),
                VerticalDivider(
                  width: 30,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                Text('${widget.sale} Sale',
                    style:
                        TextStyle(fontSize: 13, color: AppConstants.bodyColor)),
                VerticalDivider(
                  width: 30,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                Icon(Icons.location_on,
                    color: AppConstants.backgroundColor, size: 16),
                Text('Brooklyn',
                    style: TextStyle(
                        fontSize: 13, color: AppConstants.backgroundColor))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createProductVariant() {
    return Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Variant',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.headingColor,
                )),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text('Size : ',
                    style:
                        TextStyle(color: AppConstants.bodyColor, fontSize: 14)),
                Text(_sizeList[_sizeIndex],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Wrap(
              children: List.generate(_sizeList.length, (index) {
                return radioSize(_sizeList[index], index);
              }),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text('Color : ',
                    style:
                        TextStyle(color: AppConstants.bodyColor, fontSize: 14)),
                Text(_colorList[_colorIndex],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Wrap(
              children: List.generate(_colorList.length, (index) {
                return radioColor(_colorList[index], index);
              }),
            ),
          ],
        ));
  }

  Widget radioSize(String txt, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sizeIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: const EdgeInsets.only(right: 8, top: 8),
        decoration: BoxDecoration(
            color:
                _sizeIndex == index ? AppConstants.primaryColor : Colors.white,
            border: Border.all(
                width: 1,
                color: _sizeIndex == index
                    ? AppConstants.primaryColor
                    : Colors.grey[300]!),
            borderRadius: const BorderRadius.all(
                Radius.circular(10) //         <--- border radius here
                )),
        child: Text(txt,
            style: TextStyle(
                color: _sizeIndex == index
                    ? Colors.white
                    : AppConstants.headingColor)),
      ),
    );
  }

  Widget radioColor(String txt, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _colorIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: const EdgeInsets.only(right: 8, top: 8),
        decoration: BoxDecoration(
            color:
                _colorIndex == index ? AppConstants.primaryColor : Colors.white,
            border: Border.all(
                width: 1,
                color: _colorIndex == index
                    ? AppConstants.primaryColor
                    : Colors.grey[300]!),
            borderRadius: const BorderRadius.all(
                Radius.circular(10) //         <--- border radius here
                )),
        child: Text(txt,
            style: TextStyle(
                color: _colorIndex == index
                    ? Colors.white
                    : AppConstants.headingColor)),
      ),
    );
  }

  Widget _createDeliveryEstimated() {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => DeliveryEstimatedPage()));
      },
      child: Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delivery',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.headingColor)),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: TextStyle(
                          fontSize: 15.5,
                          color: AppConstants.bodyColor,
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  'Calculate the estimated cost for shipping goods to '),
                          TextSpan(
                              text: 'West New York, NJ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  size: 36, color: AppConstants.headingColor)
            ],
          )),
    );
  }

  Widget _createProductInformation() {
    return Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Information',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.headingColor)),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Weight',
                    style: TextStyle(color: AppConstants.headingColor)),
                Text('300 Gram',
                    style: TextStyle(color: AppConstants.headingColor))
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Condition',
                    style: TextStyle(color: AppConstants.headingColor)),
                Text('Second',
                    style: TextStyle(color: AppConstants.headingColor))
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category',
                    style: TextStyle(color: AppConstants.headingColor)),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ProductCategoryPage(
                    //             categoryId: 3, categoryName: 'Electronic')));
                  },
                  child: Text('Electronic',
                      style: TextStyle(color: AppConstants.headingColor)),
                )
              ],
            ),
          ],
        ));
  }

  Widget _createProductDescription() {
    return Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 16,
            ),
            const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\nQuisque tortor tortor, ultrices id scelerisque a, elementum id elit. Maecenas feugiat tellus sed augue malesuada, id tempus ex sodales.'),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ProductDescriptionPage(
                //             name: widget.name, image: widget.image)));
              },
              child: Center(
                child: Text('Read More',
                    style: TextStyle(color: AppConstants.primaryColor)),
              ),
            ),
          ],
        ));
  }

  // Widget _createProductReview() {
  //   return Container(
  //       margin: const EdgeInsets.only(top: 12),
  //       padding: const EdgeInsets.all(16),
  //       color: Colors.white,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const Text('Review',
  //                   style:
  //                       TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //               GestureDetector(
  //                 onTap: () {
  //                   // Navigator.push(
  //                   //     context,
  //                   //     MaterialPageRoute(
  //                   //         builder: (context) => ProductReviewPage()));
  //                 },
  //                 child: const Text('View All',
  //                     style:
  //                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                     textAlign: TextAlign.end),
  //               )
  //             ],
  //           ),
  //           const SizedBox(
  //             height: 8,
  //           ),
  //           Row(
  //             children: [
  //               _reusableWidget.createRatingBar(
  //                   rating: widget.rating, size: 12),
  //               Text('(${widget.review})',
  //                   style: TextStyle(
  //                       fontSize: 11, color: AppConstants.headingColor))
  //             ],
  //           ),
  //           Column(
  //               children: List.generate(reviewData.length, (index) {
  //             return Column(
  //               children: [
  //                 Divider(
  //                   height: 32,
  //                   color: Colors.grey[400],
  //                 ),
  //                 Container(
  //                     child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(reviewData[index].date,
  //                         style: TextStyle(
  //                             fontSize: 13, color: AppConstants.bodyColor)),
  //                     const SizedBox(height: 4),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(reviewData[index].name,
  //                             style: const TextStyle(
  //                                 fontSize: 14, fontWeight: FontWeight.bold)),
  //                         _reusableWidget.createRatingBar(
  //                             rating: reviewData[index].rating, size: 12),
  //                       ],
  //                     ),
  //                     const SizedBox(height: 4),
  //                     Text(reviewData[index].review)
  //                   ],
  //                 ))
  //               ],
  //             );
  //           })),
  //         ],
  //       ));
  // }
}

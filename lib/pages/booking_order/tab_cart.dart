import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:book_store/pages/components/reusable_widget.dart';
import 'package:book_store/utils/const.dart';
import 'package:book_store/utils/global_function.dart';

import '../../data/models/cart_model.dart';
import '../../utils/cache_image_network.dart';

class TabCartPage extends StatefulWidget {
  const TabCartPage({super.key});

  @override
  State<TabCartPage> createState() => _TabCartPageState();
}

class _TabCartPageState extends State<TabCartPage> {
  final _globalFunction = GlobalFunction();
  final _reusableWidget = ReusableWidget();

  double _totalPrice = 0;

  @override
  void initState() {
    // TODO: implement initState
    _countTotalPrice();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _countTotalPrice() {
    _totalPrice = 0;
    for (int i = 0; i < shoppingCartData.length; i++) {
      _totalPrice += shoppingCartData[i].price * shoppingCartData[i].qty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 5);
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: AppConstants.headingColor,
        ),
        elevation: 0,
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            fontSize: 18,
            color: AppConstants.headingColor,
          ),
        ),
        backgroundColor: AppConstants.primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // bottom: _reusableWidget.bottomAppBar(),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: List.generate(shoppingCartData.length, (index) {
                return _buildItem(index, boxImageSize);
              }),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                // _createUseCoupon(),
                _createTotalPrice(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _createTotalPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text('\$${_globalFunction.removeDecimalZeroFormat(_totalPrice)}',
                style: TextStyle(
                  fontSize: 16,
                  color: AppConstants.headingColor,
                )),
          ],
        ),
        TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) => AppConstants.primaryColor,
              ),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              )),
            ),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             DeliveryPage(shoppingCartData: shoppingCartData)));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Next',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ))
      ],
    );
  }

  Column _buildItem(index, boxImageSize) {
    int quantity = shoppingCartData[index].qty;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ProductDetailPage(
                //             name: shoppingCartData[index].name,
                //             image: shoppingCartData[index].image,
                //             price: shoppingCartData[index].price,
                //             rating: 4,
                //             review: 23,
                //             sale: 36)));
              },
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: buildCacheNetworkImage(
                      width: boxImageSize,
                      height: boxImageSize,
                      url: shoppingCartData[index].image)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => ProductDetailPage(
                      //               name: shoppingCartData[index].name,
                      //               image: shoppingCartData[index].image,
                      //               price: shoppingCartData[index].price,
                      //               rating: 4,
                      //               review: 23,
                      //               sale: 36)));
                    },
                    child: Text(
                      shoppingCartData[index].name,
                      style: TextStyle(
                          fontSize: 14, color: AppConstants.bodyColor),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                        '\$ ${_globalFunction.removeDecimalZeroFormat(shoppingCartData[index].price)}',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showPopupDelete(index, boxImageSize);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: Colors.grey[300]!)),
                            child: Icon(Icons.delete,
                                color: AppConstants.backgroundColor, size: 20),
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                setState(() {
                                  quantity--;
                                  shoppingCartData[index].setQty(quantity);
                                  _countTotalPrice();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                height: 28,
                                decoration: BoxDecoration(
                                    color: AppConstants.primaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(Icons.remove,
                                    color: Colors.white, size: 20),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(quantity.toString(), style: const TextStyle()),
                            const SizedBox(width: 10),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                setState(() {
                                  quantity++;
                                  shoppingCartData[index].setQty(quantity);
                                  _countTotalPrice();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                height: 28,
                                decoration: BoxDecoration(
                                    color: AppConstants.primaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(Icons.add,
                                    color: Colors.white, size: 20),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        (index == shoppingCartData.length - 1)
            ? Wrap()
            : Divider(
                height: 32,
                color: Colors.grey[400],
              )
      ],
    );
  }

  void showPopupDelete(index, boxImageSize) {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('No', style: TextStyle(color: AppConstants.primaryColor)));
    Widget continueButton = TextButton(
        onPressed: () {
          setState(() {
            shoppingCartData.removeAt(index);
          });
          _countTotalPrice();
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: 'Item has been deleted from your Shopping Cart',
              toastLength: Toast.LENGTH_LONG);
        },
        child: Text('Yes', style: TextStyle(color: AppConstants.primaryColor)));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'Delete from Shopping Cart',
        style: TextStyle(fontSize: 18),
      ),
      content: Text(
          'Are you sure to delete this item from your Shopping Cart ?',
          style: TextStyle(fontSize: 13, color: AppConstants.headingColor)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

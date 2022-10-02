import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:book_store/data/models/wishlist_model.dart';
import 'package:book_store/utils/cache_image_network.dart';
import 'package:book_store/utils/const.dart';

import '../../utils/global_function.dart';
import '../components/reusable_widget.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage>
    with AutomaticKeepAliveClientMixin {
  // initialize global function and reusable widget
  final _globalFunction = GlobalFunction();
  final _reusableWidget = ReusableWidget();

  // _listKey is used for AnimatedList
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  TextEditingController _etSearch = TextEditingController();

  WishlistModel wishlistModel = [] as WishlistModel;

  // keep the state to do not refresh when switch navbar
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _etSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if we used AutomaticKeepAliveClientMixin, we must call super.build(context);
    super.build(context);
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'Wishlist',
            style: TextStyle(fontSize: 18, color: AppConstants.headingColor),
          ),
          backgroundColor: AppConstants.backgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,

          // create search text field in the app bar
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey[100]!,
                  width: 1.0,
                )),
              ),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              height: kToolbarHeight,
              child: TextFormField(
                controller: _etSearch,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 1,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                onChanged: (textValue) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: 'Search Wishlist',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  suffixIcon: (_etSearch.text == '')
                      ? null
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _etSearch = TextEditingController(text: '');
                            });
                          },
                          child: Icon(Icons.close, color: Colors.grey[500])),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.grey[200]!)),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: AnimatedList(
          key: _listKey,
          initialItemCount: wishlistModel.toMap().length,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index, animation) {
            return _buildWishlistCard(
                wishlistModel.toMap()[index], boxImageSize, animation, index);
          },
        ));
  }

  Widget _buildWishlistCard(
      WishlistModel wishlistData, boxImageSize, animation, index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Colors.white,
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ProductDetailPage(
                    //             name: wishlistData.name,
                    //             image: wishlistData.image,
                    //             price: wishlistData.price,
                    //             rating: wishlistData.rating,
                    //             review: wishlistData.review,
                    //             sale: wishlistData.sale)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: buildCacheNetworkImage(
                              width: boxImageSize,
                              height: boxImageSize,
                              url: wishlistData.image)),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wishlistData.name,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppConstants.headingColor),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                  '\$ ${_globalFunction.removeDecimalZeroFormat(wishlistData.price)}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                '${wishlistData.sale} Sale',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppConstants.backgroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          showPopupDeleteTabWishlist(index, boxImageSize);
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1, color: Colors.grey[300]!)),
                          child: Icon(
                            Icons.delete,
                            color: AppConstants.headingColor,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: (wishlistData.stock == 0)
                            ? TextButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(0, 30)),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) =>
                                        Colors.grey[300]!,
                                  ),
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  )),
                                ),
                                onPressed: null,
                                child: Text(
                                  'Out of Stock',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                  textAlign: TextAlign.center,
                                ))
                            : OutlinedButton(
                                onPressed: () {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Item has been added to Shopping Cart');
                                },
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(0, 30)),
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    )),
                                    side: MaterialStateProperty.all(
                                      BorderSide(
                                          color: AppConstants.primaryColor,
                                          width: 1.0),
                                    )),
                                child: Text(
                                  'Add to Shopping Cart',
                                  style: TextStyle(
                                      color: AppConstants.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                  textAlign: TextAlign.center,
                                )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showPopupDeleteTabWishlist(index, boxImageSize) {
    // set up the buttons
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'No',
        style: TextStyle(
          color: AppConstants.primaryColor.withOpacity(50),
        ),
      ),
    );
    Widget continueButton = TextButton(
      onPressed: () {
        int removeIndex = index;
        // var removedItem = wishlistData.removeAt(removeIndex);
        var removedItem = wishlistModel.toMap().remove(removeIndex);
        // This builder is just so that the animation has something
        // to work with before it disappears from view since the original
        // has already been deleted.
        builder(context, animation) {
          // A method to build the Card widget.
          return _buildWishlistCard(
              removedItem, boxImageSize, animation, removeIndex);
        }

        _listKey.currentState!.removeItem(removeIndex, builder);

        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: 'Item has been deleted from your wishlist',
            toastLength: Toast.LENGTH_LONG);
      },
      child: Text(
        'Yes',
        style: TextStyle(
          color: AppConstants.primaryColor.withOpacity(50),
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'Delete Wishlist',
        style: TextStyle(fontSize: 18),
      ),
      content: Text(
        'Are you sure to delete this item from your Wishlist ?',
        style: TextStyle(
          fontSize: 13,
          color: AppConstants.primaryColor.withOpacity(50),
        ),
      ),
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

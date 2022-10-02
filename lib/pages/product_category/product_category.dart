import 'package:book_store/data/models/category_all_product.dart';
import 'package:book_store/pages/detail_product/detail_product.dart';
import 'package:book_store/utils/cache_image_network.dart';
import 'package:book_store/utils/const.dart';
import 'package:book_store/utils/global_function.dart';
import 'package:flutter/material.dart';

class ProductCategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final String? categoryImage;

  const ProductCategoryPage({
    super.key,
    this.categoryId = 0,
    required this.categoryName,
    this.categoryImage,
  });

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  final _globalFunction = GlobalFunction();

  List<CategoryAllProductModel> categoryAllProductData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(true);
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              // Container(
              //   margin: const EdgeInsets.all(20),
              //   child: const Text(
              //     'New Product',
              //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Container(
              //   margin: const EdgeInsets.only(top: 8),
              //   height: MediaQuery.of(context).size.width / 3 * 1.90,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.only(left: 12, right: 12),
              //     // itemCount: categoryNewProduct.length, //TODO: add Data
              //     itemBuilder: ((context, index) {
              //       return Container(); //TODO: add list View recenly Publish
              //     }),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: const Text(
                  'All Product',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 0.5),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _allProductCard(index);
                        },
                        childCount: categoryAllProductData.length,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: AppConstants.primaryColor,
      ),
    );
  }

  Widget _allProductCard(index) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 3) + 10,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: AppConstants.backgroundColor,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                    name: categoryAllProductData[index].name,
                    image: categoryAllProductData[index].image,
                    price: categoryAllProductData[index].price,
                    review: categoryAllProductData[index].review,
                    sale: categoryAllProductData[index].sale),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: buildCacheNetworkImage(
                    width: (MediaQuery.of(context).size.width / 3) + 10,
                    height: (MediaQuery.of(context).size.height / 3) + 10,
                    url: categoryAllProductData[index].image,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    'RP${_globalFunction.removeDecimalZeroFormat(
                      categoryAllProductData[index].price,
                    )}',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Text('(${categoryAllProductData[index].review})',
                          style: TextStyle(
                              fontSize: 11, color: AppConstants.headingColor))
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
}

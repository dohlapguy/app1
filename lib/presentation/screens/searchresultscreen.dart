import 'package:app1/constants/app_colors.dart';
import 'package:app1/data/models/productmodel.dart';
import 'package:app1/presentation/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key, required this.searchString});
  final String searchString;

  @override
  State<SearchResultScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            getSliverAppBarSearch(context, searchString: widget.searchString),
            SliverAppBar(
              backgroundColor: AppColors.canvasColor,
              snap: true,
              floating: true,
              actions: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        child: Text(
                          'Filter',
                          style: TextStyle(
                              fontSize: 16.sp, color: AppColors.black),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(
                    right: 14.w, left: 14.w, bottom: 10.h, top: 10.h),
                child: Text(
                  'Showing results for "${widget.searchString}"',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return ProductTile(
                  product: ProductModel(
                      shopName: 'hello',
                      id: '1',
                      title: 'hello',
                      description: '123',
                      price: 150.0,
                      discountPercentage: 0,
                      rating: 1.0,
                      stock: 2,
                      brand: 'hello',
                      category: '1',
                      thumbnail:
                          'https://images.unsplash.com/photo-1518390643573-66f352c5492e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80',
                      images: [''],
                      shopId: '1'));
            }, childCount: 20))
          ],
        ),
      ),
    );
  }
}

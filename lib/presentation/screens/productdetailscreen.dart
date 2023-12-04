import '../../presentation/blocs/product_detail_bloc/product_detail_bloc.dart';
import '../../constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

import '../widgets.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productId});
  final String productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<ProductDetailBloc>()
        .add(FetchProductById(productId: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case ProductDetailLoaded:
                  state as ProductDetailLoaded;
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                          child: ImageCarousel(
                              height: 400, images: state.product.images)),
                      const SliverGap(12),
                      const SliverToBoxAdapter(
                        child: Divider(
                          thickness: 1.6,
                        ),
                      ),
                      SliverToBoxAdapter(
                          child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loreal",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Gap(5),
                            Text(
                              state.product.title,
                              style: const TextStyle(),
                            ),
                            const Gap(2),
                            Text(
                              state.product.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.lightBlack),
                            ),
                          ],
                        ),
                      )),

                      //* Size Widget
                      const SliverToBoxAdapter(
                        child: SizePickerWidget(),
                      ),

                      const SliverGap(10),

                      SliverToBoxAdapter(
                          child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹${state.product.price.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            const Gap(5),
                            Wrap(
                              children: [
                                Text(
                                  "M.R.P:",
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: AppColors.lightBlack),
                                ),
                                Text(
                                  "₹400",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: AppColors.lightBlack,
                                          color: AppColors.lightBlack),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const Gap(10),
                            state.product.stock != 0
                                ? const Text(
                                    'In Stock',
                                    style:
                                        TextStyle(color: AppColors.darkGreen),
                                  )
                                : const Text(
                                    'Currently out of Stock',
                                    style: TextStyle(color: AppColors.red),
                                  ),
                          ],
                        ),
                      )),

                      const SliverGap(10),

                      SliverToBoxAdapter(
                          child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Description',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Gap(5),
                            ReadMoreText(
                              'Incididunt mollit exercitation ad do ex fugiat qui excepteur fugiat. Fugiat pariatur id nisi ad eu excepteur ut. Ex nulla sint nulla et magna. Exercitation commodo Lorem aute incididunt officia et nisi incididunt quis aliqua culpa labore. Elit cillum pariatur Lorem proident pariatur aute et id exercitation est. Pariatur nulla aute enim aliqua in laboris voluptate. Duis Lorem tempor officia elit velit est. Eiusmod nostrud excepteur sit duis eiusmod eu laborum ullamco.',
                              trimLines: 3,
                              trimMode: TrimMode.Line,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.lightBlack),
                            ),
                          ],
                        ),
                      )),

                      const SliverGap(50),

                      SliverToBoxAdapter(
                        child: Container(
                          height: 400,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(color: AppColors.lightGrey),
                                  bottom:
                                      BorderSide(color: AppColors.lightGrey))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "You may also like",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              const Gap(10),
                              SizedBox(
                                height: 340,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width: 130,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: 140,
                                                      width: 130,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: AppColors
                                                                  .grey),
                                                    ),
                                                    getBestsellerText(
                                                      topLeftRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                const Gap(5),
                                                SizedBox(
                                                  height: 35,
                                                  child: Text(
                                                    'Name 123asdf asdfa sdfasd asdjasfkjdfkj',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                ),
                                                const Gap(5),
                                                RatingBarIndicator(
                                                  rating: 2.75,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          const Icon(
                                                    FontAwesomeIcons.solidStar,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 15,
                                                  direction: Axis.horizontal,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(horizontal: 1),
                                                ),
                                                const Gap(5),
                                                const Text(
                                                  '1k reviews',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.lightBlack),
                                                ),
                                                const Gap(5),
                                                getTodayOfferText(),
                                                const Gap(5),
                                                Text(
                                                  '₹300',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                const Gap(5),
                                                Wrap(
                                                  children: [
                                                    Text(
                                                      "M.R.P:",
                                                      maxLines: 1,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .lightBlack),
                                                    ),
                                                    Text(
                                                      "₹400",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              decorationColor:
                                                                  AppColors
                                                                      .lightBlack,
                                                              color: AppColors
                                                                  .lightBlack),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SliverGap(100)
                    ],
                  );
                case ProductDetailError:
                  state as ProductDetailError;
                  return Center(
                    child: Text(state.errorMessage),
                  );
                default:
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
              }
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: AppColors.transparent,
          elevation: 0,
          child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColors.yellow),
                foregroundColor:
                    MaterialStatePropertyAll(AppColors.black.withOpacity(0.8)),
              ),
              child: const Text('Add to Basket')),
        ));
  }
}

class SizePickerWidget extends StatefulWidget {
  const SizePickerWidget({
    super.key,
  });

  @override
  State<SizePickerWidget> createState() => _SizePickerWidgetState();
}

class _SizePickerWidgetState extends State<SizePickerWidget> {
  bool _clicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: AppColors.lightGrey))),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _clicked = !_clicked;
              });
            },
            child: Container(
              height: 50,
              color: AppColors.transparent,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Size',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  !_clicked
                      ? const FaIcon(
                          FontAwesomeIcons.caretDown,
                          size: 18,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.caretUp,
                          size: 18,
                        )
                ],
              ),
            ),
          ),
          Visibility(
            visible: _clicked,
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: Container(
                    height: 100,
                    width: 90,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

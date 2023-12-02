// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app1/constants/app_colors.dart';
import 'package:app1/presentation/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:app1/data/models/productmodel.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../business_logic/blocs/product_list_bloc/product_list_bloc.dart';
import '../routes/route_constants.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final bool ofShop;
  const ProductTile({
    Key? key,
    required this.product,
    this.ofShop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      child: GestureDetector(
        onTap: () => context.pushNamed(RouteConstants.productDetailRoute,
            pathParameters: {'product_id': product.id}),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.canvasColor,
                  border: Border.all(width: 0.7, color: AppColors.lightGrey),
                  borderRadius: BorderRadius.circular(15.r)),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            // border: Border.all(color: AppColors.lightGrey),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(product.thumbnail),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w500),
                                maxLines: 2,
                              ),
                              const Gap(5),
                              Visibility(
                                visible: !ofShop,
                                child: Column(
                                  children: [
                                    Text(
                                      product.shopName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: AppColors.grey
                                                  .withOpacity(0.9)),
                                      maxLines: 1,
                                    ),
                                    const Gap(5),
                                  ],
                                ),
                              ),
                              Visibility(
                                  visible: product.rating > 4.2,
                                  child: Column(
                                    children: [
                                      Wrap(
                                          spacing: 5,
                                          runSpacing: 5,
                                          children: List.generate(
                                              8,
                                              (index) => Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .lightGrey
                                                            .withOpacity(0.13),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r)),
                                                    child: const Text(
                                                      'hello',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                              AppColors.black),
                                                    ),
                                                  ))),
                                      const Gap(5),
                                    ],
                                  )),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.solidStar,
                                    size: 10,
                                    color: AppColors.darkGreen,
                                  ),
                                  const Gap(2),
                                  Text(
                                    product.rating.toStringAsFixed(1),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: AppColors.darkGreen,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  const Gap(2),
                                  Text(
                                    '(1,243)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: AppColors.lightBlack,
                                          // fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                              const Gap(5),
                              Wrap(
                                spacing: 2,
                                crossAxisAlignment: WrapCrossAlignment.end,
                                children: [
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        "₹",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black
                                                    .withOpacity(0.7)),
                                      ),
                                      Text(
                                        product.price.toStringAsFixed(0),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black),
                                      ),
                                    ],
                                  ),
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
                                    "₹${(product.price + 100).toStringAsFixed(0)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor:
                                                AppColors.lightBlack,
                                            color: AppColors.lightBlack),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const Gap(5),
                              Text(
                                "(25% off)",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: const Color.fromARGB(
                                          255, 255, 102, 0),
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const Gap(5),
                              Container(
                                padding: EdgeInsets.all(5.sp),
                                decoration: BoxDecoration(
                                    color: AppColors.violet,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "Free Delivery",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              const Gap(10),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(1),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(10, 10)),
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(200, 30)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.black.withOpacity(0.8)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.yellow.withOpacity(1)),
                                    ),
                                    child: Text(
                                      'Add to Cart',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppColors.black),
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            getBestsellerText(visible: product.rating >= 4)
          ],
        ),
      ),
    );
  }
}

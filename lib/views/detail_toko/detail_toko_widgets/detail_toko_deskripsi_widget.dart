import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/detail_toko_controller.dart';
import 'package:provider/provider.dart';

class DetailTokoDeskripsiWidget extends StatefulWidget {
  final String tokoName;
  const DetailTokoDeskripsiWidget({super.key, required this.tokoName});

  @override
  State<DetailTokoDeskripsiWidget> createState() =>
      _DetailTokoDeskripsiWidgetState();
}

class _DetailTokoDeskripsiWidgetState extends State<DetailTokoDeskripsiWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    
    return Consumer<DetailTokoController>(
      builder: (context, detailTokoController, child) {
        final detailToko = detailTokoController.detailToko[widget.tokoName]!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: scaleHelper.scaleWidth(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detailToko.name,
                    style: TextStyleConstant.textStyleSemiBold.copyWith(
                      fontSize: scaleHelper.scaleText(16),
                      color: ColorConstant.blackColor,
                    ),
                  ),
                  SizedBox(height: scaleHelper.scaleHeight(4)),
                  Text(
                    detailToko.category,
                    style: TextStyleConstant.textStyleRegular.copyWith(
                      fontSize: scaleHelper.scaleText(14),
                      color: ColorConstant.blackColor,
                    ),
                  ),
                  SizedBox(height: scaleHelper.scaleHeight(8)),
                  Text(
                    detailToko.address,
                    style: TextStyleConstant.textStyleRegular.copyWith(
                      fontSize: scaleHelper.scaleText(12),
                      color: ColorConstant.blackColor,
                    ),
                  ),
                  SizedBox(height: scaleHelper.scaleHeight(16)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, color: ColorConstant.yellowColor),
                                Text(
                                  detailToko.rating.toString(),
                                  style: TextStyleConstant.textStyleSemiBold
                                      .copyWith(
                                        fontSize: scaleHelper.scaleText(16),
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              "${detailToko.totalReview} Ulasan",
                              style: TextStyleConstant.textStyleRegular.copyWith(
                                fontSize: scaleHelper.scaleText(12),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: scaleHelper.scaleWidth(15)),
                        SizedBox(height: 32, child: VerticalDivider()),
                        SizedBox(width: scaleHelper.scaleWidth(15)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detailToko.products.fold<int>(0, (sum, product) => sum + product.terjual).toString(),
                              style: TextStyleConstant.textStyleSemiBold.copyWith(
                                fontSize: scaleHelper.scaleText(16),
                              ),
                            ),
                            Text(
                              "Terjual",
                              style: TextStyleConstant.textStyleRegular.copyWith(
                                fontSize: scaleHelper.scaleText(12),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: scaleHelper.scaleWidth(15)),
                        SizedBox(height: 32, child: VerticalDivider()),
                        SizedBox(width: scaleHelper.scaleWidth(15)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detailToko.products.length.toString(),
                              style: TextStyleConstant.textStyleSemiBold.copyWith(
                                fontSize: scaleHelper.scaleText(16),
                              ),
                            ),
                            Text(
                              "Produk",
                              style: TextStyleConstant.textStyleRegular.copyWith(
                                fontSize: scaleHelper.scaleText(12),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: scaleHelper.scaleWidth(15)),
                        SizedBox(height: 32, child: VerticalDivider()),
                        SizedBox(width: scaleHelper.scaleWidth(15)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${detailToko.operationalHours.open} - ${detailToko.operationalHours.close}',
                              style: TextStyleConstant.textStyleSemiBold.copyWith(
                                fontSize: scaleHelper.scaleText(16),
                              ),
                            ),
                            Text(
                              "Jam Buka",
                              style: TextStyleConstant.textStyleRegular.copyWith(
                                fontSize: scaleHelper.scaleText(12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        );
      }
    );
  }
}

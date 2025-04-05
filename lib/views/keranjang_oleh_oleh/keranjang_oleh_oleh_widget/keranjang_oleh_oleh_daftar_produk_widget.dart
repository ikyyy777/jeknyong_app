import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/keranjang_oleh_oleh_controller.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class KeranjangOlehOlehDaftarProdukWidget extends StatefulWidget {
  const KeranjangOlehOlehDaftarProdukWidget({super.key});

  @override
  State<KeranjangOlehOlehDaftarProdukWidget> createState() =>
      _KeranjangOlehOlehDaftarProdukWidgetState();
}

class _KeranjangOlehOlehDaftarProdukWidgetState
    extends State<KeranjangOlehOlehDaftarProdukWidget> {
  final formatCurrency = NumberFormat.decimalPattern('id');

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Consumer<KeranjangOlehOlehController>(
      builder: (context, keranjangController, child) {
        if (keranjangController.items.isEmpty) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
            decoration: BoxDecoration(
              color: ColorConstant.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Keranjang masih kosong",
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                  color: ColorConstant.darkColor3,
                ),
              ),
            ),
          );
        }

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConstant.whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daftar Produk",
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(16),
                  ),
                ),
                SizedBox(height: scaleHelper.scaleHeight(12)),
                Divider(color: ColorConstant.dividerColor),
                ...keranjangController.items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final product = item.product;
                  final variant = product.variants!.firstWhere(
                    (v) => v.name == item.selectedVariant,
                  );
                  final totalPrice =
                      product.price + (variant.additionalPrice ?? 0);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index > 0) Divider(color: ColorConstant.dividerColor),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: scaleHelper.scaleWidth(82),
                            height: scaleHelper.scaleHeight(82),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(product.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: scaleHelper.scaleWidth(12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyleConstant.textStyleSemiBold
                                      .copyWith(
                                        fontSize: scaleHelper.scaleText(14),
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${product.typeVariant}: ${item.selectedVariant}",
                                  style: TextStyleConstant.textStyleRegular
                                      .copyWith(
                                        fontSize: scaleHelper.scaleText(12),
                                        color: ColorConstant.darkColor1,
                                      ),
                                ),
                                SizedBox(height: scaleHelper.scaleHeight(8)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Rp ${formatCurrency.format(totalPrice)}",
                                        style: TextStyleConstant
                                            .textStyleSemiBold
                                            .copyWith(
                                              fontSize: scaleHelper.scaleText(
                                                14,
                                              ),
                                              color: ColorConstant.primaryColor,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (item.quantity > 1) {
                                              keranjangController
                                                  .updateQuantity(
                                                    index,
                                                    item.quantity - 1,
                                                  );
                                            } else {
                                              keranjangController
                                                  .removeFromCart(index);
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                              scaleHelper.scaleWidth(4),
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color:
                                                    ColorConstant.borderColor,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              size: scaleHelper.scaleWidth(16),
                                              color: ColorConstant.primaryColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: scaleHelper.scaleWidth(
                                              12,
                                            ),
                                            vertical: scaleHelper.scaleHeight(
                                              4,
                                            ),
                                          ),
                                          child: Text(
                                            item.quantity.toString(),
                                            style: TextStyleConstant
                                                .textStyleSemiBold
                                                .copyWith(
                                                  fontSize: scaleHelper
                                                      .scaleText(14),
                                                  color:
                                                      ColorConstant.darkColor1,
                                                ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            keranjangController.updateQuantity(
                                              index,
                                              item.quantity + 1,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                              scaleHelper.scaleWidth(4),
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color:
                                                    ColorConstant.borderColor,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: scaleHelper.scaleWidth(16),
                                              color: ColorConstant.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: scaleHelper.scaleHeight(12)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Tambah Produk Lainnya",
                          style: TextStyleConstant.textStyleSemiBold.copyWith(
                            fontSize: scaleHelper.scaleText(12),
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}

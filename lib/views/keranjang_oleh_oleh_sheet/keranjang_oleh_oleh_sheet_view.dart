import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/models/detail_toko_model.dart';
import 'package:provider/provider.dart';

class KeranjangOlehOlehSheetView extends StatelessWidget {
  final Product addedProduct;
  final String selectedVariant;

  const KeranjangOlehOlehSheetView({
    super.key,
    required this.addedProduct,
    required this.selectedVariant,
  });

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Container(
      padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Divider(
                thickness: 4,
                color: ColorConstant.blackColor.withOpacity(0.6),
              ),
            ),
          ),
          SizedBox(height: scaleHelper.scaleHeight(16)),
          Container(
            padding: EdgeInsets.all(scaleHelper.scaleWidth(12)),
            decoration: BoxDecoration(
              color: ColorConstant.greyColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    addedProduct.image,
                    width: scaleHelper.scaleWidth(100),
                    height: scaleHelper.scaleHeight(100),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: scaleHelper.scaleWidth(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        addedProduct.name,
                        style: TextStyleConstant.textStyleSemiBold.copyWith(
                          fontSize: scaleHelper.scaleText(14),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: scaleHelper.scaleHeight(8)),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: ColorConstant.greenColor,
                          ),
                          SizedBox(width: scaleHelper.scaleWidth(10)),
                          Text(
                            'Masuk ke Keranjang',
                            style: TextStyleConstant.textStyleRegular.copyWith(
                              fontSize: scaleHelper.scaleText(14),
                              color: ColorConstant.greenColor,
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
          SizedBox(height: scaleHelper.scaleHeight(16)),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Navigate to Keranjang page
                Navigator.pushNamed(context, '/keranjang-oleh-oleh');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.primaryColor,
                padding: EdgeInsets.symmetric(
                  vertical: scaleHelper.scaleHeight(12),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Cek Keranjang',
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: scaleHelper.scaleHeight(8)),
        ],
      ),
    );
  }
}

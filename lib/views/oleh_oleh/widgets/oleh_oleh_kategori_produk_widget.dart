import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/views/kategori_produk/kategori_produk_view.dart';
import 'package:provider/provider.dart';

class OlehOlehKategoriProdukWidget extends StatefulWidget {
  const OlehOlehKategoriProdukWidget({super.key});

  @override
  State<OlehOlehKategoriProdukWidget> createState() =>
      _OlehOlehKategoriProdukWidgetState();
}

class _OlehOlehKategoriProdukWidgetState
    extends State<OlehOlehKategoriProdukWidget> {

  Widget _buildImageContainer(String imagePath, String text) {
    return Consumer<ScaleFactorController>(
      builder: (context, scaleController, child) {
        final scaleHelper = scaleController.scaleHelper;
        return Column(
          children: [
            Container(
              width: scaleHelper.scaleWidth(76),
              height: scaleHelper.scaleHeight(76),
              decoration: BoxDecoration(
                color: ColorConstant.greyColor,
                borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(12)),
              ),
              child: Center(
                child: SvgPicture.asset(imagePath),
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(4)),
            Text(
              text,
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.blackColor,
              ),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScaleFactorController>(
      builder: (context, scaleController, child) {
        final scaleHelper = scaleController.scaleHelper;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Kategori Produk',
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(16),
                color: ColorConstant.blackColor,
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(8)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KategoriProdukView(kategori: 'Elektronik'),
                        ),
                      );
                    },
                    child: _buildImageContainer('assets/icons/elektronik.svg', 'Elektronik'),
                  ),
                  SizedBox(width: scaleHelper.scaleWidth(8)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KategoriProdukView(kategori: 'Furniture'),
                        ),
                      );
                    },
                    child: _buildImageContainer('assets/icons/furniture.svg', 'Furniture'),
                  ),
                  SizedBox(width: scaleHelper.scaleWidth(8)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KategoriProdukView(kategori: 'Kerajinan'),
                        ),
                      );
                    },
                    child: _buildImageContainer('assets/icons/kerajinan.svg', 'Kerajinan'),
                  ),
                  SizedBox(width: scaleHelper.scaleWidth(8)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KategoriProdukView(kategori: 'Pakaian'),
                        ),
                      );
                    },
                    child: _buildImageContainer('assets/icons/pakaian.svg', 'Pakaian'),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/detail_toko_controller.dart';
import 'package:jeknyong_app/models/detail_toko_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:jeknyong_app/views/detail_produk_sheet/detail_produk_sheet_view.dart';

class DetailTokoProdukWidget extends StatefulWidget {
  final String tokoName;
  const DetailTokoProdukWidget({super.key, required this.tokoName});

  @override
  State<DetailTokoProdukWidget> createState() => _DetailTokoProdukWidgetState();
}

class _DetailTokoProdukWidgetState extends State<DetailTokoProdukWidget> {
  final formatCurrency = NumberFormat.decimalPattern('id');

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Consumer<DetailTokoController>(
      builder: (context, detailTokoController, child) {
        final products =
            detailTokoController.detailToko[widget.tokoName]?.products ?? [];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleHelper.scaleWidth(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daftar Produk",
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: scaleHelper.scaleText(16),
                ),
              ),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              ...products
                  .map(
                    (product) => Padding(
                      padding: EdgeInsets.only(
                        bottom: scaleHelper.scaleHeight(16),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder:
                                (context) =>
                                    DetailProdukSheetView(product: product),
                          );
                        },
                        child: ProdukItemWidget(
                          imagePath: product.image,
                          namaProduk: product.name,
                          jumlahTerjual: "${product.terjual} Terjual",
                          harga: "Rp ${formatCurrency.format(product.price)}",
                          onTapAdd: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder:
                                  (context) =>
                                      DetailProdukSheetView(product: product),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        );
      },
    );
  }
}

class ProdukItemWidget extends StatelessWidget {
  final String imagePath;
  final String namaProduk;
  final String jumlahTerjual;
  final String harga;
  final VoidCallback onTapAdd;

  const ProdukItemWidget({
    super.key,
    required this.imagePath,
    required this.namaProduk,
    required this.jumlahTerjual,
    required this.harga,
    required this.onTapAdd,
  });

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: scaleHelper.scaleWidth(100),
          height: scaleHelper.scaleHeight(100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: scaleHelper.scaleWidth(16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                namaProduk,
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  fontSize: scaleHelper.scaleText(16),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: scaleHelper.scaleHeight(2)),
              Text(
                jumlahTerjual,
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: scaleHelper.scaleText(12),
                ),
              ),
              SizedBox(height: scaleHelper.scaleHeight(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    harga,
                    style: TextStyleConstant.textStyleSemiBold.copyWith(
                      fontSize: scaleHelper.scaleText(16),
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTapAdd,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ColorConstant.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: scaleHelper.scaleText(16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

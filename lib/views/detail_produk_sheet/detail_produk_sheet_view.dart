import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/detail_toko_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/models/detail_toko_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:jeknyong_app/views/keranjang_oleh_oleh_sheet/keranjang_oleh_oleh_sheet_view.dart';
import 'package:jeknyong_app/controllers/keranjang_oleh_oleh_controller.dart';

class DetailProdukSheetView extends StatefulWidget {
  final Product product;
  
  const DetailProdukSheetView({
    super.key,
    required this.product,
  });

  @override
  State<DetailProdukSheetView> createState() => _DetailProdukSheetViewState();
}

class _DetailProdukSheetViewState extends State<DetailProdukSheetView> {
  final formatCurrency = NumberFormat.decimalPattern('id');

  Widget _buildVariantSelector(BuildContext context, Product product) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: product.variants!.map((variant) {
            return Consumer<DetailTokoController>(
              builder: (context, controller, child) {
                bool isSelected = controller.isVariantSelected(
                  product.name,
                  variant.name,
                );

                return GestureDetector(
                  onTap: () {
                    controller.selectVariant(product.name, variant.name);
                  },
                  child: Container(
                    width: scaleHelper.scaleWidth(57),
                    margin: EdgeInsets.only(right: scaleHelper.scaleWidth(8)),
                    padding: EdgeInsets.symmetric(
                      horizontal: scaleHelper.scaleWidth(12),
                      vertical: scaleHelper.scaleHeight(4),
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? ColorConstant.primaryColor : Colors.white,
                      border: Border.all(
                        color: ColorConstant.darkColor3,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            variant.name,
                            style: TextStyleConstant.textStyleRegular.copyWith(
                              fontSize: scaleHelper.scaleText(14),
                              color: isSelected ? Colors.white : ColorConstant.primaryColor,
                            ),
                          ),
                          if (variant.additionalPrice != null && variant.additionalPrice! > 0)
                            Text(
                              '+${variant.additionalPrice}',
                              style: TextStyleConstant.textStyleRegular.copyWith(
                                fontSize: scaleHelper.scaleText(12),
                                color: isSelected ? Colors.white : ColorConstant.primaryColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showSuccessSheet(BuildContext context) {
    Navigator.pop(context); // Tutup bottom sheet detail produk
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Consumer<DetailTokoController>(
        builder: (context, controller, child) => KeranjangOlehOlehSheetView(
          addedProduct: widget.product,
          selectedVariant: controller.selectedVariants[widget.product.name] ?? '',
        ),
      ),
    );
  }

  void _addToCart(BuildContext context) {
    final controller = context.read<DetailTokoController>();
    final keranjangController = context.read<KeranjangOlehOlehController>();
    
    final selectedVariant = controller.selectedVariants[widget.product.name];
    if (selectedVariant == null) {
      // Tampilkan pesan error jika variant belum dipilih
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Silakan pilih ${widget.product.typeVariant} terlebih dahulu'),
        ),
      );
      return;
    }

    keranjangController.addToCart(widget.product, selectedVariant);
    _showSuccessSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Container(
      padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Center(
              child: Image.asset(
                widget.product.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            Text(
              widget.product.name,
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(18),
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(8)),
            Text(
              widget.product.description,
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: scaleHelper.scaleText(14),
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            Text(
              widget.product.typeVariant ?? '',
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: scaleHelper.scaleText(14),
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            _buildVariantSelector(context, widget.product),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            Consumer<DetailTokoController>(
              builder: (context, controller, child) {
                double totalPrice = controller.getTotalPrice(
                  widget.product.name,
                  widget.product.price,
                );
                return Text(
                  'Rp ${formatCurrency.format(totalPrice)}',
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(16),
                    color: ColorConstant.primaryColor,
                  ),
                );
              },
            ),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _addToCart(context),
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
                  'Tambah ke Keranjang',
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(14),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
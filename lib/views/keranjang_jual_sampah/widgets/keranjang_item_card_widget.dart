import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/keranjang_jual_sampah_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class KeranjangItemCardWidget extends StatelessWidget {
  final KeranjangItem item;
  final Function(KeranjangItem) onEditPressed;

  const KeranjangItemCardWidget({
    super.key,
    required this.item,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    final controller = context.read<KeranjangJualSampahDipilahController>();
    final formatCurrency = NumberFormat.decimalPattern('id');

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: scaleHelper.scaleHeight(8)),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Daftar Jenis Sampah",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(16),
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(12)),
            Divider(color: ColorConstant.dividerColor),
            SizedBox(height: scaleHelper.scaleHeight(12)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar sampah
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item.jenisSampah.gambar,
                    width: scaleHelper.scaleWidth(80),
                    height: scaleHelper.scaleWidth(80),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: scaleHelper.scaleWidth(12)),

                // Informasi sampah
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.jenisSampah.nama,
                        style: TextStyleConstant.textStyleSemiBold.copyWith(
                          fontSize: scaleHelper.scaleText(16),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Rp ${formatCurrency.format(item.jenisSampah.hargaPerKg)},-',
                            style: TextStyleConstant.textStyleBold.copyWith(
                              fontSize: scaleHelper.scaleText(16),
                              color: ColorConstant.greenColor,
                            ),
                          ),
                          Text(
                            ' /Kg',
                            style: TextStyleConstant.textStyleRegular.copyWith(
                              fontSize: scaleHelper.scaleText(16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: scaleHelper.scaleHeight(8)),

                      // Kontrol berat dengan tombol tambah/kurang
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (item.berat > item.jenisSampah.minimumBerat) {
                                controller.updateBerat(
                                  item.jenisSampah.id,
                                  item.berat - 0.5,
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: ColorConstant.borderColor,
                                ),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 16,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: scaleHelper.scaleWidth(12)),
                          Text(
                            item.berat.toStringAsFixed(1),
                            style: TextStyleConstant.textStyleSemiBold.copyWith(
                              fontSize: scaleHelper.scaleText(14),
                            ),
                          ),
                          SizedBox(width: scaleHelper.scaleWidth(12)),
                          InkWell(
                            onTap: () {
                              controller.updateBerat(
                                item.jenisSampah.id,
                                item.berat + 0.5,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: ColorConstant.borderColor,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 16,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: scaleHelper.scaleWidth(8)),
                          Text(
                            'Kg',
                            style: TextStyleConstant.textStyleRegular.copyWith(
                              fontSize: scaleHelper.scaleText(14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Tombol hapus
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: ColorConstant.primaryColor,
                  ),
                  onPressed: () {
                    controller.hapusItem(item.jenisSampah.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${item.jenisSampah.nama} dihapus dari keranjang',
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: scaleHelper.scaleHeight(12)),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Tambah Jenis Lainnya',
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  fontSize: scaleHelper.scaleText(12),
                  color: ColorConstant.primaryColor,
                ),
              ),
            ),
            Divider(color: ColorConstant.dividerColor),
            SizedBox(height: scaleHelper.scaleHeight(8)),
            Row(
              children: [
                Text(
                  'Total Pendapatan',
                  style: TextStyleConstant.textStyleRegular.copyWith(
                    fontSize: scaleHelper.scaleText(14),
                    color: ColorConstant.blackColor,
                  ),
                ),
                Spacer(),
                Text(
                  'Rp ${formatCurrency.format(item.totalHarga)}',
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(14),
                    color: ColorConstant.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 
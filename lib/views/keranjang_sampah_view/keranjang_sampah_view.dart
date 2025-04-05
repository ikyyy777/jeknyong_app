import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/keranjang_jual_sampah_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class KeranjangSampahView extends StatefulWidget {
  const KeranjangSampahView({super.key});

  @override
  State<KeranjangSampahView> createState() => _KeranjangSampahViewState();
}

class _KeranjangSampahViewState extends State<KeranjangSampahView> {
  final formatCurrency = NumberFormat.decimalPattern('id');

  @override
  void initState() {
    super.initState();
    // Tambahkan data dummy untuk testing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KeranjangJualSampahDipilahController>().addDummyItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.greyColor2,

      body: Consumer<KeranjangJualSampahDipilahController>(
        builder: (context, controller, child) {
          if (controller.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAppbarGlobalWidget(title: "Keranjang Jual Sampah"),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Keranjang kosong',
                            style: TextStyleConstant.textStyleSemiBold.copyWith(
                              fontSize: scaleHelper.scaleText(16),
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tambahkan sampah untuk mulai menjual',
                            style: TextStyleConstant.textStyleRegular.copyWith(
                              fontSize: scaleHelper.scaleText(14),
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              CustomAppbarGlobalWidget(title: "Keranjang Jual Sampah"),
              // List keranjang item
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
                  itemCount: controller.itemCount,
                  separatorBuilder: (context, index) => Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return _buildItemCard(context, item, controller);
                  },
                ),
              ),

              // Bottom panel dengan total dan checkout button
              Container(
                padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Ringkasan
                    Text(
                      'Ringkasan',
                      style: TextStyleConstant.textStyleSemiBold.copyWith(
                        fontSize: scaleHelper.scaleText(16),
                      ),
                    ),
                    SizedBox(height: scaleHelper.scaleHeight(8)),
                    // Total berat
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Berat:',
                          style: TextStyleConstant.textStyleRegular.copyWith(
                            fontSize: scaleHelper.scaleText(14),
                          ),
                        ),
                        Text(
                          '${controller.totalBerat.toStringAsFixed(1)} kg',
                          style: TextStyleConstant.textStyleSemiBold.copyWith(
                            fontSize: scaleHelper.scaleText(14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: scaleHelper.scaleHeight(4)),
                    // Total item
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Item:',
                          style: TextStyleConstant.textStyleRegular.copyWith(
                            fontSize: scaleHelper.scaleText(14),
                          ),
                        ),
                        Text(
                          '${controller.itemCount} jenis',
                          style: TextStyleConstant.textStyleSemiBold.copyWith(
                            fontSize: scaleHelper.scaleText(14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: scaleHelper.scaleHeight(4)),
                    // Total pendapatan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Pendapatan:',
                          style: TextStyleConstant.textStyleSemiBold.copyWith(
                            fontSize: scaleHelper.scaleText(16),
                          ),
                        ),
                        Text(
                          'Rp ${formatCurrency.format(controller.totalHarga)}',
                          style: TextStyleConstant.textStyleBold.copyWith(
                            fontSize: scaleHelper.scaleText(16),
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: scaleHelper.scaleHeight(16)),

                    // Tombol proses penjualan
                    SizedBox(
                      width: double.infinity,
                      height: scaleHelper.scaleHeight(48),
                      child: ElevatedButton(
                        onPressed: () {
                          // Show dialog berhasil
                          _showBerasilProsesDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Proses Penjualan',
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
            ],
          );
        },
      ),
    );
  }

  // Widget untuk item card
  Widget _buildItemCard(
    BuildContext context,
    KeranjangItem item,
    KeranjangJualSampahDipilahController controller,
  ) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

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
  

  // Dialog berhasil proses penjualan
  void _showBerasilProsesDialog(BuildContext context) {
    final controller = context.read<KeranjangJualSampahDipilahController>();
    final formatCurrency = NumberFormat.decimalPattern('id');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Penjualan Berhasil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: ColorConstant.greenColor,
                size: 60,
              ),
              SizedBox(height: 16),
              Text(
                'Selamat! Penjualan sampah berhasil diproses.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Rp ${formatCurrency.format(controller.totalHarga)}',
                style: TextStyleConstant.textStyleBold.copyWith(
                  fontSize: 20,
                  color: ColorConstant.greenColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'akan ditambahkan ke saldo Anda',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.kosongkanKeranjang();
                  Navigator.pop(context);
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                ),
                child: Text('Selesai', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }
}

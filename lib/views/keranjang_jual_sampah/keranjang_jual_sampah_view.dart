import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/jual_sampah_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/keranjang_jual_sampah_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:jeknyong_app/views/keranjang_jual_sampah/widgets/jual_sampah_alamat_widget.dart';
import 'package:jeknyong_app/views/keranjang_jual_sampah/widgets/jual_sampah_informasi_tambahan_widget.dart';
import 'package:jeknyong_app/views/keranjang_jual_sampah/widgets/keranjang_empty_widget.dart';
import 'package:jeknyong_app/views/keranjang_jual_sampah/widgets/keranjang_summary_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class KeranjangJualSampahView extends StatefulWidget {
  const KeranjangJualSampahView({super.key});

  @override
  State<KeranjangJualSampahView> createState() =>
      _KeranjangJualSampahViewState();
}

class _KeranjangJualSampahViewState extends State<KeranjangJualSampahView> {
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
            return const KeranjangEmptyWidget();
          }

          return Column(
            children: [
              CustomAppbarGlobalWidget(title: "Keranjang Jual Sampah"),
              // List keranjang item dan informasi tambahan
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Daftar Sampah dalam satu container
                        _buildDaftarSampahContainer(context, controller),

                        SizedBox(height: scaleHelper.scaleHeight(16)),

                        // Alamat
                        const JualSampahAlamatWidget(),
                        SizedBox(height: scaleHelper.scaleHeight(16)),

                        // Informasi Tambahan
                        const JualSampahInformasiTambahanWidget(),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom panel dengan total dan checkout button
              KeranjangSummaryWidget(
                onProsesPressed: () => _prosesJualSampah(context),
              ),
            ],
          );
        },
      ),
    );
  }

  // Membuat container untuk seluruh item sampah
  Widget _buildDaftarSampahContainer(
    BuildContext context,
    KeranjangJualSampahDipilahController controller,
  ) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    final formatCurrency = NumberFormat.decimalPattern('id');

    return Container(
      width: double.infinity,
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

            // List semua item
            ...controller.items
                .map(
                  (item) => Column(
                    children: [
                      SizedBox(height: scaleHelper.scaleHeight(12)),
                      _buildItemRow(context, item, controller),
                      SizedBox(height: scaleHelper.scaleHeight(12)),
                      if (controller.items.indexOf(item) <
                          controller.items.length - 1)
                        Divider(color: ColorConstant.dividerColor),
                    ],
                  ),
                )
                ,

            // Tambah jenis sampah lainnya
            SizedBox(height: scaleHelper.scaleHeight(12)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/jual-sampah-dipilah');
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

            // Total pendapatan
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
                  'Rp ${formatCurrency.format(controller.totalHarga)}',
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

  // Membangun baris item sampah
  Widget _buildItemRow(
    BuildContext context,
    KeranjangItem item,
    KeranjangJualSampahDipilahController controller,
  ) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    final formatCurrency = NumberFormat.decimalPattern('id');

    return Row(
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
                        border: Border.all(color: ColorConstant.borderColor),
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
                        border: Border.all(color: ColorConstant.borderColor),
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
          icon: Icon(Icons.delete_outline, color: ColorConstant.primaryColor),
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
    );
  }

  // Proses jual sampah
  void _prosesJualSampah(BuildContext context) async {
    final jualSampahController = context.read<JualSampahDipilahController>();
    final keranjangSampahController = context.read<KeranjangJualSampahDipilahController>();
    final noHp = jualSampahController.noHp;
    final alamat = jualSampahController.address;

    // Validasi alamat
    if (alamat.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih alamat terlebih dahulu'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validasi no HP
    if (noHp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nomor HP harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simpan informasi tambahan
    await jualSampahController.saveInformasiTambahan();

    Navigator.pushNamed(context, '/transaksi-berhasil');

    keranjangSampahController.kosongkanKeranjang();
  }
}

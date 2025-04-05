import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/keranjang_jual_sampah_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/models/jenis_sampah_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class JualSampahDipilahSheetView extends StatefulWidget {
  final JenisSampah sampah;

  const JualSampahDipilahSheetView({super.key, required this.sampah});

  @override
  State<JualSampahDipilahSheetView> createState() =>
      _JualSampahDipilahSheetViewState();
}

class _JualSampahDipilahSheetViewState
    extends State<JualSampahDipilahSheetView> {
  final formatCurrency = NumberFormat.decimalPattern('id');
  final TextEditingController beratController = TextEditingController();
  double berat = 0.0;
  double totalHarga = 0.0;

  @override
  void initState() {
    super.initState();
    beratController.text = widget.sampah.minimumBerat.toString();
    berat = widget.sampah.minimumBerat;
    _hitungTotalHarga();
  }

  @override
  void dispose() {
    beratController.dispose();
    super.dispose();
  }

  void _hitungTotalHarga() {
    setState(() {
      totalHarga = berat * widget.sampah.hargaPerKg;
    });
  }

  void _tambahKeKeranjang(BuildContext context) {
    // Tambahkan ke keranjang menggunakan controller
    final keranjangController = Provider.of<KeranjangJualSampahDipilahController>(
      context, 
      listen: false
    );
    
    keranjangController.tambahItem(widget.sampah, berat);
    
    // Tampilkan snackbar sukses
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.sampah.nama} berhasil ditambahkan ke keranjang'),
        backgroundColor: ColorConstant.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
    
    // Tutup bottom sheet
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Container(
      padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
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
            child: Stack(
              children: [
                Image.asset(
                  widget.sampah.gambar,
                  width: double.infinity,
                  height: scaleHelper.scaleHeight(150),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      "Min ${widget.sampah.minimumBerat}kg",
                      style: TextStyleConstant.textStyleSemiBold.copyWith(
                        fontSize: scaleHelper.scaleText(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: scaleHelper.scaleHeight(16)),
          Row(
            children: [
              Text(
                widget.sampah.nama,
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  fontSize: scaleHelper.scaleText(16),
                ),
              ),
              Spacer(),
              Text(
                'Rp ${formatCurrency.format(widget.sampah.hargaPerKg)}',
                style: TextStyleConstant.textStyleBold.copyWith(
                  fontSize: scaleHelper.scaleText(20),
                  color: ColorConstant.greenColor,
                ),
              ),
              Text(
                '/kg',
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  fontSize: scaleHelper.scaleText(16),
                ),
              ),
            ],
          ),
          SizedBox(height: scaleHelper.scaleHeight(8)),
          Text(
            widget.sampah.deskripsi,
            style: TextStyleConstant.textStyleRegular.copyWith(
              fontSize: scaleHelper.scaleText(14),
            ),
          ),
          
          SizedBox(height: scaleHelper.scaleHeight(16)),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _tambahKeKeranjang(context),
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
                'Tambah Ke Keranjang',
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: scaleHelper.scaleHeight(16)),
        ],
      ),
    );
  }
}

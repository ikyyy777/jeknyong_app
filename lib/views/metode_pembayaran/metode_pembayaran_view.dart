import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/pembayaran_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:jeknyong_app/views/lakukan_pembayaran/lakukan_pembayaran_view.dart';
import 'package:provider/provider.dart';
import 'package:jeknyong_app/controllers/keranjang_oleh_oleh_controller.dart';
import 'package:intl/intl.dart';

class MetodePembayaranView extends StatefulWidget {
  const MetodePembayaranView({super.key});

  @override
  State<MetodePembayaranView> createState() => _MetodePembayaranViewState();
}

class _MetodePembayaranViewState extends State<MetodePembayaranView> {
  final formatCurrency = NumberFormat.decimalPattern('id');

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    final pembayaranController = context.watch<PembayaranController>();
    final keranjangController = context.watch<KeranjangOlehOlehController>();

    final totalHarga = keranjangController.getTotalPrice() + 10000;

    return Scaffold(
      backgroundColor: ColorConstant.greyColor2,
      body: Column(
        children: [
          CustomAppbarGlobalWidget(title: "Pilih Metode Pembayaran"),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...pembayaranController.paymentMethods.map((paymentMethod) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: scaleHelper.scaleHeight(16),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (paymentMethod.type == "cod") {
                                pembayaranController.selectCOD();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: scaleHelper.scaleWidth(40),
                                    height: scaleHelper.scaleHeight(40),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: ColorConstant.primaryColorLighter,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        paymentMethod.icon,
                                        width: scaleHelper.scaleWidth(24),
                                        height: scaleHelper.scaleHeight(24),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: scaleHelper.scaleWidth(16)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          paymentMethod.name,
                                          style: TextStyleConstant
                                              .textStyleSemiBold
                                              .copyWith(
                                                fontSize: scaleHelper.scaleText(
                                                  14,
                                                ),
                                              ),
                                        ),
                                        if (paymentMethod.description != null)
                                          Text(
                                            paymentMethod.description!,
                                            style: TextStyleConstant
                                                .textStyleRegular
                                                .copyWith(
                                                  fontSize: scaleHelper
                                                      .scaleText(12),
                                                  color:
                                                      ColorConstant.darkColor3,
                                                ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (paymentMethod.type == "cod")
                                    Radio(
                                      value: "cod",
                                      groupValue:
                                          pembayaranController
                                              .selectedPaymentMethodId,
                                      activeColor: ColorConstant.primaryColor,
                                      onChanged:
                                          (value) =>
                                              pembayaranController.selectCOD(),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (paymentMethod.banks != null &&
                              paymentMethod.banks!.isNotEmpty)
                            _buildBankSection(context, paymentMethod),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: scaleHelper.scaleHeight(97),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Harga',
                      style: TextStyleConstant.textStyleRegular.copyWith(
                        fontSize: scaleHelper.scaleText(12),
                        color: ColorConstant.darkColor2,
                      ),
                    ),
                    SizedBox(height: scaleHelper.scaleHeight(4)),
                    Text(
                      'Rp ${formatCurrency.format(totalHarga)}',
                      style: TextStyleConstant.textStyleBold.copyWith(
                        fontSize: scaleHelper.scaleText(16),
                        color: ColorConstant.darkColor1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: scaleHelper.scaleWidth(16)),
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      (pembayaranController.selectedBank != null ||
                              pembayaranController.isCODSelected)
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LakukanPembayaranView(
                                    totalHarga: totalHarga,
                                    metodePembayaran: pembayaranController.selectedPaymentMethod,
                                    bank: pembayaranController.selectedBank,
                                  ),
                                ),
                              );
                            }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
                    disabledBackgroundColor: ColorConstant.darkColor3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Bayar Sekarang',
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
      ),
    );
  }

  Widget _buildBankSection(BuildContext context, PaymentMethod paymentMethod) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    final pembayaranController = context.read<PembayaranController>();

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: ColorConstant.borderColor)),
      ),
      child: Column(
        children: [
          ...paymentMethod.banks!.map((bank) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    pembayaranController.setSelectedPaymentMethod(
                      paymentMethod.id,
                    );
                    pembayaranController.setSelectedBank(bank.id);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: scaleHelper.scaleWidth(12),
                      vertical: scaleHelper.scaleHeight(12),
                    ),
                    child: Row(
                      children: [
                        Radio(
                          value: bank.id,
                          groupValue: pembayaranController.selectedBankId,
                          activeColor: ColorConstant.primaryColor,
                          onChanged: (val) {
                            pembayaranController.setSelectedPaymentMethod(
                              paymentMethod.id,
                            );
                            pembayaranController.setSelectedBank(val as String);
                          },
                        ),
                        SizedBox(width: scaleHelper.scaleWidth(8)),
                        Image.asset(
                          bank.icon,
                          width: scaleHelper.scaleWidth(56),
                        ),
                        SizedBox(width: scaleHelper.scaleWidth(8)),
                        Expanded(
                          child: Text(
                            bank.name,
                            style: TextStyleConstant.textStyleSemiBold.copyWith(
                              fontSize: scaleHelper.scaleText(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (bank != paymentMethod.banks!.last)
                  Divider(height: 1, color: ColorConstant.borderColor),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}

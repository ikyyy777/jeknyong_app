import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/tarik_saldo_controller.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';

class EWalletFormWidget extends StatelessWidget {
  final ScaleHelper scaleHelper;
  final TarikSaldoController controller;

  const EWalletFormWidget({
    super.key,
    required this.scaleHelper,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wallet Tujuan',
            style: TextStyleConstant.textStyleRegular.copyWith(
              fontSize: scaleHelper.scaleText(14),
            ),
          ),
          SizedBox(height: scaleHelper.scaleHeight(8)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  'Pilih E-Wallet',
                  style: TextStyleConstant.textStyleRegular.copyWith(
                    fontSize: scaleHelper.scaleText(14),
                    color: ColorConstant.darkColor2,
                  ),
                ),
                value: controller.selectedEWallet,
                items:
                    controller.eWalletList.map((wallet) {
                      return DropdownMenuItem<String>(
                        value: wallet['id'],
                        child: Text(wallet['name']),
                      );
                    }).toList(),
                onChanged: controller.updateSelectedEWallet,
              ),
            ),
          ),
          SizedBox(height: scaleHelper.scaleHeight(16)),
          Text(
            'Nomor Tujuan',
            style: TextStyleConstant.textStyleRegular.copyWith(
              fontSize: scaleHelper.scaleText(14),
            ),
          ),
          SizedBox(height: scaleHelper.scaleHeight(8)),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Masukkan Nomor E-Wallet',
              hintStyle: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.darkColor2,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ColorConstant.primaryColor),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: controller.updateEWalletNumber,
          ),
          SizedBox(height: scaleHelper.scaleHeight(16)),
          Text(
            'Nominal Penarikan',
            style: TextStyleConstant.textStyleRegular.copyWith(
              fontSize: scaleHelper.scaleText(14),
            ),
          ),
          SizedBox(height: scaleHelper.scaleHeight(8)),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Masukkan Nominal Penarikan',
              hintStyle: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.darkColor2,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ColorConstant.primaryColor),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            controller: TextEditingController(
              text: controller.withdrawalAmount,
            ),
            enabled: !controller.isEWalletWithdrawAll,
            onChanged: controller.updateWithdrawalAmount,
          ),
          SizedBox(height: scaleHelper.scaleHeight(16)),
          Row(
            children: [
              Checkbox(
                value: controller.isEWalletWithdrawAll,
                onChanged:
                    (value) =>
                        controller.toggleEWalletWithdrawAll(value ?? false),
                activeColor: ColorConstant.primaryColor,
              ),
              Text(
                'Tarik Semua Saldo',
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

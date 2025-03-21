import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';
import 'package:jeknyong_app/controllers/home_controller.dart';

class HomeRiwayatTransaksiWidget extends StatefulWidget {
  const HomeRiwayatTransaksiWidget({super.key});

  @override
  State<HomeRiwayatTransaksiWidget> createState() =>
      _HomeRiwayatTransaksiWidgetState();
}

class _HomeRiwayatTransaksiWidgetState
    extends State<HomeRiwayatTransaksiWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    return Transform.translate(
      offset: Offset(0, scaleHelper.scaleHeight(-95)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: scaleHelper.scaleWidth(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Riwayat Transaksi",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(16),
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(8)),
            ...context.watch<HomeController>().transactionHistory.map(
              (transaction) => _buildTransactionTile(
                icon: transaction.icon,
                backgroundColor: transaction.isDebit 
                    ? ColorConstant.primaryColorLighter
                    : ColorConstant.secondaryColorLighter,
                title: transaction.title,
                date: transaction.date,
                time: transaction.time,
                amount: transaction.isDebit 
                    ? "-${transaction.amount}"
                    : "+${transaction.amount}",
                amountColor: transaction.isDebit
                    ? ColorConstant.redColor
                    : ColorConstant.secondaryColorDarker,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile({
    required String icon,
    required Color backgroundColor,
    required String title,
    required String date,
    required String time,
    required String amount,
    required Color amountColor,
  }) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return ListTile(
      leading: Container(
        width: scaleHelper.scaleWidth(50),
        height: scaleHelper.scaleHeight(50),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: scaleHelper.scaleWidth(24),
            height: scaleHelper.scaleHeight(24),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyleConstant.textStyleSemiBold.copyWith(
          fontSize: scaleHelper.scaleText(16),
        ),
      ),
      subtitle: Text(
        "$date | $time",
        style: TextStyleConstant.textStyleRegular.copyWith(
          fontSize: scaleHelper.scaleText(12),
        ),
      ),
      trailing: Text(
        amount,
        style: TextStyleConstant.textStyleSemiBold.copyWith(
          fontSize: scaleHelper.scaleText(16),
          color: amountColor,
        ),
      ),
    );
  }
}

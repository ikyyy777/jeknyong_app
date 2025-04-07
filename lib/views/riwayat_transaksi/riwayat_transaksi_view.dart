import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/home_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:provider/provider.dart';

class RiwayatTransaksiView extends StatelessWidget {
  const RiwayatTransaksiView({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    final transactions = context.watch<HomeController>().transactionHistory;

    // Mengelompokkan transaksi berdasarkan tanggal
    final groupedTransactions = <String, List>{};
    for (var transaction in transactions) {
      if (!groupedTransactions.containsKey(transaction.date)) {
        groupedTransactions[transaction.date] = [];
      }
      groupedTransactions[transaction.date]!.add(transaction);
    }

    // Mengurutkan tanggal dari yang terbaru
    final sortedDates =
        groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppbarGlobalWidget(
            title: "Riwayat Transaksi",
            showShadow: true,
          ),
          SizedBox(height: scaleHelper.scaleHeight(16)),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: scaleHelper.scaleWidth(16),
                  vertical: scaleHelper.scaleHeight(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (transactions.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: scaleHelper.scaleHeight(32),
                          ),
                          child: Text(
                            'Belum ada riwayat transaksi',
                            style: TextStyleConstant.textStyleRegular.copyWith(
                              fontSize: scaleHelper.scaleText(14),
                              color: ColorConstant.darkColor3,
                            ),
                          ),
                        ),
                      )
                    else
                      ...sortedDates.map((date) {
                        final dateTransactions = groupedTransactions[date]!;
                        return Column(
                          children: [
                            _buildDateGroup(
                              context: context,
                              date: date,
                              transactions: dateTransactions,
                            ),
                            SizedBox(height: scaleHelper.scaleHeight(24)),
                          ],
                        );
                      }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateGroup({
    required BuildContext context,
    required String date,
    required List transactions,
  }) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: scaleHelper.scaleText(16),
            color: ColorConstant.darkColor2,
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(8)),
        ...transactions.map(
          (transaction) => _buildTransactionTile(
            context: context,
            icon: transaction.icon,
            backgroundColor:
                transaction.isDebit
                    ? ColorConstant.primaryColorLighter
                    : ColorConstant.secondaryColorLighter,
            title: transaction.title,
            date: transaction.date,
            time: transaction.time,
            amount:
                transaction.isDebit
                    ? "-${transaction.amount}"
                    : "+${transaction.amount}",
            amountColor:
                transaction.isDebit
                    ? ColorConstant.redColor
                    : ColorConstant.secondaryColorDarker,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionTile({
    required BuildContext context,
    required String icon,
    required Color backgroundColor,
    required String title,
    required String date,
    required String time,
    required String amount,
    required Color amountColor,
  }) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Container(
      margin: EdgeInsets.only(bottom: scaleHelper.scaleHeight(8)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
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
            color: ColorConstant.darkColor3,
          ),
        ),
        trailing: Text(
          amount,
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: scaleHelper.scaleText(16),
            color: amountColor,
          ),
        ),
      ),
    );
  }
}

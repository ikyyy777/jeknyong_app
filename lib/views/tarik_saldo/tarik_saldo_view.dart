import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/tarik_saldo_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:jeknyong_app/views/tarik_saldo/dialogs/konfirmasi_tarik_saldo_dialog.dart';
import 'package:jeknyong_app/views/tarik_saldo/widgets/bank_form_widget.dart';
import 'package:jeknyong_app/views/tarik_saldo/widgets/ewallet_form_widget.dart';
import 'package:jeknyong_app/views/tarik_saldo/widgets/saldo_card_widget.dart';
import 'package:provider/provider.dart';

class TarikSaldoView extends StatefulWidget {
  const TarikSaldoView({super.key});

  @override
  State<TarikSaldoView> createState() => _TarikSaldoViewState();
}

class _TarikSaldoViewState extends State<TarikSaldoView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleTarikSaldo(BuildContext context, TarikSaldoController controller) async {
    final errorMessage = controller.getErrorMessage();
    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => KonfirmasiTarikSaldoDialog(
        scaleHelper: context.read<ScaleFactorController>().scaleHelper,
      ),
    );

    if (result == true) {
      // Proses penarikan saldo
      // TODO: Implement penarikan saldo
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    final controller = context.watch<TarikSaldoController>();

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbarGlobalWidget(title: "Tarik Saldo"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: scaleHelper.scaleHeight(8)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SaldoCardWidget(
                scaleHelper: scaleHelper,
                controller: controller,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: ColorConstant.primaryColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: ColorConstant.primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: 'Bank'),
                  Tab(text: 'E-Wallet'),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BankFormWidget(
                      scaleHelper: scaleHelper,
                      controller: controller,
                    ),
                    EWalletFormWidget(
                      scaleHelper: scaleHelper,
                      controller: controller,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: controller.isFormValid() 
            ? () => _handleTarikSaldo(context, controller)
            : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            'Tarik Saldo Sekarang',
            style: TextStyleConstant.textStyleSemiBold.copyWith(
              color: Colors.white,
              fontSize: scaleHelper.scaleText(14),
            ),
          ),
        ),
      ),
    );
  }
}

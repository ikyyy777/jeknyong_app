import 'package:flutter/material.dart';
import 'package:jeknyong_app/controllers/toko_rekomendasi_controller.dart';
import 'package:jeknyong_app/global_widget/toko_rekomendasi_global_widget.dart';
import 'package:provider/provider.dart';

class TokoRekomendasiContentWidget extends StatefulWidget {
  const TokoRekomendasiContentWidget({super.key});

  @override
  State<TokoRekomendasiContentWidget> createState() =>
      _TokoRekomendasiContentWidgetState();
}

class _TokoRekomendasiContentWidgetState
    extends State<TokoRekomendasiContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount:
            context
                .watch<TokoRekomendasiController>()
                .listTokoRekomendasi
                .length,
        itemBuilder: (context, index) {
          final toko =
              context
                  .read<TokoRekomendasiController>()
                  .listTokoRekomendasi[index];
          return TokoRekomendasiGlobalWidget(toko: toko);
        },
      ),
    );
  }
}

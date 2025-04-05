import 'package:flutter/material.dart';
import 'package:jeknyong_app/controllers/toko_rekomendasi_controller.dart';
import 'package:jeknyong_app/global_widget/toko_rekomendasi_global_widget.dart';
import 'package:jeknyong_app/views/detail_toko/detail_toko_view.dart';
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
    return Consumer<TokoRekomendasiController>(
      builder: (context, tokoController, child) {
        return Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: tokoController.listTokoRekomendasi.length,
            itemBuilder: (context, index) {
              final toko = tokoController.listTokoRekomendasi[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailTokoView(tokoName: toko.name),
                    ),
                  );
                },
                child: TokoRekomendasiGlobalWidget(toko: toko),
              );
            },
          ),
        );
      },
    );
  }
}

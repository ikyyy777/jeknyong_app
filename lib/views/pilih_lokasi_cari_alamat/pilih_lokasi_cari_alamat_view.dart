import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/pilih_lokasi_cari_alamat_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class PilihLokasiCariAlamatView extends StatefulWidget {
  // Callback untuk mengirim hasil lokasi yang dipilih kembali ke halaman pilih lokasi
  final Function(LatLng position, String address) onLocationSelected;

  const PilihLokasiCariAlamatView({super.key, required this.onLocationSelected});

  @override
  State<PilihLokasiCariAlamatView> createState() =>
      _PilihLokasiCariAlamatViewState();
}

class _PilihLokasiCariAlamatViewState extends State<PilihLokasiCariAlamatView> {
  late PilihLokasiCariAlamatController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Provider.of<PilihLokasiCariAlamatController>(context, listen: false);
  }

  @override
  void dispose() {
    // Controller akan di-dispose dalam provider
    super.dispose();
  }

  // Fungsi untuk memilih hasil pencarian
  void _selectSearchResult(Map<String, dynamic> result) {
    final LatLng position = result['position'];
    final String address = result['address'];

    // Panggil callback untuk mengirim hasil kembali ke halaman pilih lokasi view
    widget.onLocationSelected(position, address);

    // Kembali ke halaman sebelumnya
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.whiteColor,
        title: Text(
          'Cari Alamat',
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: scaleHelper.scaleText(16),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Consumer<PilihLokasiCariAlamatController>(
              builder: (context, controller, child) {
                return TextField(
                  controller: controller.searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Cari alamat',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset(
                        'assets/icons/search.svg',
                        width: 15,
                        height: 15,
                        color: ColorConstant.blackColor,
                      ),
                    ),
                    suffixIcon:
                        controller.searchController.text.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                controller.clearSearchResults();
                              },
                            )
                            : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ColorConstant.primaryColor),
                    ),
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  onChanged: (value) {
                    controller.startSearch(value);
                  },
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      controller.searchPlaces(value);
                    }
                  },
                );
              }
            ),
          ),

          // Hasil pencarian
          Expanded(
            child: Consumer<PilihLokasiCariAlamatController>(
              builder: (context, controller, child) {
                return controller.isSearching
                    ? const Center(child: CircularProgressIndicator())
                    : controller.searchResults.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/search.svg',
                            width: 50,
                            height: 50,
                            color: ColorConstant.darkColor3,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            controller.searchController.text.isEmpty
                                ? 'Ketik untuk mencari alamat'
                                : 'Tidak ada hasil ditemukan',
                            style: TextStyleConstant.textStyleRegular.copyWith(
                              fontSize: scaleHelper.scaleText(14),
                              color: ColorConstant.darkColor3,
                            ),
                          ),
                        ],
                      ),
                    )
                    : ListView.separated(
                      padding: const EdgeInsets.only(top: 8),
                      itemCount: controller.searchResults.length,
                      separatorBuilder:
                          (context, index) =>
                              Divider(height: 1, color: Colors.grey[300]),
                      itemBuilder: (context, index) {
                        final result = controller.searchResults[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: ColorConstant.primaryColor
                                .withOpacity(0.1),
                            child: Icon(
                              Icons.location_on,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                          title: Text(
                            result['name'] ??
                                result['address'].split(',').first,
                            style: TextStyleConstant.textStyleSemiBold.copyWith(
                              fontSize: scaleHelper.scaleText(14),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            result['address'],
                            style: TextStyleConstant.textStyleRegular.copyWith(
                              fontSize: scaleHelper.scaleText(12),
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () => _selectSearchResult(result),
                        );
                      },
                    );
              }
            ),
          ),
        ],
      ),
    );
  }
}

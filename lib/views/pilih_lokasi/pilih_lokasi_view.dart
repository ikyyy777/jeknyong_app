import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/jual_sampah_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/jual_sampah_tanpa_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/pilih_lokasi_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';
import 'package:jeknyong_app/views/pilih_lokasi_cari_alamat/pilih_lokasi_cari_alamat_view.dart';

class PilihLokasiView extends StatefulWidget {
  const PilihLokasiView({super.key});

  @override
  State<PilihLokasiView> createState() => _PilihLokasiViewState();
}

class _PilihLokasiViewState extends State<PilihLokasiView> with WidgetsBindingObserver {
  late PilihLokasiController _lokasiController;

  @override
  void initState() {
    super.initState();
    // Tambahkan observer untuk lifecycle
    WidgetsBinding.instance.addObserver(this);
    
    _lokasiController = Provider.of<PilihLokasiController>(context, listen: false);
    
    // Inisialisasi renderer untuk Google Maps hanya jika belum diinisialisasi
    if (!_lokasiController.isRendererInitialized) {
      _lokasiController.initGoogleMapsRenderer();
    }

    // Mendapatkan lokasi saat ini hanya jika belum dilakukan atau jika posisi saat ini masih null
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_lokasiController.currentPosition == null) {
        _lokasiController.getCurrentLocation(context);
      }
    });
  }

  @override
  void dispose() {
    // Hapus observer lifecycle
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pastikan controller siap digunakan lagi jika ada perubahan dependencies
    // Jangan panggil di sini karena bisa dipanggil selama build
    // _lokasiController.prepareForReuse();
  }
  
  @override
  void didUpdateWidget(PilihLokasiView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Persiapkan controller ketika widget diupdate
    // Jangan panggil di sini karena bisa dipanggil selama build
    // _lokasiController.prepareForReuse();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Handle lifecycle events
    if (state == AppLifecycleState.resumed) {
      // Persiapkan controller ketika aplikasi kembali ke foreground
      _lokasiController.prepareForReuse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    // Hapus panggilan Future.microtask di sini karena sudah ada di initState dengan postFrameCallback
    // Future.microtask(() {
    //   _lokasiController.prepareForReuse();
    // });

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorConstant.whiteColor,
        title: Text(
          'Pilih Lokasi',
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: scaleHelper.scaleText(16),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<PilihLokasiController>(
        builder: (context, controller, child) {
          return Stack(
            children: [
              // Google Map - Area peta dikurangi 160dp untuk memberikan ruang bagi bottom sheet statis
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: scaleHelper.scaleHeight(
                  160,
                ), // Memberikan ruang untuk bottomsheet statis
                child:
                    controller.isLoading
                        ? Center(
                          child: CircularProgressIndicator(
                            color: ColorConstant.primaryColor,
                          ),
                        )
                        : GoogleMap(
                          initialCameraPosition: controller.initialPosition,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                          compassEnabled: true,
                          mapType: MapType.normal,
                          buildingsEnabled: true,
                          onMapCreated: (GoogleMapController mapController) {
                            try {
                              controller.mapController = mapController;

                              if (controller.currentPosition != null) {
                                mapController.animateCamera(
                                  CameraUpdate.newLatLngZoom(controller.currentPosition!, 15),
                                );
                              }

                              Future.delayed(const Duration(milliseconds: 500), () {
                                if (controller.mapController != null) {
                                  controller.mapController!.setMapStyle('[]');
                                }
                              });
                            } catch (e) {
                              print("Error pada pembuatan peta: $e");
                            }
                          },
                          onCameraMove: (CameraPosition position) {
                            controller.setCameraMoving(true);
                            controller.setSelectedPosition(position.target);
                          },
                          onCameraIdle: () {
                            controller.setCameraMoving(false);
                            controller.getAddressFromLatLng(controller.selectedPosition);
                          },
                        ),
              ),

              // Marker pusat tetap dengan posisi di ujung bawah marker sebagai titik lokasi
              if (!controller.isLoading)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: scaleHelper.scaleHeight(
                    160,
                  ), // Sesuaikan dengan bottom sheet
                  child: Center(
                    child: Container(
                      // Berikan margin bawah 20 untuk memastikan ujung bawah marker berada di tengah peta
                      margin: EdgeInsets.only(bottom: scaleHelper.scaleHeight(70)),
                      child: Transform.translate(
                        // Geser marker ke atas agar ujung bawah menjadi titik lokasi
                        offset: Offset(0, scaleHelper.scaleHeight(20)),
                        child: Icon(
                          Icons.location_on,
                          color:
                              controller.isCameraMoving
                                  ? Colors.grey
                                  : ColorConstant.primaryColor,
                          size: scaleHelper.scaleWidth(40),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 3,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // Status pencarian alamat
              if (!controller.isLoading && controller.isAddressLoading)
                Positioned(
                  top: scaleHelper.scaleHeight(16),
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaleHelper.scaleWidth(16),
                        vertical: scaleHelper.scaleHeight(8),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          scaleHelper.scaleWidth(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: scaleHelper.scaleWidth(16),
                            height: scaleHelper.scaleHeight(16),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                          SizedBox(width: scaleHelper.scaleWidth(8)),
                          Text(
                            'Mencari alamat...',
                            style: TextStyleConstant.textStyleRegular.copyWith(
                              fontSize: scaleHelper.scaleText(14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Tombol floating
              Positioned(
                right: scaleHelper.scaleWidth(16),
                bottom: scaleHelper.scaleHeight(
                  250,
                ), // Sesuaikan dengan bottom sheet
                child: Column(
                  children: [
                    FloatingActionButton(
                      heroTag: "btn1",
                      mini: true,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        controller.moveToCurrentPosition();
                      },
                      child: Icon(
                        Icons.my_location,
                        color: ColorConstant.primaryColor,
                        size: scaleHelper.scaleWidth(24),
                      ),
                    ),
                    SizedBox(height: scaleHelper.scaleHeight(8)),
                    FloatingActionButton(
                      heroTag: "btn2",
                      mini: true,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        // Navigasi ke halaman cari alamat
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PilihLokasiCariAlamatView(
                              // Kirim callback untuk menerima hasil posisi yang dipilih
                              onLocationSelected: (
                                LatLng position,
                                String address,
                              ) {
                                controller.setSelectedPosition(position);
                                controller.moveToPosition(position);
                                controller.getAddressFromLatLng(position);
                              },
                            ),
                          ),
                        ).then((_) {
                          // Dipanggil ketika kembali dari halaman PilihLokasiCariAlamat
                          print("PilihLokasiView: kembali dari halaman cari alamat");
                          
                          // Schedule penyiapan controller untuk frame berikutnya
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              _lokasiController.prepareForReuse();
                              
                              // Refresh map jika ada controller
                              if (_lokasiController.mapController != null && _lokasiController.currentPosition != null) {
                                _lokasiController.mapController!.animateCamera(
                                  CameraUpdate.newLatLngZoom(_lokasiController.currentPosition!, 15),
                                );
                              }
                            }
                          });
                        });
                      },
                      child: SvgPicture.asset(
                        'assets/icons/search.svg',
                        width: scaleHelper.scaleWidth(15),
                        height: scaleHelper.scaleHeight(15),
                        color: ColorConstant.blackColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Sheet Statis
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: scaleHelper.scaleHeight(230),
                  padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(scaleHelper.scaleWidth(16)),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul alamat
                      Text(
                        "Alamat",
                        style: TextStyleConstant.textStyleSemiBold.copyWith(
                          fontSize: scaleHelper.scaleText(16),
                        ),
                      ),
                      SizedBox(height: scaleHelper.scaleHeight(8)),
                      Text(
                        "${controller.selectedPosition.latitude.toStringAsFixed(6)}, ${controller.selectedPosition.longitude.toStringAsFixed(6)}",
                        style: TextStyleConstant.textStyleRegular.copyWith(
                          fontSize: scaleHelper.scaleText(12),
                        ),
                      ),

                      // Alamat atau loading
                      Container(
                        width: double.infinity,
                        height: scaleHelper.scaleHeight(70),
                        padding: EdgeInsets.symmetric(
                          vertical: scaleHelper.scaleHeight(4),
                        ),
                        child:
                            controller.isAddressLoading
                                ? Row(
                                  children: [
                                    SizedBox(
                                      width: scaleHelper.scaleWidth(20),
                                      height: scaleHelper.scaleHeight(20),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: ColorConstant.primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: scaleHelper.scaleWidth(12)),
                                    Text(
                                      "Mencari alamat...",
                                      style: TextStyleConstant.textStyleRegular
                                          .copyWith(
                                            fontSize: scaleHelper.scaleText(14),
                                          ),
                                    ),
                                  ],
                                )
                                : SingleChildScrollView(
                                  child: Text(
                                    controller.address,
                                    style: TextStyleConstant.textStyleRegular
                                        .copyWith(
                                          fontSize: scaleHelper.scaleText(14),
                                          color: ColorConstant.darkColor2,
                                        ),
                                  ),
                                ),
                      ),

                      // Tombol pilih lokasi
                      SizedBox(height: scaleHelper.scaleHeight(16)),
                      Consumer<PilihLokasiController>(
                        builder: (context, controller, child) {
                          return SizedBox(
                            width: double.infinity,
                            height: scaleHelper.scaleHeight(45),
                            child: ElevatedButton(
                              onPressed:
                                  controller.isAddressLoading
                                      ? null
                                      : () async {
                                        // Simpan alamat ke controller
                                        await controller.saveAddressToSharedPreferences();
                                        
                                        // Sinkronkan data dengan JualSampahTanpaDipilahController
                                        final jualTanpaDipilahController = Provider.of<JualSampahTanpaDipilahController>(
                                          context, 
                                          listen: false
                                        );
                                        
                                        // Coba dapatkan JualSampahDipilahController jika ada
                                        try {
                                          final jualDipilahController = Provider.of<JualSampahDipilahController>(
                                            context,
                                            listen: false
                                          );
                                          // Sinkronkan data dengan JualSampahDipilahController
                                          await jualDipilahController.syncAddressWithSharedPreferences();
                                        } catch (e) {
                                          // Jika controller tidak tersedia, abaikan
                                        }
                                        
                                        // Tunggu proses sinkronisasi selesai
                                        await jualTanpaDipilahController.syncAddressWithSharedPreferences();
                                        
                                        if (mounted) {
                                          Navigator.pop(context); // Kembali ke halaman sebelumnya
                                        }
                                      },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    scaleHelper.scaleWidth(10),
                                  ),
                                ),
                                disabledBackgroundColor: Colors.grey,
                              ),
                              child: Text(
                                "Pilih Lokasi",
                                style: TextStyleConstant.textStyleSemiBold.copyWith(
                                  fontSize: scaleHelper.scaleText(14),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/jual_sampah_tanpa_dipilah_controller.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class JualSampahFotoSampahWidget extends StatefulWidget {
  const JualSampahFotoSampahWidget({super.key});

  @override
  State<JualSampahFotoSampahWidget> createState() =>
      _JualSampahFotoSampahWidgetState();
}

class _JualSampahFotoSampahWidgetState extends State<JualSampahFotoSampahWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _showImageSourceDialog() async {
    final controller = context.read<JualSampahTanpaDipilahController>();
    
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeri'),
                onTap: () async {
                  Navigator.pop(context);
                  await _getImageFromGallery(controller);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Kamera'),
                onTap: () async {
                  Navigator.pop(context);
                  await _getImageFromCamera(controller);
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_copy),
                title: const Text('File'),
                onTap: () async {
                  Navigator.pop(context);
                  await _getFileFromPicker(controller);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImageFromGallery(JualSampahTanpaDipilahController controller) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      
      if (image != null) {
        controller.setFoto(image.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _getImageFromCamera(JualSampahTanpaDipilahController controller) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
      );
      
      if (image != null) {
        controller.setFoto(image.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _getFileFromPicker(JualSampahTanpaDipilahController controller) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      
      if (result != null && result.files.isNotEmpty && result.files.first.path != null) {
        controller.setFoto(result.files.first.path!);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    final controller = context.watch<JualSampahTanpaDipilahController>();
    final hasFoto = controller.form.isFotoValid;
    final imagePath = controller.form.fotoSampahPath;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bukti Foto Sampah",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(16),
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(12)),
            if (hasFoto)
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: scaleHelper.scaleHeight(200),
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: imagePath!.startsWith('assets') 
                            ? AssetImage(imagePath) as ImageProvider
                            : FileImage(File(imagePath)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => controller.removeFoto(),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: Container(
                  width: double.infinity,
                  height: scaleHelper.scaleHeight(100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ColorConstant.darkColor4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add, 
                        size: scaleHelper.scaleText(35), 
                        color: ColorConstant.darkColor4
                      ),
                    ],
                  ),
                ),
              ),
              
            if (hasFoto)
              TextButton(
                onPressed: _showImageSourceDialog,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit, color: ColorConstant.primaryColor),
                    SizedBox(width: 8),
                    Text(
                      "Ganti Foto",
                      style: TextStyleConstant.textStyleSemiBold.copyWith(
                        fontSize: scaleHelper.scaleText(14),
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              
            if (!hasFoto)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "* Harus ada foto sampah",
                  style: TextStyleConstant.textStyleRegular.copyWith(
                    fontSize: scaleHelper.scaleText(12),
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

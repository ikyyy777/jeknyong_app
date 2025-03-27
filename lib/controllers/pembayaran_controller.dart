import 'package:flutter/material.dart';

class Bank {
  final String id;
  final String name;
  final String icon;
  final String accountNumber;
  final String accountName;
  final String? description;

  Bank({
    required this.id,
    required this.name,
    required this.icon,
    required this.accountNumber,
    required this.accountName,
    this.description,
  });
}

class PaymentMethod {
  final String id;
  final String name;
  final String icon;
  final String type;
  final List<Bank>? banks;
  final String? instructions;
  final String? description;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    this.banks,
    this.instructions,
    this.description,
  });
}

class PembayaranController extends ChangeNotifier {
  String _selectedPaymentMethodId = "qris";
  String? _selectedBankId;

  String get selectedPaymentMethodId => _selectedPaymentMethodId;
  String? get selectedBankId => _selectedBankId;

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: "transfer_bank",
      name: "Transfer Bank",
      icon: "assets/icons/transfer_bank.svg",
      type: "bank_transfer",
      banks: [
        Bank(
          id: "bank_jateng",
          name: "Bank Jateng",
          icon: "assets/icons/bank_jateng.png",
          accountNumber: "123456789",
          accountName: "PT Jeknyong Indonesia",
          description: "Cabang Semarang",
        ),
        Bank(
          id: "bank_bri",
          name: "Bank BRI",
          icon: "assets/icons/bank_bri.png",
          accountNumber: "987654321",
          accountName: "PT Jeknyong Indonesia",
        ),
        Bank(
          id: "bank_mandiri",
          name: "Bank Mandiri",
          icon: "assets/icons/bank_mandiri.png",
          accountNumber: "567891234",
          accountName: "PT Jeknyong Indonesia",
        ),
        Bank(
          id: "qris",
          name: "QRIS",
          icon: "assets/icons/qris.png",
          accountNumber: "12345678901234",
          accountName: "PT Jeknyong Indonesia",
          description: "Scan QR code dengan aplikasi e-wallet atau mobile banking Anda",
        ),
      ],
    ),
    PaymentMethod(
      id: "cod",
      name: "Bayar di Tempat",
      icon: "assets/icons/bayar_ditempat.svg",
      type: "cod",
      description: "Pembayaran dilakukan saat barang sampai",
    ),
  ];

  bool get isCODSelected => _selectedPaymentMethodId == "cod";

  void selectCOD() {
    _selectedPaymentMethodId = "cod";
    _selectedBankId = null;
    notifyListeners();
  }

  void setSelectedPaymentMethod(String id) {
    _selectedPaymentMethodId = id;
    _selectedBankId = null; // Reset bank selection when payment method changes
    notifyListeners();
  }

  void setSelectedBank(String id) {
    _selectedBankId = id;
    notifyListeners();
  }

  PaymentMethod? get selectedPaymentMethod {
    try {
      return paymentMethods.firstWhere((method) => method.id == _selectedPaymentMethodId);
    } catch (e) {
      return null;
    }
  }

  Bank? get selectedBank {
    if (_selectedBankId == null || selectedPaymentMethod == null) {
      return null;
    }

    try {
      return selectedPaymentMethod!.banks?.firstWhere(
        (bank) => bank.id == _selectedBankId,
      );
    } catch (e) {
      return null;
    }
  }

  // Method untuk checkout
  Future<bool> processPayment({
    required double amount,
    required String orderNumber,
  }) async {
    // Simulasi proses pembayaran
    await Future.delayed(const Duration(seconds: 2));
    
    // Anggap selalu berhasil untuk data dummy
    return true;
  }
}

import 'package:flutter/material.dart';

class TarikSaldoController extends ChangeNotifier {
  // Data dummy untuk bank
  final List<Map<String, dynamic>> bankList = [
    {
      'id': '1',
      'name': 'Bank BCA',
      'code': 'BCA',
    },
    {
      'id': '2',
      'name': 'Bank Mandiri',
      'code': 'MANDIRI',
    },
    {
      'id': '3',
      'name': 'Bank BNI',
      'code': 'BNI',
    },
    {
      'id': '4',
      'name': 'Bank BRI',
      'code': 'BRI',
    },
  ];

  // Data dummy untuk e-wallet
  final List<Map<String, dynamic>> eWalletList = [
    {
      'id': '1',
      'name': 'DANA',
      'code': 'DANA',
    },
    {
      'id': '2',
      'name': 'OVO',
      'code': 'OVO',
    },
    {
      'id': '3',
      'name': 'GoPay',
      'code': 'GOPAY',
    },
    {
      'id': '4',
      'name': 'ShopeePay',
      'code': 'SHOPEEPAY',
    },
  ];

  // Selected values
  String? selectedBank;
  String? selectedEWallet;
  String bankAccountNumber = '';
  String eWalletNumber = '';
  String withdrawalAmount = '';
  bool isWithdrawAll = false;
  bool isEWalletWithdrawAll = false;

  // Getter untuk saldo saat ini (dummy)
  double get currentBalance => 134000;

  // Methods untuk update values
  void updateSelectedBank(String? value) {
    selectedBank = value;
    notifyListeners();
  }

  void updateSelectedEWallet(String? value) {
    selectedEWallet = value;
    notifyListeners();
  }

  void updateBankAccountNumber(String value) {
    bankAccountNumber = value;
    notifyListeners();
  }

  void updateEWalletNumber(String value) {
    eWalletNumber = value;
    notifyListeners();
  }

  void updateWithdrawalAmount(String value) {
    if (!isWithdrawAll && !isEWalletWithdrawAll) {
      withdrawalAmount = value;
      notifyListeners();
    }
  }

  void toggleWithdrawAll(bool value) {
    isWithdrawAll = value;
    if (value) {
      withdrawalAmount = currentBalance.toString();
    } else {
      withdrawalAmount = '';
    }
    notifyListeners();
  }

  void toggleEWalletWithdrawAll(bool value) {
    isEWalletWithdrawAll = value;
    if (value) {
      withdrawalAmount = currentBalance.toString();
    } else {
      withdrawalAmount = '';
    }
    notifyListeners();
  }

  // Validasi form
  bool isFormValid() {
    if (withdrawalAmount.isEmpty) return false;
    
    final amount = double.tryParse(withdrawalAmount);
    if (amount == null || amount <= 0 || amount > currentBalance) return false;

    // Validasi form bank
    if (selectedBank != null) {
      if (bankAccountNumber.isEmpty || bankAccountNumber.length < 10) return false;
      return true;
    }

    // Validasi form e-wallet
    if (selectedEWallet != null) {
      if (eWalletNumber.isEmpty || eWalletNumber.length < 10) return false;
      return true;
    }

    return false;
  }

  // Mendapatkan pesan error
  String? getErrorMessage() {
    if (withdrawalAmount.isEmpty) {
      return 'Nominal penarikan harus diisi';
    }

    final amount = double.tryParse(withdrawalAmount);
    if (amount == null || amount <= 0) {
      return 'Nominal penarikan tidak valid';
    }

    if (amount > currentBalance) {
      return 'Saldo tidak mencukupi';
    }

    // Validasi form bank
    if (selectedBank != null) {
      if (bankAccountNumber.isEmpty) {
        return 'Nomor rekening harus diisi';
      }
      if (bankAccountNumber.length < 10) {
        return 'Nomor rekening tidak valid';
      }
    }

    // Validasi form e-wallet
    if (selectedEWallet != null) {
      if (eWalletNumber.isEmpty) {
        return 'Nomor e-wallet harus diisi';
      }
      if (eWalletNumber.length < 10) {
        return 'Nomor e-wallet tidak valid';
      }
    }

    return null;
  }
}
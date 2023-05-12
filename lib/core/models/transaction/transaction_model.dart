import 'package:vitaflow/core/models/api/api_result_model.dart';

class TransactionModel extends Serializable {
  final num grossAmount;
  final String transactionId;
  final String paymentType;
  final String bank;
  final String vaNumber;
  final int expireTimeUnix;
  final String expireTimeStr;
  final String serviceName;
  final int status; 

  TransactionModel({
    required this.grossAmount,
    required this.transactionId,
    required this.paymentType,
    required this.bank,
    required this.vaNumber,
    required this.expireTimeUnix,
    required this.expireTimeStr,
    required this.serviceName,
    required this.status, 
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        grossAmount: json['gross_amount'] ,
        transactionId: json['transaction_id'] ?? "",
        paymentType: json['payment_type'] ?? "",
        bank: json['bank'] ?? "",
        vaNumber: json['va_number'] ?? "",
        expireTimeUnix: json['expire_time_unix'] ?? 0,
        expireTimeStr: json['expire_time_str'] ?? "",
        serviceName: json['service_name'] ?? "",
        status: json['payment_status'] ?? 2,

      );


  @override
  Map<String, dynamic> toJson() => {
        "gross_amount": grossAmount,
        "transaction_id": transactionId,
        "payment_type": paymentType,
        "bank": bank,
        "va_number": vaNumber,
        "expire_time_unix": expireTimeUnix,
        "expire_time_str": expireTimeStr,
        "service_name": serviceName,
        "payment_status": status,
      };
}

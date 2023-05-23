import 'dart:convert';

List<Item> itemFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  Item({
    required this.billno,
    required this.date,
    required this.suppliersAddress,
    required this.specification,
    required this.rate,
    required this.quantity,
    required this.totalAmount,
    required this.qrcodeno,
    required this.remarks,
    required this.supplierscontact,
    required this.suppliersemail,
    required this.fundedby,
    required this.warrantystatus,
  });

  String billno;
  String date;
  String suppliersAddress;
  String specification;
  int rate;
  int quantity;
  int totalAmount;
  String qrcodeno;
  String remarks;
  String supplierscontact;
  String suppliersemail;
  String fundedby;
  String warrantystatus;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        billno: json["billno"],
        date: json["date"],
        suppliersAddress: json["suppliers_address"],
        specification: json["specification"],
        rate: json["rate"],
        quantity: json["quantity"],
        totalAmount: json["total_amount"],
        qrcodeno: json["qrcodeno"],
        remarks: json["remarks"],
        supplierscontact: json["suppliers_contact"],
        suppliersemail: json["suppliers_email"],
        fundedby: json["fundedby"],
        warrantystatus: json["warranty_status"],
      );

  Map<String, dynamic> toJson() => {
        "billno": billno,
        "date": date,
        "suppliers_address": suppliersAddress,
        "specification": specification,
        "rate": rate,
        "quantity": quantity,
        "total_amount": totalAmount,
        "qrcodeno": qrcodeno,
        "remarks": remarks,
        "suppliers_contact": supplierscontact,
        "suppliers_email": suppliersemail,
        "fundedby": fundedby,
        "warranty_status": warrantystatus,
      };
}

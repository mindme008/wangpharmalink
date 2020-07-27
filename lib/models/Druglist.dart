import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';

class Druglist{
  final int id;
  final String drug, time, indication, description, imageSrc;
  final Color color;

  Druglist(
  {this.id,
    this.drug,
    this.time,
    this.indication,
    this.description,
    this.imageSrc,
    this.color});

}

List<Druglist> druglist = [
  Druglist(
    id: 1,
    drug: "Omeprazole",
    time: "8.00 AM",
    indication:"ลดการหลั่งกรดในกระเพาะ รักษาแผลในกระเพาะอาหาร",
    description: "ก่อนอาหาร 30 นาที กลืนทั้งเม็ด",
    imageSrc: "assets/icons/pills.svg",
    color: kPrimaryColor,
  ),
  Druglist(
    id: 2,
    drug: "Domperidone",
    time: "",
    indication:"",
    description: "",
    imageSrc: "assets/icons/pills.svg",
    color: kPrimaryColor,
  ),
  Druglist(
    id: 3,
    drug: "Domperidone",
    time: "before breakfast lunch dinner",
    indication:"antiemetic",
    description: "",
    imageSrc: "assets/icons/pills.svg",
    color: kPrimaryColor,
  ),
];

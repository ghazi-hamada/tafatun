import 'dart:io';

import 'package:flutter/services.dart';
import 'package:tafatun/core/Methods/timestamptotime.dart';
import 'package:tafatun/core/constant/image_assets.dart';
import 'package:tafatun/helper/pdf_helper.dart';
import 'package:tafatun/model/medicine_model.dart';
import 'package:pdf/widgets.dart';

final titles = <String>[
  'اسم الدواء',
  'الاسم المختصر للدواء',
  'جرعة الدواء',
  'تاريخ تناول الدواء',
  'وقت تناول الدواء',
  '؟تناوله',
];

class PdfInvoicePdfHelper {
  static late Font arFont;
  static init() async {
    arFont = Font.ttf(
        (await rootBundle.load("assets/fonts/Amiri/Amiri-Regular.ttf")));
  }

  static Future<File> generate(List<MedicineModel> model) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: arFont,
        ),
        build: (context) => [
          Header(
            level: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('لسجل الطبي '),
                Text(
                  'التاريخ: ${DateTime.now().toString().split(' ')[0]}',
                ),
              ],
            ),
          ),
          Table(
            border: TableBorder.all(),
            children: [
              buildRowTable(titles, isHeader: true),
              ...model.map(
                (item) => buildRowTable(
                  [
                    '${item.nameMedicine}',
                    '${item.nameMedicineShort}',
                    '${item.doseMedicine}',
                    (formatTimestampToDate(item.startdate!)),
                    item.takeMedicine!
                        ? (timestampToTime(item.datereminder!))
                        : " ",
                    takeMedicine(item.takeMedicine!),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return PdfHelper.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static TableRow buildRowTable(List<String> cells, {bool isHeader = false}) =>
      TableRow(
          children: cells.map((e) {
        final style = TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          // fontSize: isHeader ? 13 : 11,
          font: arFont,
        );
        return Padding(
            padding: const EdgeInsets.all(5),
            child: Center(child: Text(e, style: style)));
      }).toList());
  static String takeMedicine(bool takeMedicine) {
    if (takeMedicine) {
      return "تم تناوله";
    } else {
      return "لم يتم تناوله";
    }
  }

  static Row bodyTable({required String title}) {
    return Row(children: [
      SizedBox(width: 7.8),
      Text(
        title,
        textAlign: TextAlign.center,
      ),
      SizedBox(width: 7.8),
    ]);
  }
}

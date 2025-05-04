import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generatePdfReport(BuildContext context, String resultText) async {
  final pdf = pw.Document();

  final lines = resultText.trim().split('\n');

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(20),
      build: (context) {
        List<pw.Widget> content = [];

        content.add(
          pw.Text(
            'CodeSense.ai - Static Code Analysis Report',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
        );

        content.add(pw.SizedBox(height: 16));

        for (var line in lines) {
          line = line.trim();

          if (line.startsWith('###')) {
            content.add(pw.Padding(
              padding: const pw.EdgeInsets.only(top: 12, bottom: 4),
              child: pw.Text(
                line.replaceFirst('###', '').trim(),
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
            ));
          } else if (line.startsWith('-')) {
            content.add(
              pw.Bullet(
                text: line.replaceFirst('-', '').trim(),
                style: pw.TextStyle(fontSize: 12),
              ),
            );
          } else if (line.startsWith('```') || line.endsWith('```')) {
            // Skip code block markers
            continue;
          } else if (line.isNotEmpty) {
            content.add(pw.Text(
              line,
              style: pw.TextStyle(fontSize: 12),
            ));
            content.add(pw.SizedBox(height: 6));
          }
        }

        return content;
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

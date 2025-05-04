import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AnalysisResultScreen extends StatelessWidget {
  final String resultText;
  const AnalysisResultScreen({super.key, required this.resultText});

  // 👇 This function now uses the instance variable `resultText`
  void _generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    final htmlText = md.markdownToHtml(resultText);
    final plainText = htmlText.replaceAll(RegExp(r'<[^>]*>'), '');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Container(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('CodeSense.ai - Static Code Analysis Report',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 12),
              pw.Text(plainText,
                  style: pw.TextStyle(fontSize: 12, lineSpacing: 5)),
            ],
          ),
        ),
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CodeSense.ai - Analysis Result"),
        //backgroundColor: Colors.deepPurpleAccent,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.download),
        //     tooltip: 'Download PDF',
        //     onPressed: () => _generatePdf(context),
        //   ),
        //   // FloatingActionButton.extended(
        //   //   onPressed: () => _generatePdf(context),
        //   //   icon: Icon(Icons.download),
        //   //   label: Text('Download Report'),
        //   //   backgroundColor: Colors.deepPurpleAccent,
        //   // ),
        // ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF232526), Color(0xFF414345)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Markdown(
            data: resultText,
            styleSheet: MarkdownStyleSheet(
              h1: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              h2: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              h3: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              p: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
              code: GoogleFonts.sourceCodePro(
                  fontSize: 13, color: Colors.lightGreenAccent),
              listBullet:
                  GoogleFonts.poppins(fontSize: 14, color: Colors.white),
              blockquote: GoogleFonts.poppins(
                  fontStyle: FontStyle.italic, color: Colors.white54),
              codeblockDecoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:storycraft/API/firebaseDeepLinking.dart';
import 'package:storycraft/screens/afterAuth/CreateMDFile.dart';
import 'package:storycraft/screens/afterAuth/previewScreen.dart';

import '../Providers/Md.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


class PressedMDCard extends StatelessWidget {
  int inde;

  PressedMDCard({super.key, required this.inde});

  @override
  Widget build(BuildContext context) {
    MDProvider MDProvid = Provider.of<MDProvider>(context);
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0, // soften the shadow
            spreadRadius: 2.0, //extend the shadow
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(createRoute("edit",context));
              },
              icon: const Icon(
                Icons.edit,
              )),
          IconButton(
              onPressed: () {
                MDProvid.deleteMD(MDProvid.filteredMD(MDProvid.Query)[inde]);
                MDProvid.updateIndx(-1);
                MDProvid.changelong();
              },
              icon: const Icon(
                Icons.delete,
              )),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(createRoute("preview",context));
                // MDProvid.changelong() ;
              },
              icon: const Icon(
                Icons.preview_rounded,
              )),
          IconButton(
              onPressed: () async{
                String generatedLink =await FirebaseDynamicLink.createLink(MDProvid.filteredMD(MDProvid.Query)[inde]) ;
                await Future.delayed(Duration(milliseconds: 300));
                Share.share(generatedLink) ;
              },
              icon: const Icon(
                Icons.share,
              )),
          IconButton(
              onPressed: () async {
                // Markdown(data: "${MDProvid.filteredMD(MDProvid.Query)[inde].details}",)  ;
                final pdf = pw.Document();

                pdf.addPage(pw.MultiPage(
                  pageFormat: PdfPageFormat.a4,
                  margin: pw.EdgeInsets.all(32),
                  build: (pw.Context context) {
                    return <pw.Widget>[
                      pw.Header(
                          level: 0,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: <pw.Widget>[
                                pw.Text("${MDProvid.filteredMD(MDProvid.Query)[inde].heading}", textScaleFactor: 2),
                              ])),


                      // Write All the paragraph in one line.
                      // For clear understanding
                      // here there are line breaks.

                      pw.Paragraph(text:"${MDProvid.filteredMD(MDProvid.Query)[inde].details}", ),
                    ];
                  },
                ));
                // On Flutter, use the [path_provider](https://pub.dev/packages/path_provider) library:
                Uint8List tem = await pdf.save();
                saveLocally(tem);
              },
              icon: const Icon(
                Icons.picture_as_pdf_rounded,
              )),
        ],
      ),
    );
  }

  void saveLocally(Uint8List pngBytes) async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String fullPath = '$dir/${DateTime.now().millisecond}.pdf';
    File capturedpdfFile = File(fullPath);
    var fg = await capturedpdfFile.writeAsBytes(pngBytes);
    print(fg);

    await Future.delayed(Duration(milliseconds: 300));
    await Share.shareXFiles([XFile(fullPath)]);
  }

  Route createRoute(String st,BuildContext context) {
    MDProvider MDProvid = Provider.of<MDProvider>(context,listen: false) ;
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => (st == "edit")
          ? CreateMD(
              md: Provider.of<MDProvider>(context).filteredMD(MDProvid.Query)[inde],
            )
          : PreviewScreen(
              MDString:
                  "${MDProvid.filteredMD(MDProvid.Query)[inde].details}",
              head: "${MDProvid.filteredMD(MDProvid.Query)[inde].heading}",
              dat: "${MDProvid.filteredMD(MDProvid.Query)[inde].date}",
            ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

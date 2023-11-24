import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:rent_flex/models/contract.dart';
import 'package:rent_flex/models/property.dart';
import 'package:rent_flex/models/transaction.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../api/firebase/firebase_core.dart';
import '../../../models/payment.dart';
import '../widget/save_file_mobile.dart';

class PaymentDetailsController extends GetxController {
  FirebaseCore firebaseCore = FirebaseCore.instance;

  late Property property;
  late Payment payment;

  RxList<Transaction> transactions = <Transaction>[].obs;

  void setTransactions(List<Transaction> transactions) {
    this.transactions.value = transactions;
  }

  List months = [
    "january".tr,
    "february".tr,
    "march".tr,
    "april".tr,
    "may".tr,
    "june".tr,
    "july".tr,
    "august".tr,
    "september".tr,
    "october".tr,
    "november".tr,
    "december".tr
  ];

  List<String> months_fr = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre"
  ];

  String getMonth(int index) {
    return index==1?"Janvier":index==2?"Février":index==3?"Mars":index==4?"Avril":index==5?"Mai":index==6?"Juin":index==7?"Juillet":index==8?"Août":index==9?"Septembre":index==10?"Octobre":index==11?"Novembre":"Décembre";
  }

  @override
  void onInit() {
    payment = Get.arguments[0];
    property = Get.arguments[1];

    // uid= Get.arguments[0];
    // propertyName= Get.arguments[1];
    // contractId= Get.arguments[2];

    super.onInit();
  }
  void navigateBack() => Get.back();

  Future<void> generatePDF() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(252, 203, 12)));
    //Generate PDF grid.
    final PdfGrid grid = _getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult result = _drawHeader(page, pageSize, grid);
    //Draw grid
    _drawGrid(page, grid, result);
    //Add invoice footer
    _drawFooter(page, pageSize);
    //Save and dispose the document.
    final List<int> bytes = await document.save();
    document.dispose();
    //Launch file.
    await saveAndLaunchFile(bytes, 'Quittance.pdf');
  }

  //Draws the invoice header
  PdfLayoutResult _drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(255, 203, 12)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));
    //Draw string
    page.graphics.drawString(
        'Quittance', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    final Uint8List imageData = base64Decode(entrepriseImage);
    //Load the image using PdfBitmap.
    final PdfBitmap image = PdfBitmap(imageData);
    page.graphics.drawImage(
      image, Rect.fromLTWH(410, 10, 80, 75),
    );

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('amount'.tr, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(800, 0, pageSize.width - 800, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final String invoiceNumber = 'N°: ${payment.uid}\r\n\r\nDate: ' + payment.monthlyDate.toString();
    final Size contentSize = contentFont.measureString(invoiceNumber);
    String address =
        'Immobilier : \r\n\r\n${property.name} \r\n\r\n Loyé de: ${getMonth(payment.monthlyDate?.month??0).toString()} ${payment.monthlyDate!.year} \r\n\r\n Locataire: ${payment.fromNumber} \r\n\r\n'+'Propriétaire ${payment.toNumber}';
    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));
    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

  //Draws the grid
  void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
    //Draw grand total.
    page.graphics.drawString('Total:',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 10,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString('${double.parse(payment.amount).toStringAsFixed(0)} FCFA',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));
    page.graphics.drawString('Restant:',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds!.left,
            result.bounds.bottom + 20,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
    page.graphics.drawString('${(property.price- (double.parse(payment.amount))).toStringAsFixed(0)} FCFA',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 20,
            totalPriceCellBounds!.width,
            totalPriceCellBounds!.height));

  }

  //Draw the invoice footer data.
  void _drawFooter(PdfPage page, Size pageSize,) {
    final PdfPen linePen =
    PdfPen(PdfColor(252, 203, 12), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));
     String footerContent =
        '${property!.country} ${property!.department},.\r\n\r\n${property.neighborhood}, ${property.address}\r\n\r\n${property.description}';
    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid _getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 3);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(252, 203, 12));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'TransactionId';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Date';
    headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[2].value = 'Montant';
    headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.center;

    for(int i = 0; i < transactions.length; i++){
      addTransaction(transactions[i].uid, transactions[i].createdAt, transactions[i].amount, grid);
    }

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent4);
    // grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addTransaction(String id, DateTime date, String amount, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = id;
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[1].value = date.toString();
    row.cells[1].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[2].value = double.parse(amount).toStringAsFixed(0)+' F CFA';
    row.cells[2].stringFormat.alignment = PdfTextAlignment.center;

  }

  //Get the total amount.
  double _getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value =
      grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return total;
  }

  final entrepriseImage = "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";
}

import 'package:get/get.dart';
import 'package:mybeshop/features/main/domain/entities/e_invoice.dart';
import 'package:mybeshop/features/main/domain/usecases/get_e_invoice_use_case.dart';

class EInvoiceController extends GetxController {
  final GetEInvoiceUseCase _getEInvoiceUseCase;
  final String invoiceNo;

  EInvoiceController(this._getEInvoiceUseCase, this.invoiceNo);

  RxBool eInvoiceLoading = false.obs;
  EInvoice? eInvoice;

  Future<void> getEInvoice() async {
    eInvoiceLoading(true);
    update();
    final response =
        await _getEInvoiceUseCase(filters: {"order_no": invoiceNo});
    response.fold((failure) {
      eInvoiceLoading(false);
      update();
    }, (success) {
      eInvoice = success;
      eInvoiceLoading(false);
      update();
    });
  }

  @override
  void onInit() {
    getEInvoice();
    super.onInit();
  }
}

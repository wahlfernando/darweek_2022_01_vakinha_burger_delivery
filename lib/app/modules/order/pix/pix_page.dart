import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vakinha_burger_mobile/app/core/ui/formater_helper.dart';
import 'package:vakinha_burger_mobile/app/core/ui/widgets/vakinha_appbar.dart';
import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/app/models/order_pix.dart';

class PixPage extends StatelessWidget {

  final OrderPix _orderPix = Get.arguments;

  PixPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var qrCode = Uri.parse(_orderPix.image).data;

    return Scaffold(
      appBar: VakinhaAppbar(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Valor a Pagar', style: context.textTheme.headlineMedium),
                Text(FormaterHelper.formatCurrency(_orderPix.totalValue),
                    style: context.textTheme.titleLarge?.copyWith(
                        color: context.theme.primaryColorDark,
                        fontWeight: FontWeight.bold)),
                Image.memory(
                  qrCode!.contentAsBytes(),
                  width: context.widthTransformer(reducedBy: 50),
                  height: context.heightTransformer(reducedBy: 50),
                ),
                TextButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _orderPix.code));
                    Get.rawSnackbar(message: 'Código PIX copiado!', snackPosition: SnackPosition.BOTTOM);
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  child:  Text(
                    'PIX Copia e Cola',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontSize: 30,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dotted
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

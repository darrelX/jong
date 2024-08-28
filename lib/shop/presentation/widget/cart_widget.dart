import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shop/logic/cubit/product_cubit.dart';

import 'preview_widget.dart';
import 'product_widget.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key, required this.state});
  final ProductUpdatedState state;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final instance = context.read<ProductProvider>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // ignore: prefer_const_constructors
          PreviewWidget(
            padding: EdgeInsets.zero,
          ),
          const Gap(20),
          Expanded(
              child: ListView.builder(
                  itemCount: widget.state.products.length,
                  itemBuilder: (BuildContext context, int _) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProductWidget(
                          isShop: true,
                          state: widget.state,
                          id: "${widget.state.products[_].id}",
                          image: 'assets/images/1000.png',
                          title: widget.state.products[_].name!,
                          price: widget.state.products[_].price!,
                          quantity: 10,
                          // controller: controller['id'],
                        ),
                      ],
                    );
                  }))
        ],
      ),
    );
  }
}

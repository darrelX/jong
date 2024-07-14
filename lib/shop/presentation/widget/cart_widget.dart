import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/utils/const.dart';
import 'package:jong/shop/logic/courter_model.dart';

import 'preview_widget.dart';
import 'product_widget.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({
    super.key,
  });

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final instance = context.read<CounterModel>();

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
                  itemCount: instance.articles['items'].length,
                  // separatorBuilder: (BuildContext context, int index) =>
                  //     const Gap(20),
                  itemBuilder: (BuildContext context, int _) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProductWidget(
                          isShop: true,
                          id: instance.articles['items'][_]['id'],
                          image: 'assets/images/1000.png',
                          title: instance.articles['items'][_]['title'],
                          price: instance.articles['items'][_]['price'],
                          quantity: instance.articles['items'][_]['quantity'],
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
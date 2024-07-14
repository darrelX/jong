// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shop/logic/courter_model.dart';
import 'package:jong/shop/presentation/widget/cart_widget.dart';
import 'package:provider/provider.dart';
import '../widget/preview_widget.dart';
import '../widget/shop_home_widget.dart';

@RoutePage()
class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterModel>(builder: (context, value, child) {
      return Scaffold(
          body: DraggableBottomSheet(
        minExtent: 175,
        useSafeArea: false,
        curve: Curves.easeIn,
        previewWidget: PreviewWidget(),
        expandedWidget: CartWidget(),
        backgroundWidget: ShopHomeWidget(),
        maxExtent: context.height * 0.8,
        onDragging: (pos) {},
      ));
    });
  }
}

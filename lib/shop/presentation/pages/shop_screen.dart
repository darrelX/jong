import 'package:auto_route/auto_route.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shop/presentation/widget/cart_widget.dart';
import '../widget/preview_widget.dart';
import '../widget/shop_home_widget.dart';

@RoutePage()
class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableBottomSheet(
        minExtent: 175,
        useSafeArea: false,
        curve: Curves.easeIn,
        previewWidget: const PreviewWidget(),
        expandedWidget: const CartWidget(),
        backgroundWidget: const ShopHomeWidget(),
        maxExtent: context.height * 0.8,
        onDragging: (pos) {},
      ),
    );
  }
}

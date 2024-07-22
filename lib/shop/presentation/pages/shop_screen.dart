// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shop/logic/product_provider.dart';
import 'package:jong/shop/presentation/widget/cart_widget.dart';
import 'package:provider/provider.dart';
import '../widget/preview_widget.dart';
import '../widget/shop_home_widget.dart';

@RoutePage()
class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  
  Future<void> _refresh() async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print
    return Consumer<ProductProvider>(builder: (context, value, child) {
      print("statet ${value.state}");
      switch (value.state) {
        case LoadingState.loading:
          return Center(
            child: Transform.scale(
              scale: 2, // Réduire de moitié la taille du widget
              child: const CircularProgressIndicator(),
            ),
          );
        case LoadingState.success:
          return Scaffold(
              body: RefreshIndicator(
            onRefresh: _refresh,
            child: DraggableBottomSheet(
              minExtent: 175.h,
              useSafeArea: false,
              curve: Curves.easeIn,
              previewWidget: PreviewWidget(),
              expandedWidget: CartWidget(),
              backgroundWidget: ShopHomeWidget(),
              maxExtent: context.height * 0.8,
              onDragging: (pos) {},
            ),
          ));
        case LoadingState.error:
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Échec du chargement. Veuillez réessayer."),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _refresh,
                  child: Text(
                    "Réessayer",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        case LoadingState.initial:
        default:
          return Center(
            child: Text("Préparation en cours..."),
          );
      }
    });
  }
}

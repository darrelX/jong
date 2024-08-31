// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shop/logic/cubit/product_cubit.dart';
import 'package:jong/shop/presentation/widget/cart_widget.dart';
import '../widget/preview_widget.dart';
import '../widget/shop_home_widget.dart';

@RoutePage()
class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ProductCubit cubit = getIt.get<ProductCubit>();

  Future<void> _refresh() async {
    await cubit.fetchProducts();
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
    return BlocBuilder<ProductCubit, ProductState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return Scaffold(
              body: Center(
                child: Transform.scale(
                  scale: 2, // Réduire de moitié la taille du widget
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (state is ProductUpdatedState) {
            return Scaffold(
                body: DraggableBottomSheet(
              minExtent: 175.h,
              useSafeArea: false,
              curve: Curves.easeIn,
              previewWidget: PreviewWidget(),
              expandedWidget: CartWidget(
                state: state,
              ),
              backgroundWidget: ShopHomeWidget(
                state: state,
              ),
              maxExtent: context.height * 0.8,
              onDragging: (pos) {},
            ));
          }

          if (state is ProductFailure) {
            return Scaffold(
              body: Center(
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
              ),
            );
          }

          return Scaffold(
            body: Center(
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
            ),
          );
        });
  }
}

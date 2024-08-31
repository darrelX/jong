import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/utils/const.dart';
import 'package:jong/shop/logic/cubit/product_cubit.dart';
import 'package:jong/shop/presentation/widget/product_widget.dart';

class ShopHomeWidget extends StatefulWidget {
  const ShopHomeWidget({super.key, required this.state});
  final ProductUpdatedState state;

  @override
  State<ShopHomeWidget> createState() => _ShopHomeWidgetState();
}

class _ShopHomeWidgetState extends State<ShopHomeWidget> {
  final ProductCubit _cubit = getIt.get<ProductCubit>();

  Future<void> _refresh() async {
    await _cubit.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: padding16,
          right: padding16,
          top: padding16,
          bottom: 180.h,
        ),
        width: context.width,
        child: RefreshIndicator(
          onRefresh: _cubit.fetchProducts,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Boissons disponibles",
                style: context.textTheme.headlineMedium?.copyWith(
                  fontSize: 22,
                ),
              ),
              Gap(30.h),
              Expanded(
                  child: (widget.state.products.isNotEmpty)
                      ? ListView.separated(
                          itemBuilder: (BuildContext context, int _) {
                            return ProductWidget(
                              isShop: false,
                              state: widget.state,
                              id: "${widget.state.products[_].id}",
                              image: 'assets/images/1000.png',
                              title: widget.state.products[_].name!,
                              price: widget.state.products[_].price!,
                              quantity: 10,
                              // controller: controller['id'],
                            );
                          },
                          separatorBuilder: (context, i) => Gap(15.h),
                          itemCount: widget.state.products.length)
                      : Expanded(
                          child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Aucun produit"),
                              SizedBox(
                                height: 20.h,
                              ),
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
                        )))
            ],
          ),
        ),
      ),
    );
  }
}

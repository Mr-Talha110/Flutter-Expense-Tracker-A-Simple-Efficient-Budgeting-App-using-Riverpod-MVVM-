import 'package:expense_tracker_app/core/utils/app_assets.dart';
import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_router.dart';
import 'package:expense_tracker_app/presentation/views/transaction_list_screen.dart';
import 'package:expense_tracker_app/presentation/widgets/bottom_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexProvider = StateProvider<int>((ref) => 1);

class BottomNavigationScreen extends ConsumerStatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  ConsumerState<BottomNavigationScreen> createState() =>
      _BottomNavigationScreenState();
}

class _BottomNavigationScreenState
    extends ConsumerState<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentIndexProvider);

    Widget screens() {
      switch (currentIndex) {
        case 0:
          return Center(child: Text('Home Screen'));
        case 1:
          return TransactionlistScreen();
        case 2:
          return Center(child: Text('Wallet Screen'));
        case 3:
          return Center(child: Text('Settings Screen'));
        default:
          return Container();
      }
    }

    final List<String> bottomNavIcon = [
      AppAssets.homeIcon,
      AppAssets.calenderIcon,
      AppAssets.walletIcon,
      AppAssets.moreIcon,
    ];

    return Scaffold(
      body: screens(),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          padding: EdgeInsets.only(bottom: 10),
          elevation: 0.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 35,
                      right: 35,
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                          bottomNavIcon.length,
                          (index) => BottomNavItem(
                            secondItem: index == 2,
                            isSelected: currentIndex == index,
                            onTap: () => ref
                                .read(currentIndexProvider.notifier)
                                .state = index,
                            icon: bottomNavIcon[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => AppRouter.push(AppRouter.addTransaction),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.pink,
                      child: Icon(
                        Icons.add,
                        color: AppColors.black,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

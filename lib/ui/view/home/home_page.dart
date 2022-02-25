import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/ui/view/card_widget/patient_info_widget.dart';
import 'package:curiumlife/ui/view/home/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:stacked/stacked.dart';
import 'homepage_view_model.dart';

class HomePage extends ViewModelBuilderWidget<HomePageViewModel> {
  @override
  void onViewModelReady(HomePageViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.init();
  }

  @override
  HomePageViewModel viewModelBuilder(BuildContext context) =>
      HomePageViewModel();
  int touchedIndex = -1;

  @override
  Widget builder(
      BuildContext context, HomePageViewModel viewModel, Widget? child) {
    return Scaffold(
      body: viewModel.state == ViewState.Busy
          ? Container(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColor.primary,
                ),
              ),
            )
          : design3(context, viewModel),

      // getBody(context, viewModel),
    );
  }

  design3(context, viewModel) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  delegate: CustomAppBar(viewModel),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 5,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 11, left: 11, bottom: 50),
                    child: AnimationLimiter(
                      child: GridView.count(
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: .94,
                        primary: false,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8.0),
                        crossAxisCount: 2,
                        children: List.generate(
                          viewModel.patientsList.length,
                          (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: 2,
                              position: index,
                              duration: Duration(milliseconds: 500),
                              child: ScaleAnimation(
                                scale: 0.5,
                                child: FadeInAnimation(
                                  child: PatientInfoWidget(
                                    viewModel.patientsList[index],
                                    onTap: (PatientModel model) {
                                      viewModel.deleteFuntion(model);
                                    },
                                    // callback(viewModel,viewModel.patientsList[index])
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                  ),
                )
              ],
            ))
      ],
    );
  }

  callback() async {
    print("hellow world");
    // // remove particular model in db
    // await BaseTable<PatientModel>().delete(model.patientUniqID!,model);
    // await locator<HomePageViewModel>().fetchData();
    // viewModel.notifyListeners();
  }
}

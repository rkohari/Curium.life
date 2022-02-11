import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/ui/view/search/search_screen_view_model.dart';
import 'package:curiumlife/ui/view/widget/patient_info_widget.dart';
import 'package:curiumlife/ui/widgets/edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends ViewModelBuilderWidget<SearchViewModel> {
  @override
  void onViewModelReady(SearchViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  SearchViewModel viewModelBuilder(BuildContext context) => SearchViewModel();

  @override
  Widget builder(
      BuildContext context, SearchViewModel viewModel, Widget? child) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: EditTextField(
          "",
          viewModel.searchController,
          placeholder: "Seach Patients",
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 13, right: 8),
            child: Image(
              image: AssetImage(Images.ic_search),
              width: 17,
              height: 18,
              fit: BoxFit.cover,
            ),
          ),
          onChanged: (value) {},
          onSubmitted: (val) {
            viewModel.getSearchResults();
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              viewModel.searchController.clear();
            },
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Cancel",
                  style: AppTextStyle.subText2.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textOnBackground),
                )),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: viewModel.state == ViewState.Busy
          ? Container()
          : viewModel.searchController.text.isEmpty && viewModel.searchResults!.isEmpty? Container()
              : viewModel.searchController.text.isNotEmpty && viewModel.searchResults!.isEmpty ?Center(
                  child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Container(
                    width: 200,
                    height: 220,
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage(Images.no_search_data_found),
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AnimationLimiter(
                    child: GridView.count(
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: .85,
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      crossAxisCount: 2,
                      children: List.generate(
                        viewModel.searchResults!.length,
                        (int index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: ScaleAnimation(
                              scale: 0.5,
                              child: FadeInAnimation(
                                child: PatientInfoWidget(
                                    viewModel.searchResults![index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
    );
  }
}

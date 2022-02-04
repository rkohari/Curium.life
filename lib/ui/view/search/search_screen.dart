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
      backgroundColor: AppColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: EditTextField(
          "",
          viewModel.searchController,
          placeholder: "Seach Patient",
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 13, right: 8),
            child: Image(
              image: AssetImage(Images.ic_search),
              width: 18,
              height: 18,
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
                  style: AppTextStyle.caption.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textOnBackground),
                )),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: viewModel.searchResults.isEmpty
          ? Center(
              child: Text("No Patients data found "),
            )
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
                    viewModel.searchResults.length,
                    (int index) {
                      return AnimationConfiguration.staggeredGrid(
                        columnCount: 2,
                        position: index,
                        duration: Duration(milliseconds: 500),
                        child: ScaleAnimation(
                          scale: 0.5,
                          child: FadeInAnimation(
                            child: PatientInfoWidget(
                                viewModel.searchResults[index]),
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

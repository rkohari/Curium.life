import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/image_picker/image_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ImageInfoScreen extends ViewModelBuilderWidget<ImagePickerViewModel> {
  var data;

  @override
  void onViewModelReady(ImagePickerViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  ImagePickerViewModel viewModelBuilder(BuildContext context) =>
      ImagePickerViewModel();

  @override
  Widget builder(
      BuildContext context, ImagePickerViewModel viewModel, Widget? child) {
    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              navigationService.popUntil(Routes.imagePicker);
            },
            color: AppColor.textOnPrimary,
          ),
          centerTitle: false,
          title: Text(
            "Captured Image Information",
            style: AppTextStyle.subtitle1.copyWith(
              color: AppColor.textOnBackground,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  VerticalSpacing.custom(value: 23),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 230,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Image(
                        width: double.infinity,
                        image: FileImage(data["file"]),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  VerticalSpacing.custom(value: 14),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'CVSC SCORE :',
                        style: AppTextStyle.headline5.copyWith(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: " ${data["total"].toString()}",
                        style: AppTextStyle.headline5.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary)),
                  ])),
                  VerticalSpacing.custom(value: 18),
                  Text("C1",
                      style: AppTextStyle.headline5.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 8),
                  Text(data["c1_des"].toString(),
                      style: AppTextStyle.overline.copyWith(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 12),

                  Container(
                    height: .6,
                    width: double.infinity,
                    color: Color(0xFFDDDDDD),
                  ),
                  VerticalSpacing.custom(value: 12),
                  Text("C2",
                      style: AppTextStyle.headline5.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 8),
                  Text(data["c2_des"].toString(),
                      style: AppTextStyle.overline.copyWith(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 12),
                  Container(
                    height: .6,
                    width: double.infinity,
                    color: Color(0xFFDDDDDD),
                  ),
                  VerticalSpacing.custom(value: 12),

                  Text("C3",
                      style: AppTextStyle.headline5.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 8),
                  Text(data["c3_des"].toString(),
                      style: AppTextStyle.overline.copyWith(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 12),

                ],
              ),
            )),

      bottomNavigationBar: Container(
        height: 100,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){

                navigationService.popUntil(Routes.imagePicker);


              },
              child: Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color:AppColor.primary,width: 1)

                ),
                alignment: Alignment.center,
                child: Text("Cancel",style: AppTextStyle.bodyText2.copyWith(fontSize: 16,color: AppColor.textOnPrimary,fontWeight: FontWeight.w400),),
              ),
            ),
            GestureDetector(
              onTap: viewModel.buttonLoading ? null :(){

                viewModel.controlButtonLoading(true);
                 viewModel.gotoPatientInfoScreen(data);



              },
              child: Container(
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.primary,
                  // border: Border.all(color:AppColor.background,width: 1)
                ),
                alignment: Alignment.center,
                child:viewModel.buttonLoading ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.black,strokeWidth: 2,)): Text("Next",style: AppTextStyle.bodyText2.copyWith(fontSize: 16,color: AppColor.background,fontWeight: FontWeight.w400),),
              ),
            )
          ],
        ),
      ),
    );

  }

  ImageInfoScreen(this.data);
}

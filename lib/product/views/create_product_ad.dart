import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sell_begin/product/img_pick_method.dart';
import 'package:sell_begin/utils/display_toast_message.dart';
import 'package:sell_begin/utils/input_decoration.dart';
import 'package:sell_begin/widgets/custom_app_bar.dart';
import 'package:sell_begin/widgets/custom_button.dart';
import 'package:sell_begin/widgets/loading_indicator.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CreateProductAdScreen extends StatefulWidget {
  static const String routeName = '/create-product';

  const CreateProductAdScreen({Key? key}) : super(key: key);

  @override
  _CreateProductAdScreenState createState() => _CreateProductAdScreenState();
}

class _CreateProductAdScreenState extends State<CreateProductAdScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeCountryIdAheadController = TextEditingController();
  final TextEditingController _typeCountryAheadController = TextEditingController();
  final TextEditingController _typeStateIdAheadController = TextEditingController();
  final TextEditingController _typeStateAheadController = TextEditingController();
  final TextEditingController _typeCityIdAheadController = TextEditingController();
  final TextEditingController _typeCityAheadController = TextEditingController();
  final TextEditingController _typeCategoryIdAheadController = TextEditingController();
  final TextEditingController _typeCategoryAheadController = TextEditingController();

  final int maxAssetsCount = 3;

  List<AssetEntity> assets = <AssetEntity>[];

  bool isDisplayingDetail = true;

  int get assetsLength => assets.length;

  List<ImgPickMethod> get pickMethods {
    return <ImgPickMethod>[
      ImgPickMethod.cameraAndStay(maxAssetsCount: maxAssetsCount),
      ImgPickMethod.image(maxAssetsCount),
    ];
  }

  Future<void> selectAssets(ImgPickMethod model) async {
    final List<AssetEntity>? result = await model.method(context, assets);
    if (result != null) {
      assets = List<AssetEntity>.from(result);
      if (mounted) {
        setState(() {});
      }
    }
  }

  void removeAsset(int index) {
    setState(() {
      assets.removeAt(index);
      if (assets.isEmpty) {
        isDisplayingDetail = false;
      }
    });
  }

  // @override
  // void initState() {
  //   final authPvd = context.read(authProvider);
  //   WidgetsBinding.instance!.addPostFrameCallback((_) {
  //     context.read(productProvider).getProductCategories(authPvd.user['key']);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Create Product Ad'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title'),
                const SizedBox(
                  height: 10.0,
                ),
                _buildTitleTextField(),
                const SizedBox(
                  height: 10.0,
                ),
                Text('Category'),
                const SizedBox(
                  height: 10.0,
                ),
                // _buildCategoryTypeDropDownField(),
                const SizedBox(
                  height: 10.0,
                ),
                // _buildCityDropDownTextField(),
                const SizedBox(
                  height: 10.0,
                ),
                Text('Description'),
                const SizedBox(
                  height: 10.0,
                ),
                _buildDescriptionTextField(),
                const SizedBox(
                  height: 10.0,
                ),
                Text('Condition'),
                const SizedBox(
                  height: 10.0,
                ),
                _buildProductConditionDropDownField(),
                const SizedBox(
                  height: 10.0,
                ),
                Text('Price'),
                const SizedBox(
                  height: 10.0,
                ),
                _buildPriceTextField(),
                const SizedBox(
                  height: 10.0,
                ),
                _buildSelectProduct(),
                const SizedBox(
                  height: 10.0,
                ),
                CustomButton(
                  btnTxt: 'Create Ad',
                  width: double.infinity,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (assets.isNotEmpty) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        // productPvd.createProductAd(context, assets, xApiKey);
                      } else {
                        displayToastMessage('Please select product images');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleTextField() {
    return TextFormField(
      onChanged: (value) {},
      validator: (value) => value!.isEmpty ? "Required" : null,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: buildTextFieldInputDecoration(context, txt: 'title'),
    );
  }

  // Widget _buildCategoryTypeDropDownField() {
  //   return DropdownButtonFormField(
  //     items: productPvd.productCategoryList.map((ProductCategory value) {
  //       return DropdownMenuItem<String>(
  //         value: value.id,
  //         child: Text('${value.name}'),
  //       );
  //     }).toList(),
  //     decoration: buildTextFieldInputDecoration(context, txt: ''),
  //     onChanged: (value) {
  //     },
  //     validator: (value) {
  //       if (value == null) {
  //         return 'Required';
  //       }
  //       return null;
  //     },
  //   );
  // }

  // Widget _buildCityDropDownTextField() {
  //   return TypeAheadField(
  //     textFieldConfiguration: TextFieldConfiguration(
  //       controller: this._typeCityAheadController,
  //       style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
  //       decoration: buildTextFieldInputDecoration(context, txt: 'City'),
  //     ),
  //     suggestionsCallback: (pattern) async {
  //       return filterPvd.getCitySuggestions(pattern);
  //     },
  //     itemBuilder: (context, City suggestion) {
  //       return ListTile(
  //         leading: Icon(Icons.location_city),
  //         title: Text(suggestion.name.toString()),
  //       );
  //     },
  //     transitionBuilder: (context, suggestionsBox, controller) {
  //       print(controller);
  //       print(suggestionsBox);
  //       return suggestionsBox;
  //     },
  //     onSuggestionSelected: (City suggestion) {
  //       productPvd.productFormData.cityId = '${suggestion.id}';
  //       this._typeCityIdAheadController.text = '${suggestion.id}';
  //       this._typeCityAheadController.text = '${suggestion.name}';
  //     },
  //   );
  // }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      onChanged: (value) {},
      maxLines: 8,
      maxLength: 600,
      decoration: buildTextFieldInputDecoration(context, txt: 'description'),
    );
  }

  Widget _buildProductConditionDropDownField() {
    return DropdownButtonFormField(
      items: <String>['New', 'Old'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text('$value'),
        );
      }).toList(),
      decoration: buildTextFieldInputDecoration(context, txt: 'Select Condition'),
      onChanged: (value) {},
      validator: (value) {
        if (value == null) {
          return 'Required';
        }
        return null;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      onChanged: (value) {},
      validator: (value) => value!.isEmpty ? "Required" : null,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: buildTextFieldInputDecoration(context, txt: 'price'),
    );
  }

  Widget _buildSelectProduct() {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Select images',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: Text(
                    '${assets.length}',
                    style: const TextStyle(color: Colors.white, height: 1.0),
                  ),
                ),
                Spacer(),
                TextButton.icon(
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text(
                    'Add',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return SafeArea(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0)),
                            ),
                            child: Column(
                              children: [
                                methodListView,
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
            SizedBox(height: 10.0),
            selectedAssetsWidget
          ],
        ),
      ),
    );
  }

  Widget get selectedAssetsWidget {
    return AnimatedContainer(
      duration: kThemeChangeDuration,
      curve: Curves.easeInOut,
      // height: assets.isNotEmpty
      //     ? isDisplayingDetail
      //         ? 120.0
      //         : 80.0
      //     : 40.0,
      height: 120.0,
      child: Column(
        children: <Widget>[
          selectedAssetsListView,
        ],
      ),
    );
  }

  Widget get selectedAssetsListView {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: assetsLength,
        itemBuilder: (_, int index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: _selectedAssetWidget(index)),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  top: isDisplayingDetail ? 6.0 : -30.0,
                  right: isDisplayingDetail ? 6.0 : -30.0,
                  child: _selectedAssetDeleteButton(index),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageAssetWidget(AssetEntity asset) {
    return Image(
      image: AssetEntityImageProvider(asset, isOriginal: false),
      fit: BoxFit.cover,
    );
  }

  Widget _selectedAssetWidget(int index) {
    final AssetEntity asset = assets.elementAt(index);
    return GestureDetector(
      onTap: isDisplayingDetail
          ? () async {
              final List<AssetEntity>? result = await AssetPickerViewer.pushToViewer(
                context,
                currentIndex: index,
                previewAssets: assets,
                themeData: AssetPicker.themeData(Colors.blue),
              );
              if (result != null && result != assets) {
                assets = List<AssetEntity>.from(result);
                if (mounted) {
                  setState(() {});
                }
              }
            }
          : null,
      child: RepaintBoundary(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          // child: _assetWidgetBuilder(asset),
          child: _imageAssetWidget(asset),
        ),
      ),
    );
  }

  Widget _selectedAssetDeleteButton(int index) {
    return GestureDetector(
      onTap: () => removeAsset(index),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.grey,
        ),
        child: Icon(
          Icons.close,
          // color: currentTheme.iconTheme.color,
          size: 18.0,
        ),
      ),
    );
  }

  Widget methodItemBuilder(BuildContext _, int index) {
    final ImgPickMethod model = pickMethods[index];
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        selectAssets(model);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 10.0,
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(2.0),
              width: 48,
              height: 48,
              child: Center(
                child: Text(
                  model.icon,
                  style: const TextStyle(fontSize: 24.0),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    model.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    model.description,
                    // style: context.themeData.textTheme.caption,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget get methodListView {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(bottom: 10.0),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          itemCount: pickMethods.length,
          itemBuilder: methodItemBuilder,
        ),
      ),
    );
  }
}

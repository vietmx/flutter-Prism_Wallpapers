import 'dart:ui';

import 'package:Prism/data/profile/wallpaper/profileSetupProvider.dart';
import 'package:Prism/global/svgAssets.dart';
import 'package:Prism/routes/routing_constants.dart';
import 'package:Prism/theme/themeModeProvider.dart';
import 'package:Prism/ui/widgets/home/wallpapers/seeMoreButton.dart';
import 'package:Prism/ui/widgets/setups/loadingSetups.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class UploadedSetupsGrid extends StatefulWidget {
  const UploadedSetupsGrid({
    Key? key,
  }) : super(key: key);

  @override
  _UploadedSetupsGridState createState() => _UploadedSetupsGridState();
}

class _UploadedSetupsGridState extends State<UploadedSetupsGrid>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<Color?> animation;
  GlobalKey<RefreshIndicatorState> refreshProfileSetupKey =
      GlobalKey<RefreshIndicatorState>();
  PaletteGenerator? paletteGenerator;
  List<Color>? colors;
  bool seeMoreLoader = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    animation = Provider.of<ThemeModeExtended>(context, listen: false)
                .getCurrentModeStyle(
                    SchedulerBinding.instance!.window.platformBrightness) ==
            "Dark"
        ? TweenSequence<Color?>(
            [
              TweenSequenceItem(
                weight: 1.0,
                tween: ColorTween(
                  begin: Colors.white10,
                  end: const Color(0x22FFFFFF),
                ),
              ),
              TweenSequenceItem(
                weight: 1.0,
                tween: ColorTween(
                  begin: const Color(0x22FFFFFF),
                  end: Colors.white10,
                ),
              ),
            ],
          ).animate(_controller!)
        : TweenSequence<Color?>(
            [
              TweenSequenceItem(
                weight: 1.0,
                tween: ColorTween(
                  begin: Colors.black.withOpacity(.1),
                  end: Colors.black.withOpacity(.14),
                ),
              ),
              TweenSequenceItem(
                weight: 1.0,
                tween: ColorTween(
                  begin: Colors.black.withOpacity(.14),
                  end: Colors.black.withOpacity(.1),
                ),
              ),
            ],
          ).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    _controller!.repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> refreshList() async {
    refreshProfileSetupKey.currentState?.show();
    Provider.of<ProfileSetupProvider>(context, listen: false)
        .getProfileSetups();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        key: refreshProfileSetupKey,
        onRefresh: refreshList,
        child: Provider.of<ProfileSetupProvider>(context, listen: false)
                    .profileSetups !=
                null
            ? Provider.of<ProfileSetupProvider>(context, listen: false)
                    .profileSetups!
                    .isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Provider.of<ThemeModeExtended>(context)
                                    .getCurrentModeStyle(MediaQuery.of(context)
                                        .platformBrightness) ==
                                "Dark"
                            ? SvgPicture.string(
                                postsDark
                                    .replaceAll(
                                        "181818",
                                        Theme.of(context)
                                            .primaryColor
                                            .value
                                            .toRadixString(16)
                                            .toString()
                                            .substring(2))
                                    .replaceAll(
                                        "E57697",
                                        Theme.of(context)
                                            .errorColor
                                            .toString()
                                            .replaceAll("Color(0xff", "")
                                            .replaceAll(")", ""))
                                    .replaceAll(
                                        "F0F0F0",
                                        Theme.of(context)
                                            .accentColor
                                            .value
                                            .toRadixString(16)
                                            .toString()
                                            .substring(2))
                                    .replaceAll(
                                        "2F2E41",
                                        Theme.of(context)
                                            .accentColor
                                            .value
                                            .toRadixString(16)
                                            .toString()
                                            .substring(2))
                                    .replaceAll(
                                        "3F3D56",
                                        Theme.of(context)
                                            .accentColor
                                            .value
                                            .toRadixString(16)
                                            .toString()
                                            .substring(2))
                                    .replaceAll(
                                        "2F2F2F",
                                        Theme.of(context)
                                            .hintColor
                                            .value
                                            .toRadixString(16)
                                            .toString()
                                            .substring(2)),
                              )
                            : SvgPicture.string(
                                postsLight
                                    .replaceAll(
                                        "181818",
                                        Theme.of(context)
                                            .primaryColor
                                            .value
                                            .toRadixString(16)
                                            .toString()
                                            .substring(2))
                                    .replaceAll(
                                        "E57697",
                                        Theme.of(context)
                                            .errorColor
                                            .toString()
                                            .replaceAll("Color(0xff", "")
                                            .replaceAll(")", ""))
                                    .replaceAll(
                                        "F0F0F0",
                                        Theme.of(context)
                                            .accentColor
                                            .value
                                            .toRadixString(16)
                                            .toString()
                                            .substring(2))
                                    .replaceAll(
                                        "2F2E41",
                                        Theme.of(context)
                                            .accentColor
                                            .value
                                            .toRadixString(16)
                                            .toString()
                                            .substring(2))
                                    .replaceAll(
                                        "3F3D56",
                                        Theme.of(context)
                                            .accentColor
                                            .value
                                            .toRadixString(16)
                                            .toString()
                                            .substring(2))
                                    .replaceAll(
                                        "2F2F2F",
                                        Theme.of(context)
                                            .hintColor
                                            .value
                                            .toRadixString(16)
                                            .toString()
                                            .substring(2)),
                              ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.1,
                      )
                    ],
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 4),
                    itemCount: Provider.of<ProfileSetupProvider>(context)
                        .profileSetups!
                        .length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 300
                                : 250,
                        childAspectRatio: 0.5025,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      if (index ==
                              Provider.of<ProfileSetupProvider>(context,
                                          listen: false)
                                      .profileSetups!
                                      .length -
                                  1 &&
                          !(Provider.of<ProfileSetupProvider>(context,
                                      listen: false)
                                  .profileSetups!
                                  .length <
                              8)) {
                        return SeeMoreButton(
                          seeMoreLoader: seeMoreLoader,
                          func: () {
                            if (!seeMoreLoader) {
                              setState(() {
                                seeMoreLoader = true;
                              });
                              Provider.of<ProfileSetupProvider>(context,
                                      listen: false)
                                  .seeMoreProfileSetups();
                              setState(() {
                                Future.delayed(const Duration(seconds: 1))
                                    .then((value) => seeMoreLoader = false);
                              });
                            }
                          },
                        );
                      }
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: animation.value,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      Provider.of<ProfileSetupProvider>(context)
                                          .profileSetups![index]["image"]
                                          .toString(),
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.3),
                                highlightColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.1),
                                onTap: () {
                                  if (Provider.of<ProfileSetupProvider>(context,
                                              listen: false)
                                          .profileSetups ==
                                      []) {
                                  } else {
                                    Navigator.pushNamed(
                                        context, profileSetupViewRoute,
                                        arguments: [index]);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    })
            : const LoadingSetupCards());
  }
}

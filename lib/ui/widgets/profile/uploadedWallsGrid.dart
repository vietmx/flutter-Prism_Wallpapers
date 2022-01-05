import 'package:Prism/data/profile/wallpaper/profileWallProvider.dart';
import 'package:Prism/global/svgAssets.dart';
import 'package:Prism/routes/routing_constants.dart';
import 'package:Prism/theme/themeModeProvider.dart';
import 'package:Prism/ui/widgets/focussedMenu/focusedMenu.dart';
import 'package:Prism/ui/widgets/home/wallpapers/loading.dart';
import 'package:Prism/ui/widgets/home/wallpapers/seeMoreButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileGrid extends StatefulWidget {
  const ProfileGrid({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileGridState createState() => _ProfileGridState();
}

class _ProfileGridState extends State<ProfileGrid>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<Color?> animation;
  GlobalKey<RefreshIndicatorState> refreshProfileKey =
      GlobalKey<RefreshIndicatorState>();
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
    refreshProfileKey.currentState?.show();
    Provider.of<ProfileWallProvider>(context, listen: false).getProfileWalls();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        key: refreshProfileKey,
        onRefresh: refreshList,
        child: Provider.of<ProfileWallProvider>(context, listen: false)
                    .profileWalls !=
                null
            ? Provider.of<ProfileWallProvider>(context, listen: false)
                    .profileWalls!
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
                    itemCount: Provider.of<ProfileWallProvider>(context)
                        .profileWalls!
                        .length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 300
                                : 250,
                        childAspectRatio: 0.6625,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      if (index ==
                              Provider.of<ProfileWallProvider>(context,
                                          listen: false)
                                      .profileWalls!
                                      .length -
                                  1 &&
                          !(Provider.of<ProfileWallProvider>(context,
                                      listen: false)
                                  .profileWalls!
                                  .length <
                              12)) {
                        return SeeMoreButton(
                          seeMoreLoader: seeMoreLoader,
                          func: () {
                            if (!seeMoreLoader) {
                              setState(() {
                                seeMoreLoader = true;
                              });
                              Provider.of<ProfileWallProvider>(context,
                                      listen: false)
                                  .seeMoreProfileWalls();
                              setState(() {
                                Future.delayed(const Duration(seconds: 1))
                                    .then((value) => seeMoreLoader = false);
                              });
                            }
                          },
                        );
                      }
                      return FocusedMenuHolder(
                        provider: "ProfileWall",
                        index: index,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: animation.value,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        Provider.of<ProfileWallProvider>(
                                                context)
                                            .profileWalls![index]
                                            .data()["wallpaper_thumb"]
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
                                    if (Provider.of<ProfileWallProvider>(
                                                context,
                                                listen: false)
                                            .profileWalls ==
                                        []) {
                                    } else {
                                      Navigator.pushNamed(
                                          context, profileWallViewRoute,
                                          arguments: [
                                            index,
                                            Provider.of<ProfileWallProvider>(
                                                    context,
                                                    listen: false)
                                                .profileWalls![index]
                                                .data()["wallpaper_thumb"],
                                          ]);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
            : const LoadingCards());
  }
}

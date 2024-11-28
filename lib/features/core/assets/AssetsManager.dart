abstract interface class _Assetsmanager {
  final String _name = "";
  final _AssetType _type = _AssetType.IMAGE;

  String getPath() {
    return "";
  }

  factory _Assetsmanager(String name, _AssetType assetType) =>
      _appfAsset(name, assetType);
}

class _appfAsset implements _Assetsmanager {
  final String _name;
  final _AssetType _type;

  const _appfAsset(this._name, this._type);

  @override
  String getPath() {
    return _type == _AssetType.IMAGE
        ? "assets/images/${this._name}"
        : _type == _AssetType.MUSIC
            ? "assets/music/${this._name}"
            : "assets/svgs/${this._name}";
  }
}

enum _AssetType { SVG, IMAGE, MUSIC }

class AllAppAssets {
  static final BN_HomeIcon = _Assetsmanager("bn_home.svg", _AssetType.SVG);
  static final BN_Favourite =
      _Assetsmanager("bn_favourite.svg", _AssetType.SVG);
  static final BN_Profile = _Assetsmanager("user.svg", _AssetType.SVG);
  static final OnboardingHomeImage =
      _Assetsmanager("splash.jpg", _AssetType.IMAGE);
  static final NetworkIcon = _Assetsmanager("network.svg", _AssetType.SVG);
  static final addToFavourite = _Assetsmanager("like.svg", _AssetType.SVG);
  static final removeFromFavourite =
      _Assetsmanager("liked.svg", _AssetType.SVG);
  static final MarketIcon = _Assetsmanager("market.svg", _AssetType.SVG);
  static final SuccessCheckSvg =
      _Assetsmanager("success_icon.svg", _AssetType.SVG);
  static final EditPenSvg = _Assetsmanager("edit_pen.svg", _AssetType.SVG);
  static final verifiedIcon = _Assetsmanager("verified.svg", _AssetType.SVG);
}

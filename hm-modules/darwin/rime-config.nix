{ pkgs
, config
, ...
}:

{
  home.file."Library/Rime/lua".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/lua;
  home.file."Library/Rime/opencc".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/opencc;
  home.file."Library/Rime/custom_phrase.txt".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/custom_phrase.txt;
  home.file."Library/Rime/default.custom.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/default.custom.yaml;
  home.file."Library/Rime/double_pinyin_flypy.custom.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/double_pinyin_flypy.custom.yaml;
  home.file."Library/Rime/double_pinyin_flypy.schema.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/double_pinyin_flypy.schema.yaml;
  home.file."Library/Rime/easy_en.dict.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/easy_en.dict.yaml;
  home.file."Library/Rime/easy_en.schema.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/easy_en.schema.yaml;
  home.file."Library/Rime/grammar.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/grammar.yaml;
  home.file."Library/Rime/installation.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/installation.yaml;
  home.file."Library/Rime/luna_pinyin.chengyusuyu.dict.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/luna_pinyin.chengyusuyu.dict.yaml;
  home.file."Library/Rime/luna_pinyin.jisuanjicihuidaquan.dict.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/luna_pinyin.jisuanjicihuidaquan.dict.yaml;
  home.file."Library/Rime/luna_pinyin.kaifadashenzhuanyongciku.dict.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/luna_pinyin.kaifadashenzhuanyongciku.dict.yaml;
  home.file."Library/Rime/luna_pinyin.kaomoji.dict.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/luna_pinyin.kaomoji.dict.yaml;
  home.file."Library/Rime/luna_pinyin.my-symbols.dict.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/luna_pinyin.my-symbols.dict.yaml;
  home.file."Library/Rime/luna_pinyin.sijixingzhenquhuadimingciku.dict.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/luna_pinyin.sijixingzhenquhuadimingciku.dict.yaml;
  home.file."Library/Rime/luna_pinyin.wangluoliuxingxinci.dict.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/luna_pinyin.wangluoliuxingxinci.dict.yaml;
  home.file."Library/Rime/luna_pinyin.zhongguolishicihuidaquan.dict.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/luna_pinyin.zhongguolishicihuidaquan.dict.yaml;
  home.file."Library/Rime/numbers.schema.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/numbers.schema.yaml;
  home.file."Library/Rime/pinyin_dicts.dict.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/pinyin_dicts.dict.yaml;
  home.file."Library/Rime/pinyin_simp.schema.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/pinyin_simp.schema.yaml;
  home.file."Library/Rime/pinyin_simp_mini.dict.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/pinyin_simp_mini.dict.yaml;
  home.file."Library/Rime/rime.lua".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/rime.lua;
  home.file."Library/Rime/squirrel.custom.yaml".source = config.lib.file.mkOutOfStoreSymlink ../../files/rime/squirrel.custom.yaml;

}

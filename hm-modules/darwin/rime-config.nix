{pkgs, config, ...}:

let
  lib = pkgs.lib; 

  pathToFilename = p: "Library/Rime/" + lib.lists.last (lib.strings.split "/" (builtins.toString p));

  rimeFiles = [
    ../../files/rime/lua
    ../../files/rime/opencc
    ../../files/rime/custom_phrase.txt
    ../../files/rime/default.custom.yaml
    ../../files/rime/double_pinyin_flypy.custom.yaml
    ../../files/rime/double_pinyin_flypy.schema.yaml
    ../../files/rime/easy_en.dict.yaml
    ../../files/rime/easy_en.schema.yaml
    ../../files/rime/grammar.yaml
    ../../files/rime/installation.yaml
    ../../files/rime/luna_pinyin.chengyusuyu.dict.yaml
    ../../files/rime/luna_pinyin.jisuanjicihuidaquan.dict.yaml
    ../../files/rime/luna_pinyin.kaifadashenzhuanyongciku.dict.yaml
    ../../files/rime/luna_pinyin.kaomoji.dict.yaml
    ../../files/rime/luna_pinyin.my-symbols.dict.yaml
    ../../files/rime/luna_pinyin.sijixingzhenquhuadimingciku.dict.yaml
    ../../files/rime/luna_pinyin.wangluoliuxingxinci.dict.yaml
    ../../files/rime/luna_pinyin.zhongguolishicihuidaquan.dict.yaml
    ../../files/rime/numbers.schema.yaml
    ../../files/rime/pinyin_dicts.dict.yaml
    ../../files/rime/pinyin_simp.schema.yaml
    ../../files/rime/pinyin_simp_mini.dict.yaml
    ../../files/rime/rime.lua
    ../../files/rime/squirrel.custom.yaml
  ];

in
  {
    home.file =
      builtins.listToAttrs (map (p: { name = pathToFilename p; value = {source = p;}; }) rimeFiles);
      #lib.lists.foldr (p: cfg: cfg // { ${pathToFilename p} = { source = p;};}) {} rimeFiles;
  }


{pkgs, config, ...}:

let
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

in let
  #lib = pkgs.lib; 
  #sourceFilename = p: lib.lists.last (lib.strings.split "/" (builtins.toString p));

  sourceFilename = root: p: builtins.replaceStrings [root] [""] (builtins.toString p);
  #/nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-source/files/rime
  rimeRoot = (builtins.toString ../../files/rime) + "/";
in
  {
    home.file =
      builtins.listToAttrs (map (p: { name = "Library/Rime/${sourceFilename rimeRoot p}"; value = {source = p;}; }) rimeFiles);
      #lib.lists.foldr (p: cfg: cfg // { "Library/Rime/${sourceFilename rimeRoot p}" = { source = p;};}) {} rimeFiles;
  }


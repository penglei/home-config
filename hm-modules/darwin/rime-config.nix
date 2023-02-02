{pkgs, config, ...}:

let
  rimeFiles = [
    "lua"
    "opencc"
    "custom_phrase.txt"
    "default.custom.yaml"
    "double_pinyin_flypy.custom.yaml"
    "double_pinyin_flypy.schema.yaml"
    "easy_en.dict.yaml"
    "easy_en.schema.yaml"
    "grammar.yaml"
    "luna_pinyin.chengyusuyu.dict.yaml"
    "luna_pinyin.jisuanjicihuidaquan.dict.yaml"
    "luna_pinyin.kaifadashenzhuanyongciku.dict.yaml"
    "luna_pinyin.kaomoji.dict.yaml"
    "luna_pinyin.my-symbols.dict.yaml"
    "luna_pinyin.sijixingzhenquhuadimingciku.dict.yaml"
    "luna_pinyin.wangluoliuxingxinci.dict.yaml"
    "luna_pinyin.zhongguolishicihuidaquan.dict.yaml"
    "numbers.schema.yaml"
    "pinyin_dicts.dict.yaml"
    "pinyin_simp.schema.yaml"
    "pinyin_simp_mini.dict.yaml"
    "rime.lua"
    "squirrel.custom.yaml"
  ];

in let
  ##lib = pkgs.lib; 
  ##sourceFilename = p: lib.lists.last (lib.strings.split "/" (builtins.toString p));
  #sourceFilename = root: p: builtins.replaceStrings [root] [""] (builtins.toString p);
  ##/nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-source/files/rime
  #rimeRoot = (builtins.toString ../../files/rime) + "/";

  files = map (name: { path = ../../files/rime/${name}; name = "Library/Rime/${name}"; }) rimeFiles;

in
  {
    home.file =
      builtins.listToAttrs (map (file: { name = file.name; value = {source = file.path;}; }) files);
      #lib.lists.foldr (p: cfg: cfg // { "Library/Rime/${sourceFilename rimeRoot p}" = { source = p;};}) {} rimeFiles;
  }


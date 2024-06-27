{
  /* Convert an attribute set to string containing a lua table.
     Example:
        lib.generators.toLua { foo = "bar"; set = { bool = true; list = [ 1 2 3.3 ]; }; }
        => "foo = { \"bar\" }, set = { bool = true, list = { 1, 2, 3.300000 }, },"
  */
  toLua = lib: attributes:
    (lib.concatMapStringsSep "\n" (attrName:
      let
        generate = attrs:
          let
            toValue = value:
              if builtins.isAttrs value then
                generate value
              else if builtins.isList value then
                "{ ${lib.concatStringsSep ", " (map toValue value)} }"
              else if builtins.isString value then
                ''"${builtins.toString value}"''
              else if builtins.isBool value then
                if value then "true" else "false"
              else if builtins.isInt value || builtins.isFloat value then
                builtins.toString value
              else
                abort
                "generators.toLua: unsupported type ${builtins.typeOf value}";
          in if builtins.isAttrs attrs then
            lib.concatStringsSep "\n" (lib.mapAttrsToList (attr: attrValue:
              let
                # TODO: check for all keywords
                formattedAttr = if lib.hasInfix "-" attr || attr == "nil" then
                  ''["${attr}"]''
                else
                  attr;

                value =
                  if builtins.isList attrs || builtins.isAttrs attrValue then
                    "{ ${toValue attrValue} }"
                  else
                    toValue attrValue;
              in "${formattedAttr} = ${value},") attrs)
          else
            toValue attrs;
      in ''
        ${attrName} = {
        ${generate attributes.${attrName}}
        },
      '') (builtins.attrNames attributes));

  /* Import a luafile inside of a vimrc.

     Example:
     mkLuaFile "foo.lua"
     => "lua << EOF dofile(\"foo.lua\") EOF"
  */

  mkLuaFile = file: ''
    lua << EOF
      dofile("${file}")
    EOF
  '';

  /* Generate a lua section for a vimrc file.

     Example:
     mkLua "print('hello world')"
     => "lua << EOF print('hello world') EOF"
  */
  mkLua = lua: ''
    lua << EOF
      ${lua}
    EOF
  '';

}


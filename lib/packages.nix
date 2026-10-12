args @ {
  callPackage,
  lib,
  llvmPackages,
  stdenv,
  # If this is null, it uses the `buildLeanPackage.nix` in the provided `src`,
  # which only exists for versions 4.21 and below.
  buildLeanPackage ? null,
  # Either provide a built Lean ...
  lean-bin ? null,
  # Or provide sources and bootstrapping functions
  src ? null,
  bootstrap ? null,
}: let
  lean = callPackage bootstrap (args
    // {
      inherit (llvmPackages) stdenv;
      inherit src llvmPackages;
      buildLeanPackage = buildLeanPackageOverride;
    });

  stage1 = lib.defaultTo lean.stage1 lean-bin;

  makeOverridableLeanPackage = f: let
    newF = origArgs: let
      package = f origArgs;
      packageWithLegacyDarwinRpath =
        if buildLeanPackage == null && package ? executable
        then
          package
          // {
            # The legacy Lean builder links the shared standard library but
            # does not add its directory to the executable's runtime search
            # path. Its linkFlags argument lets this integration add the flag
            # only for Darwin executables using the shared standard library.
            executable = lib.makeOverridable (
              {withSharedStdlib ? true}: let
                leanFinal = origArgs."lean-final" or stage1;
                linkFlags =
                  (origArgs.linkFlags or [])
                  ++ lib.optional (stdenv.isDarwin && withSharedStdlib) "-Wl,-rpath,${leanFinal.leanshared}";
              in
                (f (origArgs // {inherit linkFlags;})).executable.override {inherit withSharedStdlib;}
            ) {};
          }
        else package;
    in
      packageWithLegacyDarwinRpath
      // {
        overrideArgs = newArgs: makeOverridableLeanPackage f (origArgs // newArgs);
      };
  in
    lib.setFunctionArgs newF (lib.functionArgs f)
    // {
      override = args: makeOverridableLeanPackage (f.override args);
    };

  buildLeanPackageOverride = makeOverridableLeanPackage (
    callPackage (
      lib.defaultTo (import "${src}/nix/buildLeanPackage.nix") buildLeanPackage
    )
    (
      args
      // {
        inherit stdenv;
        lean = stage1;
        inherit (stage1) leanc;
      }
    )
  );
in
  {buildLeanPackage = buildLeanPackageOverride;} // stage1

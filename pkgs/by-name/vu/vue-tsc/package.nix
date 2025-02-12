{
  lib,
  buildNpmPackage,
  fetchurl,
}:

buildNpmPackage rec {
  pname = "vue-tsc";
  version = "2.2.0";

  src = fetchurl {
    url = "https://registry.npmjs.org/@vue/vue-tsc/-/vue-tsc-${version}.tgz";
    hash = "sha256-MnJPd0ZxoHCp8aq0uSGiVIq3L7NA9VfqmN1le9AGVI8=";
  };

  npmDepsHash = "sha256-qI0l1WE12Pw2q9Y74sCoGu2UjgS8svxWsxzXmt5gPiM=";

  postPatch = ''
    ln -s ${./package-lock.json} package-lock.json
  '';

  dontNpmBuild = true;

  meta = {
    description = "Vue 3 command line Type-Checking tool";
    homepage = "https://github.com/vuejs/language-tools";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [  ];
  };
}

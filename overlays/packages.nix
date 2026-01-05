{inputs, ...}: final: prev: {
  harbor = inputs.self.packages.${final.stdenv.hostPlatform.system} or {};
}

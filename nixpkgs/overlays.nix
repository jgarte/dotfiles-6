let
  nodejs-11_13_0 = self: super: {
    nodejs-11_13_0 = self.callPackage (import ./packages/nodejs-11_13_0) {};
  };
  aws-sam-cli = self: super: {
    aws-sam-cli = self.callPackage (import ./packages/aws-sam-cli) {};
  };
in
[ nodejs-11_13_0 aws-sam-cli ]

{
  description = ''High precision and high performance task scheduler '';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-taskqueue-0_1_1.flake = false;
  inputs.src-taskqueue-0_1_1.owner = "jackhftang";
  inputs.src-taskqueue-0_1_1.ref   = "refs/tags/0.1.1";
  inputs.src-taskqueue-0_1_1.repo  = "taskqueue.nim";
  inputs.src-taskqueue-0_1_1.type  = "github";
  
  inputs."timestamp".dir   = "nimpkgs/t/timestamp";
  inputs."timestamp".owner = "riinr";
  inputs."timestamp".ref   = "flake-pinning";
  inputs."timestamp".repo  = "flake-nimble";
  inputs."timestamp".type  = "github";
  inputs."timestamp".inputs.nixpkgs.follows = "nixpkgs";
  inputs."timestamp".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-taskqueue-0_1_1"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-taskqueue-0_1_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}
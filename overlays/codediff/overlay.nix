final: prev: {
	vimPlugins = prev.vimPlugins // {
		codediff-nvim = prev.vimUtils.buildVimPlugin rec {
			pname = "codediff.nvim";
			version = "2.66.0";

			src = prev.fetchFromGitHub {
				owner = "esmuellert";
				repo = "codediff.nvim";
				tag = "v${version}";
				hash = "sha256-+2Prk091hcQXtQyk6gtdvChWY0njhUTARhlsr5Lwdps=";
			};

			dependencies = [ prev.vimPlugins.nui-nvim ];
			buildInputs = [ prev.gcc.cc.lib ];

			nativeBuildInputs = [ prev.cmake ];
			dontUseCmakeConfigure = true;

			buildPhase = ''
				runHook preBuild
				make
				runHook postBuild
			'';
			postInstall = ''
				ln -s ${prev.gcc.cc.lib}/lib/libgomp.so.1 $out/libgomp_linux_x64_2.66.0.so.1
				ln -s ${prev.gcc.cc.lib}/lib/libgomp.so.1 $out/libgomp.so.1
			'';
		};
	};
}

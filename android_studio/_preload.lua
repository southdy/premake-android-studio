local p = premake

-- Premake extensions
newaction {
	trigger     = "android-studio",
	shortname   = "Android Studio",
	description = "Generate Android Studio Gradle Files",
	toolset  	= "clang",

	valid_kinds = { 
		"ConsoleApp", 
		"WindowedApp", 
		"SharedLib", 
		"StaticLib", 
		"Makefile", 
		"Utility", 
		"None" 
	},
	valid_languages = { "C", "C++", "Java" },
	valid_tools = {
		cc = { "clang" },
	},
			
	-- function overloads
	onWorkspace = function(wks)
		p.generate(wks, "settings.gradle", p.modules.android_studio.generate_workspace_settings)
		p.generate(wks, "build.gradle",  p.modules.android_studio.generate_workspace)
	end,

	onProject = function(prj)
		p.generate(prj, prj.name .. "/src/main/AndroidManifest.xml",  p.modules.android_studio.generate_manifest)
		p.generate(prj, prj.name .. "/build.gradle",  p.modules.android_studio.generate_project)
		p.generate(prj, prj.name .. "/CMakeLists.txt",  p.modules.android_studio.generate_cmake_lists)
	end
}

p.api.register 
{
	name = "androidabis",
	scope = "project",
	kind = "list:string",
	allowed = {
		"armeabi",
		"armeabi-v7a",
		"arm64-v8a",
		"x86",
		"x86_64"
	}
}

p.api.register 
{
	name = "gradleversion",
	scope = "workspace",
	kind = "string"
}

p.api.register 
{
	name = "androiddependencies",
	scope = "project",
	kind = "list:string"
}

p.api.register 
{
	name = "androidsdkversion",
	scope = "project",
	kind = "string"
}

p.api.register 
{
	name = "androidminsdkversion",
	scope = "project",
	kind = "string"
}

p.api.register 
{
	name = "archivedirs",
	scope = "project",
	kind = "list:directory"
}
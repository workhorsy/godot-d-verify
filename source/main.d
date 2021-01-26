// Copyright (c) 2021 Matthew Brennan Jones <matthew.brennan.jones@gmail.com>
// MIT License
// Verify Godot projects that use the D Programming Language
// https://github.com/workhorsy/godot-d-verify



import std.stdio : stdout, stderr;
import scan_godot_project;
import scan_d_code;
import verify_godot_project;

int main() {
	stdout.writefln("Verifying godot project ..."); stdout.flush();
	version (Windows) {
		string project_path = `C:/Users/matt/Projects/PumaGameGodot/`;
	} else version (linux) {
		string project_path = `/home/matt/Desktop/PumaGameGodot/`;
	} else {
		static assert(0, "Unsupported OS");
	}

	// Scan the godot.project
	auto project = getGodotProject(project_path ~ `project/project.godot`);

	//
	auto class_infos = getCodeClasses(project_path ~ `src/`);

	// Print any errors
	auto project_errors = findProjectErrors(project, class_infos);
	foreach (name, errors ; project_errors) {
		if (errors.length == 0) continue;

		stderr.writeln(name);
		foreach (error ; errors) {
			stderr.writeln(error);
		}
	}

	return 0;
}

aPackageInfo = [
	:name = "The Quran ring Applicaion",
	:description = "Listen to Quran with Ring programming language",
	:folder = "quran_ring",
	:developer = "Mohannad Alayash",
	:email = "mohannadazazalayash@gmail.com",
	:license = "MIT License",
	:version = "1.0.0",
	:ringversion = "1.18",
	:versions = 	[
		[
			:version = "1.0.0",
			:branch = "main"
		]
	],
	:libs = 	[
		[
			:name = "jsonlib",
			:version = "1.0.11",
			:providerusername = "ringpackages"
		],
		[
			:name = "internetlib",
			:version = "1.0.5",
			:providerusername = "ringpackages"
		],
		[
			:name = "guilib",
			:version = "1.0.21",
			:providerusername = "ringpackages"
		]
	],
	:files = 	[
		"lib.ring",
		"main.ring",
		"all_Souars.json",
		"player/player.rform",
		"player/playerController.ring",
		"player/playerView.ring",
		"Quran_ring.rform",
		"Quran_ringController.ring",
		"Quran_ringView.ring",
		"README.MD"
	],
	:ringfolderfiles = 	[
	],
	:windowsfiles = 	[
	],
	:linuxfiles = 	[

	],
	:ubuntufiles = 	[

	],
	:fedorafiles = 	[

	],
	:macosfiles = 	[

	],
	:windowsringfolderfiles = 	[

	],
	:linuxringfolderfiles = 	[

	],
	:ubunturingfolderfiles = 	[

	],
	:fedoraringfolderfiles = 	[

	],
	:macosringfolderfiles = 	[

	],
	:run = "ring main.ring",
	:windowsrun = "",
	:linuxrun = "",
	:macosrun = "",
	:ubunturun = "",
	:fedorarun = "",
	:setup = "",
	:windowssetup = "",
	:linuxsetup = "",
	:macossetup = "",
	:ubuntusetup = "",
	:fedorasetup = "",
	:remove = "",
	:windowsremove = "",
	:linuxremove = "",
	:macosremove = "",
	:ubunturemove = "",
	:fedoraremove = ""
]
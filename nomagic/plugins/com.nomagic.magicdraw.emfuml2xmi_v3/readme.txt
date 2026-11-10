To start Eclipse UML2 XMI export from commandline use:

exportEMFXMI project_file=<path to project file> destination_dir=<path to destination directory> [load_all_modules=<true | false>] [check_time=<true | false>]

or

exportEMFXMI project_descriptor=<project URL> destination_dir=<path to destination directory> [load_all_modules=<true | false>] [check_time=<true | false>] [server=<server address> username=<user login name> password=<user password>]

Arguments:
"project_file" - path to the project file.
"project_descriptor" - URL of the project (project descriptor). To get the project descriptor - start MagicDraw, open project, select menu "File"->"Project Properties", "General" tab, see "Project Descriptor" field.
"destination_dir" - path to the destination directory.
"load_all_modules" - if load all not loaded modules ("true" by default).
"check_time" - compare already exported file modification time and MagicDraw local project file modification time (teamwork project commit time). This allows to skip exporting of the same not changed project ("false" by default).
Teamwork Cloud arguments (in case project descriptor for TWC project is provided):
"server" - Teamwork Cloud server name or IP address to connect to.
"username" - user name to login with.
"password" - password for the specified Teamwork Cloud user
"project_password" - password for the specified Teamwork Cloud project (optional, needed only if project is password protected)

Also it is possible to specify the options properties file - the file allows to change the MagicDraw Eclipse UML2 XMI environment options.
To specify the properties file add argument "properties_file=<path to options file>" to command line.
The options/commandline.properties file is the sample properties file.

Important: Make sure the project used modules are available to load during export.
Important: If you need a space in the path surround the argument with escaped (\") quote.
E.g.
exportEMFXMI \"project_file=d:\My Model.mdzip\" \"destination_dir=d:\output 2\"
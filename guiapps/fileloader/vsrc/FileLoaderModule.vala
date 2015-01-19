using aroop;
using shotodol;
using roopkotha.guiapps.fileloader;

/**
 * \ingroup guiapps
 * \defgroup gui_command Commands that are capable of showing output in gui.
 */

/** \addtogroup gui_command
 *  @{
 */
public class roopkotha.guiapps.fileloader.FileLoaderModule: DynamicModule {
	public FileLoaderModule() {
		extring nm = extring.set_static_string("filecommand");
		extring ver = extring.set_static_string("0.0.0");
		base(&nm,&ver);
	}
	
	public override int init() {
		extring entry = extring.set_static_string("vela/command");
		Plugin.register(&entry, new M100Extension(new FileListCommand(), this));
		entry.rebuild_and_set_static_string("vela/page/handler/prefixed");
		extring velafopen = extring.set_static_string("velafopen://");
		Plugin.register(&entry, new AnyInterfaceExtension(new DefaultFileResourceHandler(&velafopen), this));
		//roopkotha.velavanilla.VelaVanillaModule.vanilla.cHandler.setHandler(fopener, fr);
		//fr.setHandlers();
		return 0;
	}
	public override int deinit() {
		base.deinit();
		return 0;
	}
	
	[CCode (cname="get_module_instance")]
	public static Module get_module_instance() {
		return new FileLoaderModule();
	}
}
/* @} */
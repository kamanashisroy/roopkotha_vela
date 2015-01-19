using aroop;
using shotodol;
using roopkotha.guiapps.fileloader;

/**
 * \ingroup guiapps
 * \defgroup fileloader Commands that are capable of showing output in gui.
 */

/** \addtogroup fileloader
 *  @{
 */
public class roopkotha.guiapps.fileloader.FileLoaderModule: DynamicModule {
	public FileLoaderModule() {
		extring nm = extring.set_string(core.sourceModuleName());
		extring ver = extring.set_static_string("0.0.0");
		base(&nm,&ver);
	}
	
	public override int init() {
		extring entry = extring.set_static_string("vela/command");
		Plugin.register(&entry, new M100Extension(new FileListCommand(), this));
		entry.rebuild_and_set_static_string("vela/page/scheme/handler");
		extring velafopen = extring.set_static_string("velafopen");
		DefaultFileResourceHandler handler = new DefaultFileResourceHandler(&velafopen);
		Plugin.register(&entry, new AnyInterfaceExtension(handler, this));
		entry.rebuild_and_set_static_string("vela/file/handler");
		Plugin.register(&entry, new AnyInterfaceExtension(new VelaAppFileResourceHandler(), this));
		entry.rebuild_and_set_static_string("rehash");
		Plugin.register(&entry, new HookExtension(handler.rehashHook, this));
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

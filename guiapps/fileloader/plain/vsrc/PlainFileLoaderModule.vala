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
public class roopkotha.guiapps.fileloader.plain.PlainFileLoaderModule: DynamicModule {
	public PlainFileLoaderModule() {
		extring nm = extring.set_string(core.sourceModuleName());
		extring ver = extring.set_static_string("0.0.0");
		base(&nm,&ver);
	}
	
	public override int init() {
		extring entry = extring.set_static_string("vela/file/handler");
		PluginManager.register(&entry, new AnyInterfaceExtension(new PlainFileResourceHandler(), this));
		return 0;
	}
	public override int deinit() {
		base.deinit();
		return 0;
	}
	
	[CCode (cname="get_module_instance")]
	public static Module get_module_instance() {
		return new PlainFileLoaderModule();
	}
}
/* @} */

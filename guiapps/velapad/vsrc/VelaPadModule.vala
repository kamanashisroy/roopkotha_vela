using aroop;
using shotodol;

/** \addtogroup velapp
 *  @{
 */
public class roopkotha.velapad.VelaPadModule : DynamicModule {
	VelaPadModule() {
		extring nm = extring.set_static_string("vela");
		extring ver = extring.set_static_string("0.0.0");
		base(&nm,&ver);
	}
	public override int init() {
		VelaCommand cmd = new VelaCommand(this);
		extring entry = extring.set_static_string("command");
		PluginManager.register(&entry, new M100Extension(cmd, this));
		entry.rebuild_and_set_static_string("vela/page");
		PluginManager.register(&entry, new AnyInterfaceExtension(cmd.vpad.pg, this));
		entry.rebuild_and_set_static_string("rehash");
		PluginManager.swarm(&entry, null, null);
		return 0;
	}

	public override int deinit() {
		base.deinit();
		return 0;
	}

	[CCode (cname="get_module_instance")]
	public static Module get_module_instance() {
		return new VelaPadModule();
	}
}
/** @} */

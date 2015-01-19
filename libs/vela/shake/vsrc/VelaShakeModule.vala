using aroop;
using shotodol;
using roopkotha.vela.coordinator;
using roopkotha.vela.menu;


/**
 * \defgroup vela.shake Shake script file for vela.
 */

/** \addtogroup vela.shake
 *  @{
 */
public class roopkotha.vela.shake.VelaShakeModule : DynamicModule {
	VelaShake?shake;
	VelaShakeModule() {
		extring nm = extring.set_string(core.sourceModuleName());
		extring ver = extring.set_static_string("0.0.0");
		base(&nm, &ver);
	}
	public override int init() {
		ModuleLoader.singleton.loadStatic(new CoordinatorModule());
		ModuleLoader.singleton.loadStatic(new AutoMenuModule());
		shake = new VelaShake();
		extring entry = extring.set_static_string("rehash"); // say we need to rehash
		Plugin.register(&entry, new HookExtension(rehashHook, this));
		entry.rebuild_and_set_static_string("vela/page/scheme/handler"); // register handler
		Plugin.register(&entry, new AnyInterfaceExtension(shake.cHandler, this));
		rehashHook(null, null);
		return 0;
	}

	int rehashHook(extring*msg, extring*output) {
		/**
		 * make the command available for vela.shake
		 */
		extring command = extring.set_static_string("vela/command");
		shake.velac.rehash(&command);
		return 0;
	}

	public override int deinit() {
		shake = null;
		base.deinit();
		return 0;
	}

	[CCode (cname="get_module_instance")]
	public static Module get_module_instance() {
		return new VelaShakeModule();
	}
}
/** @} */

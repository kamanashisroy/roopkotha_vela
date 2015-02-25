using aroop;
using shotodol;
using roopkotha.vela;
using roopkotha.vela.coordinator;

/** \addtogroup vela.coordinator
 *  @{
 */
public class roopkotha.vela.coordinator.CoordinatorModule : Module {
	AutoPilot pilot;
	public CoordinatorModule() {
		extring nm = extring.set_string(core.sourceModuleName());
		extring ver = extring.set_static_string("0.0.0");
		base(&nm,&ver);
		pilot = new AutoPilot();
	}

	public override int init() {
		extring entry = extring.set_static_string("rehash");
		PluginManager.register(&entry, new HookExtension(pilot.rehashHook, this));
		entry.rebuild_and_set_static_string("vela/page/handler");
		PluginManager.register(&entry, new AnyInterfaceExtension(pilot.fetcher, this));
		entry.rebuild_and_set_static_string("vela/velaxecute");
		PluginManager.register(&entry, new HookExtension(pilot.velaxecuteHook, this));
		return 0;
	}

	public override int deinit() {
		PluginManager.unregisterModule(this);
		base.deinit();
		return 0;
	}
}

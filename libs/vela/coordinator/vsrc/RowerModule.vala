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
		extring entry = extring.set_static_string("rehash"); // say we need rehash
		Plugin.register(&entry, new HookExtension(rehashHook, this));
		return 0;
	}

	int rehashHook(extring*msg, extring*output) {
		// remove all previous handlers and pages
		pilot.rehash();
		return 0;
	}

	public override int deinit() {
		Plugin.unregisterModule(this);
		base.deinit();
		return 0;
	}
}

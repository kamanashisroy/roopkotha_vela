using aroop;
using shotodol;
using roopkotha.vela;
using roopkotha.vela.rower;

/** \addtogroup vela.rower
 *  @{
 */
public class roopkotha.vela.rower.RowerModule : Module {
	AutoPilot pilot;
	public RowerModule() {
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
		pilot.plugPage(null);pilot.plugHandler(null);
		if(loadHandler() != -1) // load the handler
			loadPage(); // load the page
		return 0;
	}

	int loadPage() {
		extring pgcb = extring.set_static_string("vela/page");
		Plugin.acceptVisitor(&pgcb, (x) => {
			PageWindow page = (PageWindow)x.getInterface(null);
			pilot.plugPage(page);
		});
		return 0;
	}

	int loadHandler() {
		extring pageHandler = extring.set_static_string("vela/page/handler");
		Plugin.acceptVisitor(&pageHandler, (x) => {
			ResourceHandler handler = (ResourceHandler)x.getInterface(null);
			pilot.plugHandler(handler);
		});
		return 0;
	}

	public override int deinit() {
		Plugin.unregisterModule(this);
		base.deinit();
		return 0;
	}
}

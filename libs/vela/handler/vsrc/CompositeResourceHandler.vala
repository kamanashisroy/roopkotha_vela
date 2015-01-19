using aroop;
using shotodol;

/** \addtogroup vela.handler
 *  @{
 */
public class roopkotha.vela.handler.CompositeResourceHandler : ResourceHandler {
	HashTable<xtring,ResourceHandler?> handlers;
	public CompositeResourceHandler() {
		handlers = HashTable<xtring,ResourceHandler?>(xtring.hCb,xtring.eCb);
	}
	~CompositeResourceHandler() {
		handlers.destroy();
	}
	ResourceHandler? getHandler(Resource id) {
		extring prefix = extring.stack(64);
		id.copyPrefix(&prefix);
		if(prefix.is_empty()) {
			extring dlg = extring.stack(128);
			dlg.printf("Handler is empty:%s\n", id.url.to_string());
			Watchdog.watchit(core.sourceFileName(), core.sourceLineNo(), 1, Watchdog.WatchdogSeverity.ALERT, 0, 0, &dlg);
			return null;
		}
		return handlers.getProperty(&prefix);
	}
	public void setHandler(xtring prefix, ResourceHandler?hdlr) {
		if(hdlr != null) {
			hdlr.setContentCallback(onContentReady);
			hdlr.setContentErrorCallback(onContentError);
		}
		handlers.set(prefix, hdlr);
	}
	public override int request(Resource id) {
		ResourceHandler?handler = getHandler(id);
		if(handler == null) {
			onContentError(id, 0, null);
			return -1;
		}
		return handler.request(id);
	}
}
/** @} */

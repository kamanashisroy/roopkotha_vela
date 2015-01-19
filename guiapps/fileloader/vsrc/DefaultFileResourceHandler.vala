using aroop;
using shotodol;

/** \addtogroup velahandler
 *  @{
 */
public class roopkotha.guiapps.fileloader.DefaultFileResourceHandler : CompositeFileResourceHandler {
	public DefaultFileResourceHandler(extring*prefix) {
		base(prefix);
	}

	internal int rehashHook(extring*inmsg, extring*outmsg) {
		extring entry = extring.set_static_string("vela/file/handler");
		Plugin.acceptVisitor(&entry, (x) => {
			FileResourceHandler handler = (FileResourceHandler)x.getInterface(null);
			extring suffix = extring();
			handler.getExtensionAs(&suffix);
			xtring tgt = new xtring.copy_deep(&suffix);
			setHandler(tgt, handler);
		});
		return 0;
	}
}
/** @} */

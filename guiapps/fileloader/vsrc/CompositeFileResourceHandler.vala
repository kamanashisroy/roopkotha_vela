using aroop;
using shotodol;
using roopkotha.vela.handler;
using roopkotha.guiapps.fileloader;

/** \addtogroup guiapps.fileloader
 *  @{
 */
public class roopkotha.guiapps.fileloader.CompositeFileResourceHandler : URLResourceHandler {
	HashTable<xtring,ResourceHandler?> handlers;
	public CompositeFileResourceHandler(extring*prefix) {
		base(prefix);
		handlers = HashTable<xtring,ResourceHandler?>(xtring.hCb,xtring.eCb);
	}
	~CompositeFileResourceHandler() {
		handlers.destroy();
	}
	ResourceHandler? getHandler(Resource id) {
		int len = id.url.length();
		int i = 0;
		extring fileext = extring();
		for(i = len; i > 0; i--) {
			if(id.url.char_at(i) == '.') {
				fileext = extring.copy_shallow(&id.url);
				fileext.shift(i);
			}
		}
		if(fileext.is_empty()) {
			// TODO use plain opener
			return null;
		}
		return handlers.getProperty(&fileext);
	}
	public void setHandler(xtring fileext, FileResourceHandler hdlr) {
		hdlr.setContentCallback(onContentReady);
		hdlr.setContentErrorCallback(onContentError);
		handlers.set(fileext, hdlr);
	}
	public override int request(Resource id) {
		ResourceHandler?handler = getHandler(id);
		if(handler == null) {
			return -1;
		}
		return handler.request(id);
	}
}
/** @} */

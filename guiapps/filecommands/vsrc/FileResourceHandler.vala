using aroop;
using shotodol;
using roopkotha.velarower;

/** \addtogroup velahandler
 *  @{
 */
public class roopkotha.filecommands.FileResourceHandler : ResourceHandler {
	HashTable<xtring,ResourceHandler?> handlers;
	public FileResourceHandler() {
		handlers = HashTable<xtring,ResourceHandler?>(xtring.hCb,xtring.eCb);
	}
	~FileResourceHandler() {
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
	public void setHandler(xtring fileext, ResourceHandler hdlr) {
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

using aroop;
using shotodol;
using roopkotha;
using roopkotha.vela;
using roopkotha.doc;

/** \addtogroup vela.rower
 *  @{
 */
public class roopkotha.vela.rower.Resource : Replicable {
	public enum Type {
		DOCUMENT,
		IMAGE,
	}
	public Type tp {public get;private set;}
	public extring baseUrl;
	public extring url;
	RoopDocument referer;
	public Resource(extring*gBase, extring*gUrl, RoopDocument gReferer) {
		if(gBase.is_empty_magical()) {
			baseUrl = extring();
		} else {
			baseUrl = extring.copy_on_demand(gBase);
		}
		if(gUrl.is_empty_magical()) {
			url = extring();
		} else {
			url = extring.copy_on_demand(gUrl);
		}
		tp = Type.DOCUMENT;
		//print("x:%s-%s\n", baseUrl.to_string(), url.to_string());
		referer = gReferer;
	}
	public void copyPrefix(extring*prefix) {
		//extring*x = baseUrl.is_empty_magical()?&url:&baseUrl;
		//print("x:%s\n", x.to_string());
		prefix.concat(&baseUrl);
		prefix.concat(&url);
		bool valid = false;
		int i = 0;
		int len = prefix.length();
		for(i = 0; i < len;i++) {
			if(prefix.char_at(i) == ':') {
				prefix.trim_to_length(i);
				//print("Prefix:%s\n", prefix.to_string());
				valid = true;
				break;
			}
		}
		if(!valid && len != 0) {
			prefix.trim_to_length(0);
		}
	}

}
public delegate void roopkotha.vela.rower.ContentReadyCB(Resource id, Replicable content);
public delegate void roopkotha.vela.rower.ContentErrorCB(Resource id, int code, extring*reason);
public abstract class roopkotha.vela.rower.ResourceHandler : Replicable {
	protected ContentReadyCB?onContentReady;
	protected ContentErrorCB?onContentError;
	public ResourceHandler() {
		onContentReady = null;
	}
	public abstract int request(Resource id);
	public void setContentCallback(ContentReadyCB cb) {
		onContentReady = cb;
	}
	public void setContentErrorCallback(ContentErrorCB cb) {
		onContentError = cb;
	}
}
/** @} */

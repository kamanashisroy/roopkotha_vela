using aroop;
using shotodol;

/** \addtogroup velahandler
 *  @{
 */
public class roopkotha.guiapps.fileloader.DefaultFileResourceHandler : FileResourceHandler {
	public DefaultFileResourceHandler(extring*prefix) {
		base(prefix);
	}

	public void setHandlers() {
		xtring suffix = new xtring.set_static_string(".vapp");
		setHandler(suffix, new VelaAppFileResourceHandler());
	}
}
/** @} */

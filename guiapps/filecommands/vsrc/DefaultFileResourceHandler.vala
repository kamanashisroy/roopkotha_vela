using aroop;
using shotodol;

/** \addtogroup velahandler
 *  @{
 */
public class roopkotha.filecommands.DefaultFileResourceHandler : FileResourceHandler {
	public DefaultFileResourceHandler() {
	}

	public void setHandlers() {
		xtring suffix = new xtring.set_static_string(".vapp");
		setHandler(suffix, new VelaAppFileResourceHandler());
	}
}
/** @} */

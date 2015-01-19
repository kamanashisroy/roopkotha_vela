using aroop;
using shotodol;
using roopkotha.vela.handler;
using roopkotha.guiapps.fileloader;

/** \addtogroup guiapps.fileloader
 *  @{
 */

public abstract class roopkotha.guiapps.fileloader.FileResourceHandler : ResourceHandler {
	extring extension;
	public FileResourceHandler(extring*extn) {
		base();
		extension = extring.copy_on_demand(extn);
	}
	public void getExtensionAs(extring*outvar) {
		outvar.rebuild_and_copy_shallow(&extension);
	}
}
/** @} */

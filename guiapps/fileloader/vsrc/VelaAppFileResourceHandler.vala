using aroop;
using shotodol;
using roopkotha;
using roopkotha.vela.divml;
using roopkotha.vela.handler;

public class roopkotha.guiapps.fileloader.VelaAppFileResourceHandler : FileResourceHandler {
	public VelaAppFileResourceHandler() {
		extring x = extring.set_static_string(".vapp");
		base(&x);
	}
	public override int request(Resource id) {
		print("Loading file ..\n");
		Watchdog.logString(core.sourceFileName(), core.sourceLineNo(), 10, "VelaPadCommand:Open file ...\n");
		extring prefix = extring.stack(id.url.length());
		id.copyPrefix(&prefix);
		extring fn = extring.copy_shallow(&id.url);
		fn.shift(prefix.length()+3);
		print("Loading file %s\n", fn.to_string());
		try {
			FileInputStream fistm = new FileInputStream.from_file(&fn);
			Watchdog.logString(core.sourceFileName(), core.sourceLineNo(), 10, "VelaPadCommand:Open file: Opened file for reading ...\n");

			DivDocument doc = new DivDocument();
			Watchdog.logString(core.sourceFileName(), core.sourceLineNo(), 10, "VelaPadCommand:Open file: Reading ...\n");

			doc.setInputStream(fistm);
			doc.tryReading();
			fistm.close();
			onContentReady(id, doc);

			Watchdog.logString(core.sourceFileName(), core.sourceLineNo(), 10, "VelaPadCommand:Open file: Done.\n");
		} catch(IOStreamError.FileInputStreamError e) {
			Watchdog.logString(core.sourceFileName(), core.sourceLineNo(), 10, "VelaPadCommand:Open file: Could not open file\n");
			return -1;
		}
		return 0;
	}
}

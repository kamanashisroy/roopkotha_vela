using aroop;
using shotodol;
using roopkotha.gui;
using roopkotha.vela;
using roopkotha.vela.divml;
using roopkotha.vela.handler;

/** \addtogroup velapp
 *  @{
 */
/**
 * You can only trust the numbers. 
 * [-Maturity- 10]
 */
internal class roopkotha.velapad.VelaPadMenu : Replicable {
	public PageWindow pg;
	DivDocument emptyDoc;
	public VelaPadMenu() {
		setupGUI();
	}
	void setupGUI() {
		extring velaTitle = extring.set_static_string("Vela");
		extring path = extring.set_static_string("vela/example");
		extring aboutVela = extring.set_static_string("About");
		pg = new PageWindow(&velaTitle, &path, &aboutVela);	
		emptyDoc = new DivDocument();
		/*extring elem = extring.set_static_string("Write something here..");
		emptyDoc.addLine(&elem);*/
		//pg.setDocument(emptyDoc, 0);
		extring baseUrl = extring.set_static_string("");
		extring url = extring.set_static_string("file://empty");
		Resource res = new Resource(&baseUrl, &url, emptyDoc);
	}
	protected void show(DivDocument doc) {
		pg.setDocument(doc, 0);
		pg.show();
	}
}
/** @} */

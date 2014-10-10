using aroop;
using shotodol;
using roopkotha.gui;
using roopkotha.vela;
using roopkotha.veladivml;
using roopkotha.velagent;

/** \addtogroup velapp
 *  @{
 */
/**
 * You can only trust the numbers. 
 * [-Maturity- 10]
 */
internal class roopkotha.velapad.VelaPadMenu : Replicable {
	public PageWindow pg;
	VelaDivDocument emptyDoc;
	public VelaPadMenu() {
		setupGUI();
	}
	void setupGUI() {
		extring velaTitle = extring.set_static_string("Vela");
		extring path = extring.set_static_string("vela/example");
		extring aboutVela = extring.set_static_string("About");
		pg = new PageWindow(&velaTitle, &path, &aboutVela);	
		emptyDoc = new VelaDivDocument();
		/*extring elem = extring.set_static_string("Write something here..");
		emptyDoc.addLine(&elem);*/
		//pg.setDocument(emptyDoc, 0);
		extring baseUrl = extring.set_static_string("");
		extring url = extring.set_static_string("file://empty");
		VelaResource res = new VelaResource(&baseUrl, &url, emptyDoc);
	}
	protected void show(VelaDivDocument doc) {
		pg.setDocument(doc, 0);
		pg.show();
	}
}
/** @} */

using aroop;
using shotodol;
using roopkotha.vela.rower;
using roopkotha.vela.divml;

/** \addtogroup vela.handler;
 *  @{
 */
public class roopkotha.vela.handler.CommandResourceHandler : ResourceHandler {
	M100CommandSet velamds;
	BufferedOutputStream bout;
	CommandResourceHandler.common() {
		bout = new BufferedOutputStream(1024);
	}
	public CommandResourceHandler() {
		velamds = new M100CommandSet();
		CommandResourceHandler.common();
	}
	public CommandResourceHandler.givenCommandSet(M100CommandSet cmds) {
		velamds = cmds;
		CommandResourceHandler.common();
	}
	~CommandResourceHandler() {
	}
	public override int request(Resource id) {
		extring prefix = extring.stack(64);
		id.copyPrefix(&prefix);
		int len = prefix.length();
		print("prefix[%d]:%s\n", len, prefix.to_string());
		extring cmdTxt = extring.copy_shallow(&id.url);
		cmdTxt.shift(len+3);
		bout.reset();
		velamds.act_on(&cmdTxt, bout, null);
		extring content = extring();
		bout.getAs(&content);
		print("[%s]\n", content.to_string());
		xtring cxtring = new xtring.copy_on_demand(&content); // TODO reduce this memcopy
	
		DivDocument pd = new DivDocument();
		//pd.spellChunk(cxtring);
		pd.percept(cxtring);
		onContentReady(id, pd);

		content.destroy();
		return 0;
	}
}
/** @} */

using aroop;
using shotodol;
using roopkotha.vela.divml;
using roopkotha.vela.handler;

/** \addtogroup vela.vela.shake;
 *  @{
 */
public class roopkotha.vela.shake.CommandResourceHandler : vela.handler.URLResourceHandler {
	M100CommandSet velamds;
	BufferedOutputStream bout;
	CommandResourceHandler.common(extring*prefix) {
		base(prefix);
		bout = new BufferedOutputStream(1024);
	}
	public CommandResourceHandler(extring*prefix) {
		velamds = new M100CommandSet();
		CommandResourceHandler.common(prefix);
	}
	public CommandResourceHandler.givenCommandSet(extring*prefix, M100CommandSet cmds) {
		velamds = cmds;
		CommandResourceHandler.common(prefix);
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

using aroop;
using shotodol;
using roopkotha.vela.shake;

/** \addtogroup vela.shake
 *  @{
 */
internal class roopkotha.vela.shake.VelaxecuteCommand : M100Command {
	public VelaxecuteCommand() {
		extring prefix = extring.set_static_string("velaxecute");
		base(&prefix);
	}
	
	public override int act_on(extring*cmdstr, OutputStream pad, M100CommandSet cmds) throws M100CommandError.ActionFailed {
		extring inp = extring.stack_copy_deep(cmdstr);
		extring token = extring();
		LineAlign.next_token(&inp, &token); // second token
		inp.shift(1); // skip the white space
		if(token.is_empty() || inp.is_empty()) {
			throw new M100CommandError.ActionFailed.INVALID_ARGUMENT("Invalid argument");
		}
		extring outmsg = extring();
		extring entry = extring.set_static_string("vela/velaxecute");
		extring dlg = extring.stack(128);
		dlg.printf("executing:%s\n", inp.to_string());
		pad.write(&dlg);
		Plugin.swarm(&entry, &inp, &outmsg);
		return 0;
	}
}
/* @} */

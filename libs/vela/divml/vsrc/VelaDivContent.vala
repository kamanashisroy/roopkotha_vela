using aroop;
using shotodol;
using onubodh;
using roopkotha;
using roopkotha.vela;

/** \addtogroup divml
 *  @{
 */
/**
 * You can only trust the numbers. 
 * [-Maturity- 1]
 */
public class roopkotha.vela.divml.DivContent : roopkotha.vela.richml.RichContent {
	bool focused;
	extring href;
	public DivContent(extring*asciiData, extring*gHref, bool gFocused) {
		base(asciiData);
		focused = gFocused;
		if(gHref != null)
			href = extring.copy_on_demand(gHref);
		else
			href = extring();
	}

	public override bool isFocused() {
		return focused;
	}

	public override bool hasAction() {
		return !href.is_empty();
	}

	public override void getActionAs(extring*data) {
		data.rebuild_and_copy_shallow(&href);
	}
}


/** @} */

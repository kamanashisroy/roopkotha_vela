using aroop;
using roopkotha.vela;
using roopkotha.vela.coordinator;
using roopkotha.vela.handler;

/**
 * \ingroup vela
 * \defgroup vela.menu This is the menu system for vela.
 */

/** \addtogroup vela.menu
 *  @{
 */
internal class roopkotha.vela.menu.PageMenu : Replicable {
	HashTable<xtring,xtring>menuMap;
	PageWindow?page;
	ResourceHandler?handler;
	public PageMenu() {
		menuMap = HashTable<xtring,xtring>(xtring.hCb,xtring.eCb);
		handler = null;
		page = null;
	}

	~PageMenu() {
		menuMap.destroy();
	}

	public void plugPage(PageWindow?pg) {
		if(pg == null) {
			menuMap.markAll(0x02);
			menuMap.pruneMarked(0x02);
		}
		page = pg;
	}

	public void plugHandler(ResourceHandler?givenHandler) {
		handler = givenHandler;
	}

	public void addPageMenu(xtring name, xtring menuMl) {
		menuMap.set(name, menuMl);
	}

	int changePageMenu(extring*nm) {
		xtring?xMenu = menuMap.getProperty(nm);
		if(xMenu == null) {
			return -1;
		}
		plugMenu(xMenu);
		return 0;
	}

	public void onContentDisplay(extring*url) {
		if(changePageMenu(url) != 0) {
			extring deflt = extring.set_static_string("default");
			changePageMenu(&deflt);
		}
	}

	void traverseMenu(onubodh.XMLIterator*xit) {
		if(xit.nextIsText) {
			return;
		}
		extring key = extring.stack(128);
		extring href = extring();
		href.rebuild_in_heap(128);
		extring label = extring();
		label.rebuild_in_heap(32);
		extring attrKey = extring();
		extring attrVal = extring();
		while(xit.nextAttr(&attrKey, &attrVal)) {
			// trim ..
			key.trim_to_length(0);
			key.concat(&attrKey);
			key.zero_terminate();
			while(key.char_at(0) == ' ') {key.shift(1);}
			if(key.equals_string("href")) {
				href.concat(&attrVal);
			} else if(key.equals_string("label")) {
				label.concat(&attrVal);
			}
		}
		while(href.char_at(0) == '"') {href.shift(1);}
		while(href.char_at(href.length()-1) == '"') {href.trim_to_length(href.length()-1);}
		href.zero_terminate();
		if(href.is_empty()) {
			return;
		}
		while(label.char_at(0) == ' ') {label.shift(1);}
		while(label.char_at(0) == '"') {label.shift(1);}
		while(label.char_at(label.length()-1) == '"') {label.trim_to_length(label.length()-1);}
		label.zero_terminate();
		if(label.is_empty()) {
			return;
		}
		PageEventOwner x = new PageEventOwner(&href, &label, handler);
		page.addMenu(x);
		return;
	}
	public int plugMenu(extring*menuML) {
		onubodh.XMLParser parser = new onubodh.XMLParser();
		onubodh.WordMap map = onubodh.WordMap();
		// parse the xml and show the menu
		map.kernel.rebuild_in_heap(menuML.length());
		map.source = extring.copy_on_demand(menuML);
		map.map.rebuild_in_heap(menuML.length());
		parser.transform(&map);

		page.resetMenu();

		// traverse
		//parser.traversePreorder(&map, 100, traverseMenu);
		parser.traversePreorder(&map, 1, traverseMenu);
		page.finalizeMenu();
		map.destroy();
		return 0;
	}
}


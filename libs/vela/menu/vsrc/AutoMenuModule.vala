using aroop;
using shotodol;
using roopkotha.vela;
using roopkotha.vela.handler;

/** \addtogroup vela.menu
 *  @{
 */
public class roopkotha.vela.menu.AutoMenuModule : Module {
	PageMenu pmenuLoader;
	public AutoMenuModule() {
		extring nm = extring.set_string(core.sourceModuleName());
		extring ver = extring.set_static_string("0.0.0");
		base(&nm,&ver);
		pmenuLoader = new PageMenu();
	}

	public override int init() {
		extring entry = extring.set_static_string("vela/command");
		PluginManager.register(&entry, new M100Extension(new PageMenuCommand(pmenuLoader), this));
		entry.rebuild_and_set_static_string("vela/onContentDisplay");
		PluginManager.register(&entry, new HookExtension(onContentDisplayHook, this));
		entry.rebuild_and_set_static_string("rehash");
		PluginManager.register(&entry, new HookExtension(rehashHook, this));
		return 0;
	}

	int onContentDisplayHook(extring*msg, extring*output) {
		print("we should register menu for %s\n", msg.to_string());
		pmenuLoader.onContentDisplay(msg);
		return 0;
	}

	int rehashHook(extring*msg, extring*output) {
		/**
		 * Load page, handler and vela/page/menue
		 */
		if(loadPage() != -1 && loadHandler() != -1)
			loadPageMenu();
		return 0;
	}

	int loadPage() {
		extring pgcb = extring.set_static_string("vela/page");
		PluginManager.acceptVisitor(&pgcb, (x) => {
			PageWindow page = (PageWindow)x.getInterface(null);
			pmenuLoader.plugPage(page);
		});
		return 0;
	}

	int loadHandler() {
		extring pageHandler = extring.set_static_string("vela/page/handler");
		PluginManager.acceptVisitor(&pageHandler, (x) => {
			ResourceHandler handler = (ResourceHandler)x.getInterface(null);
			pmenuLoader.plugHandler(handler);
		});
		return 0;
	}

	int loadPageMenu() {
		/**
		 * Each menu consits of a key and value. The key and value is seperated by a space. And each key-value pair ends with a newline.
		 * Example:
		 * default <x href=\"velaxecute://ls\" label=Open></x><x href=\"velaxecute://history -b 99 \" label=Quit></x><x href=\"velafopen://about.vapp\" label=About></x>\n
		 * 
		 */
		extring entry = extring.set_static_string("vela/page/menu");
		extring outml = extring();
		PluginManager.swarm(&entry, &entry, &outml);
		extring content = extring.stack_copy_deep(&outml);
		extring space = extring.set_static_string(" ");
		do {
			extring next = extring.copy_shallow(&content);
			int i = 0;
			for(i = 0;i < next.length() && next.char_at(i) != '\n';i++);
			content.shift(i);
			next.truncate(i);
			if(next.is_empty()) break;
			extring name = extring();
			LineAlign.next_token_delimitered_sliteral(&next, &name, &space);
			if(name.is_empty() || next.is_empty()) continue;
			xtring path = new xtring.copy_deep(&name);
			xtring menuml = new xtring.copy_deep(&next);
			pmenuLoader.addPageMenu(path, menuml);
		} while(true);
		return 0;
	}

	public override int deinit() {
		PluginManager.unregisterModule(this);
		base.deinit();
		return 0;
	}
}

Roadmap
========

- [x] Write all gui commands in _vela/command_ space. Rehash and execute them from command handler.
- [x] Write all the resource handlers in _vela/handler_ space.
- [x] Write all the file handlers in _vela/file/handler_ space.
- [ ] Write all the document types in _doctype_ space.
- [ ] Write markdown rendering support.
- [ ] Study scintilla for scrolling.
- [ ] Study scintilla for editing.
- [ ] Write a document to go from anjuta to roopkotha( I mean a copy of anjuta in roopkotha way) .
- [x] Create separate projects named roopkotha_vela, roopkotha_editor etc. 
- [x] Study scintilla,jedit and eclipse for writing plugin.
	- scintilla has scinterm(an ncurses frontend for the library).
	- jedit loads a plugin.prop and actions.xml file. [see more](http://www.jedit.org/users-guide/plugin-implement-quicknotepadplugin.html), [services.xml](http://www.jedit.org/users-guide/plugin-implement-services.html),[dockables.xml](http://www.jedit.org/users-guide/plugin-implement-dockables.html),[BeanShell](http://www.jedit.org/users-guide/plugin-debugging.html) . 
	- eclipse has plugin.xml file. In this file it has **extension point**.
- [ ] Study component diagrams and class diagrams.
	- [ ] for scintilla,
	- [ ] for jedit and
	- [ ] for eclipse plugin.
- [ ] Is it possible to use scintilla library based module here ?



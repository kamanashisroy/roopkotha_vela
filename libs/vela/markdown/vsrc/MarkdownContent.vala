/*
 * This file part of MiniIM.
 *
 * Copyright (C) 2007  Kamanashis Roy
 *
 * MiniIM is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * MiniIM is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with MiniIM.  If not, see <http://www.gnu.org/licenses/>.
 *
 */
using aroop;
using shotodol;
using onubodh;
using roopkotha;
using roopkotha.vela;

/** \addtogroup markdown
 *  @{
 */
/**
 * You can only trust the numbers. 
 * [-Maturity- 10]
 */
public class roopkotha.vela.markdown.MarkdownContent : roopkotha.vela.FormattedContent {
	MarkdownParser parser;
	WordMap map;

	public MarkdownContent(extring*asciiData) {
		base(asciiData);
		parser = new MarkdownParser();
		map = WordMap();
		map.kernel.rebuild_in_heap(asciiData.length());
		map.source = extring.copy_on_demand(asciiData);
		map.map.rebuild_in_heap(asciiData.length());
		parser.transform(&map);
		//print("FormattedContent:%s\n", asciiData.to_string());
	}

	~MarkdownContent() {
		map.destroy();
	}

#if false
	public override void getText(extring*tData) {
		tData.concat(data);
	}
#endif

	MarkdownIterator rxit;
	public override void traverseCapsulesInit() {
		rxit = MarkdownIterator(&map);
		rxit.kernel = extring.copy_shallow(&map.kernel);
	}
	public override int traverseCapsules(VisitAugmentedContent visitCapsule) {
		//print("Traversing capsules ..\n");
		parser.traversePreorder2(&rxit, 1, (xit) => {
			FormattedTextCapsule cap = FormattedTextCapsule();
			cap.textType = FormattedTextType.UNKNOWN;
			if(xit.objectType == MarkObject.PLAIN_OBJECT) {
				//print("Traversing text capsules ..\n");
#if LOW_MEMORY
				cap.content = extring.stack(128);
#else
				cap.content = extring.stack(1024);
#endif
				cap.textType = FormattedTextType.PLAIN;
				xit.m.getSourceReferenceAs(xit.basePos + xit.shift, xit.basePos + xit.shift + xit.content.length(), &cap.content);
				//print("Text\t\t- pos:%d,clen:%d,text content:%s\n", xit.pos, xit.content.length(), cap.content.to_string());
				//print("[%s]", map.source.to_string());
				visitCapsule(&cap);
			} else {
				//print("Traversing non-text capsules ..%s\n",xit.nextTag.to_string());
				switch(xit.objectType) {
				case MarkObject.DOUBLE_STARRED_OBJECT:
					cap.textType = FormattedTextType.B;
					break;
				/*case MarkObject.LINEBREAK_OBJECT:
					cap.textType = FormattedTextType.BR;
					break;*/
				case MarkObject.SQUARED_OBJECT:
					cap.textType = FormattedTextType.A;
					break;
				case MarkObject.STARRED_OBJECT:
				case MarkObject.UNDERSCORED_OBJECT:
					cap.textType = FormattedTextType.I;
					break;
				case MarkObject.PLAIN_OBJECT:
					cap.textType = FormattedTextType.PLAIN;
					break;
				case MarkObject.LINEBREAK_OBJECT:
					cap.textType = FormattedTextType.P;
					break;
				default:
					cap.textType = FormattedTextType.UNKNOWN;
					break;
				}
				visitCapsule(&cap);
				//print("End of non-text capsules ..%s\n",xit.nextTag.to_string());
			}
		});
		return 0;
	}

#if false
	int update(extring*xt) {
		struct xultb_ml_node*node = item->target;
		SYNC_ASSERT(node);
		xultb_str_t*new_text = OPPREF(text);
		OPPUNREF(node->elem.content);
		GUI_INPUT_LOG("setting new text %s\n", new_text->str);
		node->elem.content = new_text;
		return 0;
	}
#endif
}


/** @} */

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

/** \addtogroup velarichml
 *  @{
 */
/**
 * You can only trust the numbers. 
 * [-Maturity- 10]
 */
public class roopkotha.velarichml.VelaRichContent : roopkotha.vela.FormattedContent {
	XMLParser parser;
	WordMap map;

	public VelaRichContent(extring*asciiData) {
		base(asciiData);
		parser = new XMLParser();
		map = WordMap();
		map.kernel.rebuild_in_heap(asciiData.length());
		map.source = extring.copy_on_demand(asciiData);
		map.map.rebuild_in_heap(asciiData.length());
		parser.transform(&map);
		//print("FormattedContent:%s\n", asciiData.to_string());
	}

	~VelaRichContent() {
		map.destroy();
	}

#if false
	public override void getText(extring*tData) {
		tData.concat(data);
	}
#endif

#if false
	public override bool isFocused() {
		xultb_str_t*focused = xultb_ml_get_attribute_value(elem, "focused");
		if(focused && xultb_str_equals_static(focused, "yes")) {
			return true;
		}
		return false;
	}
#endif

#if false
	public override bool isActive() {
		xultb_str_t*active = xultb_ml_get_attribute_value(elem, "active");
		if(active && xultb_str_equals_static(active, "yes")) {
			return true;
		}
		return false;
	}
#endif

	XMLIterator rxit;
	public override void traverseCapsulesInit() {
		rxit = XMLIterator(&map);
		rxit.kernel = extring.copy_shallow(&map.kernel);
	}
	public override int traverseCapsules(VisitAugmentedContent visitCapsule) {
		//print("Traversing capsules ..\n");
		parser.traversePreorder2(&rxit, 1, (xit) => {
			FormattedTextCapsule cap = FormattedTextCapsule();
			cap.textType = FormattedTextType.UNKNOWN;
			if(xit.nextIsText) {
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
				if(xit.nextTag.equals_static_string("B")) {
					cap.textType = FormattedTextType.B;
				} else if(xit.nextTag.equals_static_string("BR")) {
					cap.textType = FormattedTextType.BR;
				} else if(xit.nextTag.equals_static_string("IMG")) {
					cap.textType = FormattedTextType.IMG;
				} else if(xit.nextTag.equals_static_string("I")) {
					cap.textType = FormattedTextType.I;
				} else if(xit.nextTag.equals_static_string("BIG")) {
					cap.textType = FormattedTextType.BIG;
				} else if(xit.nextTag.equals_static_string("SMALL")) {
					cap.textType = FormattedTextType.SMALL;
				} else if(xit.nextTag.equals_static_string("STRONG")) {
					cap.textType = FormattedTextType.STRONG;
				} else if(xit.nextTag.equals_static_string("EM")) {
					cap.textType = FormattedTextType.EM;
				} else if(xit.nextTag.equals_static_string("U")) {
					cap.textType = FormattedTextType.U;
				} else if(xit.nextTag.equals_static_string("P")) {
					cap.textType = FormattedTextType.P;
				} else if(xit.nextTag.equals_static_string("A")) {
					cap.textType = FormattedTextType.A;
				} else {
					cap.textType = FormattedTextType.UNKNOWN;
				}
				extring attrKey = extring();
				extring attrVal = extring();
				while(xit.nextAttr(&attrKey, &attrVal)) {
					// TODO trim key and value
					//print("key:[%s],val:[%s]\n", attrKey.to_string(), attrVal.to_string());
					if(attrKey.equals_static_string("href")) {
						cap.hyperLink.destroy();
						cap.hyperLink = extring.copy_shallow(&attrVal);
					} else if(attrKey.equals_static_string("f")) {
						if(attrVal.equals_static_string("true"))	{
							cap.isFocused = true;
						}
					} else if(attrKey.equals_static_string("a")) {
						if(attrVal.equals_static_string("true"))	{
							cap.isActive = true;
						}
					}
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

using aroop;
using shotodol;
using roopkotha.gui;
using roopkotha.doc;
using roopkotha.vela;

/**
 * \ingroup vela
 * \defgroup richml HTML like markup content support to display application controls.
 */

/** \addtogroup richml
 *  @{
 */
/**
 * You can only trust the numbers. 
 * [-Maturity- 30]
 */
/**
 * This is the base class for all the documents we render in roopkotha
 */
public class roopkotha.vela.richml.RichDocument : roopkotha.doc.RoopDocument {
	int counter;
	InputStream? instrm;
	public RichDocument() {
		counter = 0;
		instrm = null;
		base();
	}
	
	public virtual void spellChunk(extring*asciiData) {
		RichContent c = new RichContent(asciiData);
		//print("VelaRichContent:Adding line:%s\n", asciiData.to_string());
		contents.set(counter++, c);
	}

	public void setInputStream(InputStream istrm) {
		instrm = istrm;
	}

	public void tryReading() {
		do {
#if LOW_MEMORY
			extring data = extring.stack(1024);
#else
			extring data = extring.stack(1<<12);
#endif
			core.assert(instrm != null);
			try {
				int bytesRead = instrm.read(&data);
				if(bytesRead == 0) break;
				spellChunk(&data);
			} catch(IOStreamError.InputStreamError e) {
				break;
			}
		} while(true);
	}
}
/** @} */

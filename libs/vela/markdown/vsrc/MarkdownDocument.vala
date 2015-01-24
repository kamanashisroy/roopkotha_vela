using aroop;
using shotodol;
using roopkotha.gui;
using roopkotha.doc;
using roopkotha.vela;

/**
 * \ingroup vela
 * \defgroup markdown This package helps to render markdown content.
 */

/** \addtogroup markdown
 *  @{
 */
/**
 * You can only trust the numbers. 
 * [-Maturity- 30]
 */
/**
 * This is the base class for all the documents we render in roopkotha
 */
public class roopkotha.vela.markdown.MarkdownDocument : roopkotha.doc.RoopDocument {
	int counter;
	InputStream? instrm;
	public MarkdownDocument() {
		counter = 0;
		instrm = null;
		base();
	}
	
	public virtual void spellChunk(extring*asciiData) {
		asciiData.zero_terminate();
		print("Markup content[%s]\n", asciiData.to_string());
		MarkdownContent c = new MarkdownContent(asciiData);
		contents.set(counter++, c);
	}

	public void setInputStream(InputStream istrm) {
		instrm = new LineInputStream.full(false, 1024, istrm);
	}

	public void tryReading() {
#if LOW_MEMORY
		extring data = extring.stack(1024);
#else
		extring data = extring.stack(1<<12);
#endif
		do {
			core.assert(instrm != null);
			try {
				int bytesRead = instrm.read(&data);
				if(bytesRead == 0) {
					if(data.length() != 0)spellChunk(&data);
					break;
				}
				if(bytesRead <= 3) {
					uchar c = data.char_at(data.length()-1);
					if(c == '\r' || c == '\n') {
						spellChunk(&data);
						data.trim_to_length(0);
					}
				}
				if(data.length() > 0) {
					data.concat_char(' ');
				}
			} catch(IOStreamError.InputStreamError e) {
				break;
			}
		} while(true);
	}
}
/** @} */

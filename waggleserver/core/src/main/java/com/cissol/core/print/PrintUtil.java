package com.cissol.core.print;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.Shape;
import java.awt.font.FontRenderContext;
import java.awt.font.GlyphVector;
import java.awt.font.LineBreakMeasurer;
import java.awt.font.LineMetrics;
import java.awt.font.TextAttribute;
import java.awt.font.TextLayout;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Rectangle2D;
import java.awt.geom.RoundRectangle2D;
import java.awt.print.Book;
import java.awt.print.PageFormat;
import java.awt.print.Paper;
import java.awt.print.Printable;
import java.awt.print.PrinterJob;
import java.text.AttributedCharacterIterator;
import java.text.AttributedString;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.swing.JOptionPane;

public class PrintUtil {
	public static void main(String[] args) {

		PrintUtil print = new PrintUtil();
		System.exit(0);
	}

	private final static int POINTS_PER_INCH = 72;
	private final static double PAGE_WIDTH = 8.27;
	private final static double PAGE_HEIGHT = 11.69;

	public PrintUtil() {

		PrinterJob printJob = PrinterJob.getPrinterJob();

		Book book = new Book();

		Paper p = new Paper();
		p.setSize(PAGE_WIDTH * POINTS_PER_INCH, PAGE_HEIGHT * POINTS_PER_INCH);
		p.setImageableArea(10, 10, (PAGE_WIDTH * POINTS_PER_INCH) - 20, (PAGE_HEIGHT * POINTS_PER_INCH) - 20);
		PageFormat documentPageFormat = new PageFormat();
		documentPageFormat.setOrientation(PageFormat.PORTRAIT);
		documentPageFormat.setPaper(p);
		book.append(new Document(), documentPageFormat);

		printJob.setPageable(book);

		// if (printJob.printDialog()) {
		try {
			printJob.print();
		} catch (Exception PrintException) {
			PrintException.printStackTrace();
		}
		// }

	}

	public Document getDocument() {
		return new Document();
	}

	private class Document implements Printable {
		private double pageHeight = 0;
		private double pageWidth = 0;

		public int print(Graphics g, PageFormat pageFormat, int page) {
			// --- Create the Graphics2D object
			Graphics2D g2d = (Graphics2D) g;

			// --- Translate the origin to 0,0 for the top left corner
			g2d.translate(pageFormat.getPaper().getImageableX(), pageFormat.getPaper().getImageableY());

			// --- Set the drawing color to black
			g2d.setPaint(Color.black);

			// --- Draw a border arround the page using a 12 point border
			pageHeight = pageFormat.getPaper().getImageableHeight();
			pageWidth = pageFormat.getPaper().getImageableWidth();
			g2d.setStroke(new BasicStroke(1));
			Rectangle2D.Double border = new Rectangle2D.Double(0, 0, pageWidth, pageHeight);
			g2d.draw(border);

			Rectangle2D.Double header = new Rectangle2D.Double(134, 60, 200, 30);
			g2d.draw(header);

			drawCenteredString(g2d, header, "M.R.HYDRAULICS", "HELVETICA", 20, true);

			ArrayList<HashMap<String, Object>> cols = new ArrayList<HashMap<String, Object>>();
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("width", 100);
			m.put("caption", "Name");
			m.put("align", "L");
			cols.add(m);
			m = new HashMap<String, Object>();
			m.put("width", 100);
			m.put("caption", "Rate");
			m.put("align", "R");
			cols.add(m);
			m = new HashMap<String, Object>();
			m.put("width", 200);
			m.put("caption", "Item");
			cols.add(m);
			ArrayList<ArrayList<String>> a = new ArrayList<ArrayList<String>>();
			for (int v = 0; v < 20; v++) {
				ArrayList<String> z = new ArrayList<String>();
				z.add("xyz xyz xyz xyz xyz xyz xyz xyz xyz xyzx zyx zyx zyx zyx zyx zyx");
				z.add(String.valueOf(300 + v));
				z.add("xyz123" + v);
				a.add(z);
			}
			drawTableDetail(g2d, 0, 100, 300, 20, 10, cols, a);
			drawTable(g2d, 0, 100, 400, 300, 20, cols);
			HashMap<String, Object> m1 = new HashMap<String, Object>();
			m1.put("lbl_x", 0);
			m1.put("lbl_y", 10);
			m1.put("lbl_width", 50);
			m1.put("caption", "TIN No");
			m1.put("lbl_align", "L");
			m1.put("lbl_height", 15);
			m1.put("lbl_font", "Arial");
			m1.put("lbl_size", 10);
			m1.put("lbl_bold", true);
			writeFieldCaption(g2d, m1);
			m1 = new HashMap<String, Object>();
			m1.put("lbl_x", 0);
			m1.put("lbl_y", 25);
			m1.put("lbl_width", 50);
			m1.put("caption", "CST No");
			m1.put("lbl_align", "L");
			m1.put("lbl_height", 15);
			m1.put("lbl_font", "Arial");
			m1.put("lbl_size", 10);
			m1.put("lbl_bold", true);
			writeFieldCaption(g2d, m1);
			m1 = new HashMap<String, Object>();
			m1.put("lbl_x", 0);
			m1.put("lbl_y", 40);
			m1.put("lbl_width", 50);
			m1.put("caption", "IAC No");
			m1.put("lbl_align", "L");
			m1.put("lbl_height", 15);
			m1.put("lbl_font", "Arial");
			m1.put("lbl_size", 10);
			m1.put("lbl_bold", true);
			writeFieldCaption(g2d, m1);

			m1 = new HashMap<String, Object>();
			m1.put("x", 50);
			m1.put("y", 10);
			m1.put("width", (int) (Math.round(pageWidth / 3) - 50));
			m1.put("value", "1235464748");
			m1.put("align", "L");
			m1.put("height", 15);
			m1.put("font", "Arial");
			m1.put("size", 10);
			m1.put("bold", false);
			writeField(g2d, m1);
			m1 = new HashMap<String, Object>();
			m1.put("x", 50);
			m1.put("y", 25);
			m1.put("width", (int) (Math.round(pageWidth / 3) - 50));
			m1.put("value", "1235464748");
			m1.put("align", "L");
			m1.put("height", 15);
			m1.put("font", "Arial");
			m1.put("size", 10);
			m1.put("bold", false);
			writeField(g2d, m1);
			m1 = new HashMap<String, Object>();
			m1.put("x", 50);
			m1.put("y", 40);
			m1.put("width", (int) (Math.round(pageWidth / 3) - 50));
			m1.put("value", "1235464748");
			m1.put("align", "L");
			m1.put("height", 15);
			m1.put("font", "Arial");
			m1.put("size", 10);
			m1.put("bold", false);
			writeField(g2d, m1);

			m1 = new HashMap<String, Object>();
			m1.put("lbl_x", (int) (Math.round(pageWidth / 3) * 2));
			m1.put("lbl_y", 10);
			m1.put("lbl_width", 50);
			m1.put("caption", "Cell:");
			m1.put("lbl_align", "R");
			m1.put("lbl_height", 15);
			m1.put("lbl_font", "Arial");
			m1.put("lbl_size", 10);
			m1.put("lbl_bold", true);
			writeFieldCaption(g2d, m1);
			m1 = new HashMap<String, Object>();
			m1.put("lbl_x", (int) (Math.round(pageWidth / 3) * 2));
			m1.put("lbl_y", 25);
			m1.put("lbl_width", 50);
			m1.put("caption", "Tele Fax:");
			m1.put("lbl_align", "R");
			m1.put("lbl_height", 15);
			m1.put("lbl_font", "Arial");
			m1.put("lbl_size", 10);
			m1.put("lbl_bold", true);
			writeFieldCaption(g2d, m1);
			m1 = new HashMap<String, Object>();
			m1.put("lbl_x", (int) (Math.round(pageWidth / 3) * 2));
			m1.put("lbl_y", 40);
			m1.put("lbl_width", 50);
			m1.put("caption", "EmailID:");
			m1.put("lbl_align", "R");
			m1.put("lbl_height", 15);
			m1.put("lbl_font", "Arial");
			m1.put("lbl_size", 10);
			m1.put("lbl_bold", true);
			writeFieldCaption(g2d, m1);

			m1 = new HashMap<String, Object>();
			m1.put("x", (int) (Math.round(pageWidth / 3) * 2) + 50);
			m1.put("y", 10);
			m1.put("width", (int) (Math.round(pageWidth / 3) - 50));
			m1.put("value", "98427-03786");
			m1.put("align", "L");
			m1.put("height", 15);
			m1.put("font", "Arial");
			m1.put("size", 10);
			m1.put("bold", false);
			writeField(g2d, m1);
			m1 = new HashMap<String, Object>();
			m1.put("x", (int) (Math.round(pageWidth / 3) * 2) + 50);
			m1.put("y", 25);
			m1.put("width", (int) (Math.round(pageWidth / 3) - 50));
			m1.put("value", "0427-2446118");
			m1.put("align", "L");
			m1.put("height", 15);
			m1.put("font", "Arial");
			m1.put("size", 10);
			m1.put("bold", false);
			writeField(g2d, m1);
			m1 = new HashMap<String, Object>();
			m1.put("x", (int) (Math.round(pageWidth / 3) * 2) + 50);
			m1.put("y", 40);
			m1.put("width", (int) (Math.round(pageWidth / 3) - 50));
			m1.put("value", "mrhydraulichose@yahoo.com");
			m1.put("align", "L");
			m1.put("height", 15);
			m1.put("font", "Arial");
			m1.put("size", 10);
			m1.put("bold", false);
			writeField(g2d, m1);

			drawUnderlinedCaption(g2d, (int) (Math.round(pageWidth / 3)), 40, (int) Math.round(pageWidth / 3), 20,
					"Invoice", "Arial", 12, true);
			if (page > 0) {
				return (NO_SUCH_PAGE);
			}
			return (PAGE_EXISTS);

		}

		private void drawCenteredString(Graphics2D g2d, Shape parent, String s, String fontName, int fontSize,
				boolean bold) {
			Font font = null;
			if (bold) {
				font = new Font(fontName, Font.BOLD, fontSize);
			} else {
				font = new Font(fontName, Font.PLAIN, fontSize);
			}
			g2d.setFont(font);

			FontRenderContext frc = g2d.getFontRenderContext();
			FontMetrics fm = g2d.getFontMetrics();
			float sw = (float) fm.stringWidth(s);
			LineMetrics lm = font.getLineMetrics(s, frc);
			float sh = lm.getAscent() + lm.getDescent();

			float sx = (float) (parent.getBounds().x + ((parent.getBounds().width - sw) / 2));
			float sy = (float) (parent.getBounds().y + (parent.getBounds().height + sh) / 2 - lm.getDescent());
			g2d.drawString(s, sx, sy);
		}

		private void drawTable(Graphics2D g2d, int x, int y, int width, int height, int headerHeight,
				ArrayList<HashMap<String, Object>> cols) {
			int s = cols.size();
			int xx = x;
			int yy = y;
			for (int i = 0; i < s; i++) {
				HashMap<String, Object> m = cols.get(i);
				Rectangle2D.Double col = new Rectangle2D.Double(xx, yy, (Integer) m.get("width"), headerHeight);
				g2d.draw(col);
				Line2D.Double l = new Line2D.Double(xx, yy + headerHeight, xx, yy + height);
				g2d.draw(l);
				xx += (Integer) m.get("width");
				drawCenteredString(g2d, col, (String) m.get("caption"), "HELVATICA", headerHeight - 10, true);
			}
			Line2D.Double last = new Line2D.Double(xx, yy + headerHeight, xx, yy + height);
			g2d.draw(last);
			Line2D.Double bottom = new Line2D.Double(x, y + height, x + width, y + height);
			g2d.draw(bottom);
		}

		private int drawLeftAlignedText(Graphics2D g2d, String s, int x, int y, int width, int height,
				int containerHeight, String fontName, int fontSize, boolean bold) {
			int noOfLines = 1;
			Font font = null;
			if (bold) {
				font = new Font(fontName, Font.BOLD, fontSize);
			} else {
				font = new Font(fontName, Font.PLAIN, fontSize);
			}
			g2d.setFont(font);
			FontRenderContext frc = g2d.getFontRenderContext();
			FontMetrics fm = g2d.getFontMetrics();
			float sw = (float) fm.stringWidth(s);
			LineMetrics lm = font.getLineMetrics(s, frc);
			float sh = lm.getAscent() + lm.getDescent();
			float margin = 2;
			float sx = (float) x + margin;
			float sy = (float) y;
			System.out.println(s + " " + sw + " " + width);
			if (sw > width) {
				AttributedString s1 = new AttributedString(s);
				AttributedCharacterIterator paragraph = s1.getIterator();
				int paragraphStart = paragraph.getBeginIndex();
				int paragraphEnd = paragraph.getEndIndex();
				LineBreakMeasurer lineMeasurer = new LineBreakMeasurer(paragraph, frc);

				float breakWidth = (float) width;
				float drawPosY = y;
				lineMeasurer.setPosition(paragraphStart);

				while (lineMeasurer.getPosition() < paragraphEnd) {
					TextLayout layout = lineMeasurer.nextLayout(breakWidth);
					float drawPosX = sx;
					layout.draw(g2d, drawPosX, drawPosY);
					drawPosY += height;
					noOfLines++;
					if (drawPosY - y > containerHeight) {
						break;
					}
				}
			} else {
				g2d.drawString(s, sx, sy);
			}
			return noOfLines;
		}

		private int drawRightAlignedText(Graphics2D g2d, String s, int x, int y, int width, String fontName,
				int fontSize, boolean bold) {
			Font font = null;
			if (bold) {
				font = new Font(fontName, Font.BOLD, fontSize);
			} else {
				font = new Font(fontName, Font.PLAIN, fontSize);
			}
			g2d.setFont(font);
			FontRenderContext frc = g2d.getFontRenderContext();
			FontMetrics fm = g2d.getFontMetrics();
			float sw = (float) fm.stringWidth(s);
			LineMetrics lm = font.getLineMetrics(s, frc);
			float sh = lm.getAscent() + lm.getDescent();
			float margin = 2;
			float sx = (float) (x + (width - sw)) - margin;
			float sy = (float) y;
			g2d.drawString(s, sx, sy);
			return 1;
		}

		private int drawCenterAlignedText(Graphics2D g2d, String s, int x, int y, int width, String fontName,
				int fontSize, boolean bold) {
			Font font = null;
			if (bold) {
				font = new Font(fontName, Font.BOLD, fontSize);
			} else {
				font = new Font(fontName, Font.PLAIN, fontSize);
			}
			g2d.setFont(font);
			FontRenderContext frc = g2d.getFontRenderContext();
			FontMetrics fm = g2d.getFontMetrics();
			float sw = (float) fm.stringWidth(s);
			LineMetrics lm = font.getLineMetrics(s, frc);
			float sh = lm.getAscent() + lm.getDescent();
			float margin = 2;
			float sx = (float) (x + ((width - sw) / 2)) + margin;
			float sy = (float) y;
			g2d.drawString(s, sx, sy);
			return 1;
		}

		private void drawTableDetail(Graphics2D g2d, int x, int y, int minHeight, int headerHeight, int rowHeight,
				ArrayList<HashMap<String, Object>> cols, ArrayList<ArrayList<String>> values) {
			int s = cols.size();
			int sv = values.size();
			int xx = x;
			int yy = y + headerHeight + 10;
			for (int j = 0; j < sv; j++) {
				xx = x;
				ArrayList<String> a = values.get(j);
				int wrap = 1;
				for (int i = 0; i < s; i++) {
					HashMap<String, Object> m = cols.get(i);
					int w = (Integer) m.get("width");
					int ww = 0;
					if ("C".equals(m.get("align"))) {
						ww = drawCenterAlignedText(g2d, a.get(i), xx, yy, w, "Times New Roman", 10, false);
					} else if ("R".equals(m.get("align"))) {
						ww = drawRightAlignedText(g2d, a.get(i), xx, yy, w, "Times New Roman", 10, false);
					} else {
						ww = drawLeftAlignedText(g2d, a.get(i), xx, yy, w, rowHeight, minHeight - (yy - y),
								"Times New Roman", 10, false);
					}
					if (wrap < ww) {
						wrap = ww;
					}
					xx += w;
				}
				yy += rowHeight * wrap;
				System.out.println(j + " " + yy + " " + wrap);
				if (yy - y > minHeight) {
					break;
				}
			}
		}

		private void writeFieldCaption(Graphics2D g2d, HashMap<String, Object> field) {
			int x = (Integer) field.get("lbl_x");
			int y = (Integer) field.get("lbl_y");
			int width = (Integer) field.get("lbl_width");
			int height = (Integer) field.get("lbl_height");
			String fontName = (String) field.get("lbl_font");
			int fontSize = (Integer) field.get("lbl_size");
			String align = (String) field.get("lbl_align");
			boolean bold = (Boolean) field.get("lbl_bold");
			String caption = (String) field.get("caption");
			if ("C".equals(align)) {
				drawCenterAlignedText(g2d, caption, x, y, width, fontName, fontSize, bold);
			} else if ("R".equals(align)) {
				drawRightAlignedText(g2d, caption, x, y, width, fontName, fontSize, bold);
			} else {
				drawLeftAlignedText(g2d, caption, x, y, width, height, height, fontName, fontSize, bold);
			}
			drawRightAlignedText(g2d, ":", x, y, width, fontName, fontSize, bold);
		}

		private void writeField(Graphics2D g2d, HashMap<String, Object> field) {
			int x = (Integer) field.get("x");
			int y = (Integer) field.get("y");
			int width = (Integer) field.get("width");
			int height = (Integer) field.get("height");
			String fontName = (String) field.get("font");
			int fontSize = (Integer) field.get("size");
			String align = (String) field.get("align");
			boolean bold = (Boolean) field.get("bold");
			String caption = (String) field.get("value");
			if ("C".equals(align)) {
				drawCenterAlignedText(g2d, caption, x, y, width, fontName, fontSize, bold);
			} else if ("R".equals(align)) {
				drawRightAlignedText(g2d, caption, x, y, width, fontName, fontSize, bold);
			} else {
				drawLeftAlignedText(g2d, caption, x, y, width, height, height, fontName, fontSize, bold);
			}
		}

		private void drawRoundRectangleCaption(Graphics2D g2d, int x, int y, int width, int height, String s,
				String fontName, int fontSize, boolean bold) {
			Font font = null;
			if (bold) {
				font = new Font(fontName, Font.BOLD, fontSize);
			} else {
				font = new Font(fontName, Font.PLAIN, fontSize);
			}
			g2d.setFont(font);

			FontRenderContext frc = g2d.getFontRenderContext();
			FontMetrics fm = g2d.getFontMetrics();
			float sw = (float) fm.stringWidth(s);
			LineMetrics lm = font.getLineMetrics(s, frc);
			float sh = lm.getAscent() + lm.getDescent();

			float sx = (float) (x + ((width - sw) / 2));
			float sy = (float) (y + (height + sh) / 2 - lm.getDescent());
			g2d.drawString(s, sx, sy);
			RoundRectangle2D.Double r = new RoundRectangle2D.Double((int) sx, y, (int) sw, height, 10, 10);
			g2d.draw(r);
		}

		private void drawUnderlinedCaption(Graphics2D g2d, int x, int y, int width, int height, String s,
				String fontName, int fontSize, boolean bold) {
			Font font = null;
			if (bold) {
				font = new Font(fontName, Font.BOLD, fontSize);
			} else {
				font = new Font(fontName, Font.PLAIN, fontSize);
			}
			Hashtable<TextAttribute, Object> map = new Hashtable<TextAttribute, Object>();
			map.put(TextAttribute.UNDERLINE, TextAttribute.UNDERLINE_ON);
			font = font.deriveFont(map);
			g2d.setFont(font);

			FontRenderContext frc = g2d.getFontRenderContext();
			FontMetrics fm = g2d.getFontMetrics();
			float sw = (float) fm.stringWidth(s);
			LineMetrics lm = font.getLineMetrics(s, frc);
			float sh = lm.getAscent() + lm.getDescent();

			float sx = (float) (x + ((width - sw) / 2));
			float sy = (float) (y + (height + sh) / 2 - lm.getDescent());
			g2d.drawString(s, sx, sy);
		}
	}

} // Example3

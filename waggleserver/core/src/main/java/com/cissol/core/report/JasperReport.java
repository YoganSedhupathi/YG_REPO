package com.cissol.core.report;

import java.awt.Color;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import net.sf.jasperreports.engine.design.*;
import net.sf.jasperreports.engine.type.CalculationEnum;
import net.sf.jasperreports.engine.type.HorizontalTextAlignEnum;
import net.sf.jasperreports.engine.type.HyperlinkTargetEnum;
import net.sf.jasperreports.engine.type.HyperlinkTypeEnum;
import net.sf.jasperreports.engine.type.ModeEnum;
import net.sf.jasperreports.engine.type.OrientationEnum;
import net.sf.jasperreports.engine.type.ResetTypeEnum;
import net.sf.jasperreports.engine.type.SortFieldTypeEnum;
import net.sf.jasperreports.engine.type.SortOrderEnum;
import net.sf.jasperreports.engine.type.SplitTypeEnum;
import net.sf.jasperreports.engine.type.StretchTypeEnum;
import net.sf.jasperreports.engine.*;

public class JasperReport {
	ResultSetMetaData rsmd = null;
	JasperDesign jasperDesign = null;
	JRDesignStyle normalStyle = null;
	JRDesignStyle boldStyle = null;
	JRDesignStyle italicStyle = null;
	int columnWidth = 0;
	int width = 0;
	int height = 0;
	int rightLeftmargin = 0;
	int topBottomMargin = 0;
	int noOfRows = 0;
	StringBuffer closingExpression = new StringBuffer(100);
	String type = "pdf";
	String linkServerName = "";

	public void setLinkServerName(String serverName) {
		this.linkServerName = serverName;
	}

	public void setNumberOfRows(int rows) {
		this.noOfRows = rows;
	}

	public void setType(String type) {
		this.type = type;
	}

	public enum PageSizeEnum {
		A4, A3
	}

	public JasperReport(ResultSetMetaData rsmd) {
		this.rsmd = rsmd;
	}

	public JasperDesign getDesign() {
		return jasperDesign;
	}

	public void pageSetup(PageSizeEnum pageSize, OrientationEnum o) throws Exception {
		jasperDesign = new JasperDesign();
		jasperDesign.setName("JasperReport");
		if (pageSize == PageSizeEnum.A4) {
			width = (int) Math.round(8.3 * 72);
			height = (int) Math.round(11.7 * 72);
		} else if (pageSize == PageSizeEnum.A3) {
			width = (int) Math.round(11.7 * 72);
			height = (int) Math.round(16.5 * 72);
		}
		columnWidth = Math.round(width * 90 / 100);
		rightLeftmargin = Math.round(width * 5 / 100);
		topBottomMargin = Math.round(height * 5 / 100);
		jasperDesign.setPageWidth(width);
		jasperDesign.setPageHeight(height);
		jasperDesign.setColumnWidth(columnWidth);
		jasperDesign.setColumnSpacing(0);
		jasperDesign.setLeftMargin(rightLeftmargin);
		jasperDesign.setRightMargin(rightLeftmargin);
		jasperDesign.setTopMargin(topBottomMargin);
		jasperDesign.setBottomMargin(topBottomMargin);
		jasperDesign.setOrientation(o);
		if (!"pdf".equals(type)) {
			jasperDesign.setIgnorePagination(true);
		}
		initializeFonts();

	}

	public void addTitle(HashMap<String, String> titles, boolean printTitleOnEachPage) {
		int s = Integer.parseInt(titles.get("title_length"));
		int titleHeight = 20 + (s - 1) * 15;
		JRDesignBand title = new JRDesignBand();
		title.setHeight(titleHeight);
		int x = 0;
		int y = 0;
		for (int i = 1; i <= s; i++) {
			JRDesignStaticText textField = new JRDesignStaticText();
			textField.setX(x);
			textField.setY(y);
			textField.setWidth(columnWidth);
			if (i == 1) {
				textField.setHeight(20);
			} else {
				textField.setHeight(15);
			}
			textField.setHorizontalTextAlign(HorizontalTextAlignEnum.CENTER);
			textField.setStyle(boldStyle);
			textField.setText(titles.get("title_" + (i)));
			textField.setMode(ModeEnum.OPAQUE);
			textField.setBackcolor(Color.decode("#E9E5E3"));
			if (i > 1) {
				y += 15;
				textField.setFontSize((float) 12);
			} else {
				textField.setFontSize((float) 15);
				y += 20;
			}
			title.addElement(textField);
		}
		if (printTitleOnEachPage) {
			jasperDesign.setPageHeader(title);
		} else {
			jasperDesign.setTitle(title);
		}
	}

	public void addFields() throws Exception {
		int s = rsmd.getColumnCount();
		for (int i = 1; i <= s; i++) {
			JRDesignField field = new JRDesignField();
			field.setName(rsmd.getColumnLabel(i).toUpperCase());
			Class className = Class.forName(rsmd.getColumnClassName(i));
			field.setValueClass(className);
			jasperDesign.addField(field);
		}
	}

	public void addColumnHeader(ArrayList<HashMap<String, String>> columns) throws Exception {
		int s = columns.size();
		int x = 0;
		int y = 0;// jasperDesign.getTitle().getHeight();//+jasperDesign.getPageHeader().getHeight()+2;
		JRDesignBand band = new JRDesignBand();
		band.setHeight(15);
		for (int i = 0; i < s; i++) {
			HashMap<String, String> c = columns.get(i);
			int width = Integer.parseInt(c.get("COLUMN_WIDTH"));
			int adjustedWidth = ((columnWidth) * width / 100);
			if (i == s - 1) {
				int diff = (columnWidth - (x + adjustedWidth));
				adjustedWidth += diff;
			}
			JRDesignStaticText text = new JRDesignStaticText();
			text.setX(x);
			text.setY(y);
			text.setWidth(adjustedWidth);
			text.setHeight(15);
			text.setHorizontalTextAlign(HorizontalTextAlignEnum.CENTER);
			text.setStyle(boldStyle);
			text.setFontSize((float) 12);
			text.setText(c.get("COLUMN_TITLE"));
			text.setMode(ModeEnum.OPAQUE);
			text.setBackcolor(Color.LIGHT_GRAY);
			band.addElement(text);
			x += adjustedWidth;
			System.out.println(columnWidth + " " + adjustedWidth);
			c.put("COLUMN_WIDTH", String.valueOf(adjustedWidth));
		}
		jasperDesign.setColumnHeader(band);
	}

	public void addColumnFooter(ArrayList<HashMap<String, String>> columns, HashMap<String, String> openingBalances)
			throws Exception {
		int s = columns.size();
		int x = 0;
		int y = 0;// jasperDesign.getTitle().getHeight();//+jasperDesign.getPageHeader().getHeight()+2;
		JRDesignBand band = new JRDesignBand();
		band.setHeight(15);
		for (int i = 0; i < s; i++) {
			HashMap<String, String> c = columns.get(i);
			int width = Integer.parseInt(c.get("COLUMN_WIDTH"));
			if ("1".equals(c.get("COLUMN_SUM"))) {
				JRDesignTextField textField = new JRDesignTextField();
				textField.setX(x);
				textField.setY(y);
				textField.setWidth(width);
				textField.setHeight(15);
				textField.setBlankWhenNull(true);
				String columnAlign = c.get("COLUMN_ALIGN");
				if ("right".equals(columnAlign)) {
					textField.setHorizontalTextAlign(HorizontalTextAlignEnum.RIGHT);
				} else if ("center".equals(columnAlign)) {
					textField.setHorizontalTextAlign(HorizontalTextAlignEnum.CENTER);
				} else {
					textField.setHorizontalTextAlign(HorizontalTextAlignEnum.LEFT);
				}
				textField.setStyle(boldStyle);
				textField.setFontSize((float) 12);
				textField.setStretchWithOverflow(false);
				textField.setMode(ModeEnum.OPAQUE);
				textField.setBackcolor(Color.LIGHT_GRAY);
				String t = getColumnType(c.get("COLUMN_TYPE"));
				if (t.contains("Date")) {
					textField.setPattern("dd/MM/yyyy");
				} else if (t.contains("Double")) {
					textField.setPattern("0.00");
				}
				JRDesignExpression expression = new JRDesignExpression();
				Class className = Class.forName(getColumnType(c.get("COLUMN_TYPE")));
				expression.setValueClass(className);
				if (openingBalances.get(c.get("COLUMN_NAME")) != null) {
					expression.setText(
							"$V{SVAR_" + c.get("COLUMN_NAME") + "}+" + openingBalances.get(c.get("COLUMN_NAME")) + "");
				} else {
					expression.setText("$V{SVAR_" + c.get("COLUMN_NAME") + "}");
				}
				textField.setExpression(expression);
				band.addElement(textField);
			} else {
				JRDesignStaticText text = new JRDesignStaticText();
				text.setX(x);
				text.setY(y);
				text.setWidth(width);
				text.setHeight(15);
				text.setStyle(normalStyle);
				text.setMode(ModeEnum.OPAQUE);
				text.setBackcolor(Color.LIGHT_GRAY);
				text.setText("");
				band.addElement(text);
			}
			x += width;
		}
		JRDesignExpression expression = new JRDesignExpression();
		expression.setValueClassName("java.lang.Boolean");
		expression.setText("new Boolean ($V{REPORT_COUNT}.intValue()!=" + noOfRows + ")");
		band.setPrintWhenExpression(expression);
		jasperDesign.setFloatColumnFooter(true);
		jasperDesign.setColumnFooter(band);
	}

	public void addLastPageColumnFooter(ArrayList<HashMap<String, String>> columns,
			HashMap<String, String> openingBalances) throws Exception {
		int s = columns.size();
		int x = 0;
		int y = 0;// jasperDesign.getTitle().getHeight();//+jasperDesign.getPageHeader().getHeight()+2;
		JRDesignGroup lastPageGroup = new JRDesignGroup();
		lastPageGroup.setName("lastPageGroup");
		lastPageGroup.setStartNewColumn(false);
		JRDesignBand band = new JRDesignBand();
		band.setHeight(15);
		for (int i = 0; i < s; i++) {
			HashMap<String, String> c = columns.get(i);
			int width = Integer.parseInt(c.get("COLUMN_WIDTH"));
			if ("1".equals(c.get("COLUMN_SUM"))) {
				JRDesignTextField textField = new JRDesignTextField();
				textField.setX(x);
				textField.setY(y);
				textField.setWidth(width);
				textField.setHeight(15);
				textField.setBlankWhenNull(true);
				String columnAlign = c.get("COLUMN_ALIGN");
				if ("right".equals(columnAlign)) {
					textField.setHorizontalTextAlign(HorizontalTextAlignEnum.RIGHT);
				} else if ("center".equals(columnAlign)) {
					textField.setHorizontalTextAlign(HorizontalTextAlignEnum.CENTER);
				} else {
					textField.setHorizontalTextAlign(HorizontalTextAlignEnum.LEFT);
				}
				textField.setStyle(boldStyle);
				textField.setFontSize((float) 12);
				textField.setStretchWithOverflow(false);
				textField.setMode(ModeEnum.OPAQUE);
				textField.setBackcolor(Color.LIGHT_GRAY);
				String t = getColumnType(c.get("COLUMN_TYPE"));
				if (t.contains("Date")) {
					textField.setPattern("dd/MM/yyyy");
				} else if (t.contains("Double")) {
					textField.setPattern("0.00");
				}
				JRDesignExpression expression = new JRDesignExpression();
				Class className = Class.forName(getColumnType(c.get("COLUMN_TYPE")));
				expression.setValueClass(className);
				if (openingBalances.get(c.get("COLUMN_NAME")) != null) {
					expression.setText(
							"$V{SVAR_" + c.get("COLUMN_NAME") + "}+" + openingBalances.get(c.get("COLUMN_NAME")) + "");
				} else {
					expression.setText("$V{SVAR_" + c.get("COLUMN_NAME") + "}");
				}
				textField.setExpression(expression);
				band.addElement(textField);
			} else {
				JRDesignStaticText text = new JRDesignStaticText();
				text.setX(x);
				text.setY(y);
				text.setWidth(width);
				text.setHeight(15);
				text.setStyle(boldStyle);
				text.setMode(ModeEnum.OPAQUE);
				text.setBackcolor(Color.LIGHT_GRAY);
				if (openingBalances.get("TEXT_COLUMN").equals(c.get("COLUMN_NAME"))) {
					text.setText("Total");
				} else {
					text.setText("");
				}
				band.addElement(text);
			}
			x += width;
		}
		((JRDesignSection) lastPageGroup.getGroupFooterSection()).addBand(band);
		jasperDesign.addGroup(lastPageGroup);
	}

	public void addSummary(ArrayList<HashMap<String, String>> columns, HashMap<String, String> openingBalances)
			throws Exception {
		int s = columns.size();
		int x = 0;
		int y = 0;// jasperDesign.getTitle().getHeight();//+jasperDesign.getPageHeader().getHeight()+2;
		JRDesignBand band = new JRDesignBand();
		band.setHeight(15);
		for (int i = 0; i < s; i++) {
			HashMap<String, String> c = columns.get(i);
			int width = Integer.parseInt(c.get("COLUMN_WIDTH"));
			if ("1".equals(c.get("COLUMN_SUM"))) {
				JRDesignTextField textField = new JRDesignTextField();
				textField.setX(x);
				textField.setY(y);
				textField.setWidth(width);
				textField.setHeight(15);
				textField.setBlankWhenNull(true);
				String columnAlign = c.get("COLUMN_ALIGN");
				if ("right".equals(columnAlign)) {
					textField.setHorizontalTextAlign(HorizontalTextAlignEnum.RIGHT);
				} else if ("center".equals(columnAlign)) {
					textField.setHorizontalTextAlign(HorizontalTextAlignEnum.CENTER);
				} else {
					textField.setHorizontalTextAlign(HorizontalTextAlignEnum.LEFT);
				}
				textField.setStyle(boldStyle);
				textField.setFontSize((float) 12);
				textField.setStretchWithOverflow(false);
				textField.setMode(ModeEnum.OPAQUE);
				textField.setBackcolor(Color.LIGHT_GRAY);
				String t = getColumnType(c.get("COLUMN_TYPE"));
				if (t.contains("Date")) {
					textField.setPattern("dd/MM/yyyy");
				} else if (t.contains("Double")) {
					textField.setPattern("0.00");
				}
				JRDesignExpression expression = new JRDesignExpression();
				Class className = Class.forName(getColumnType(c.get("COLUMN_TYPE")));
				expression.setValueClass(className);
				expression.setText(closingExpression.toString() + c.get("CLOSING_CONDITION") + "?Math.abs("
						+ closingExpression.toString() + "):null");
				textField.setExpression(expression);
				band.addElement(textField);
			} else {
				JRDesignStaticText text = new JRDesignStaticText();
				text.setX(x);
				text.setY(y);
				text.setWidth(width);
				text.setHeight(15);
				text.setStyle(boldStyle);
				text.setMode(ModeEnum.OPAQUE);
				text.setBackcolor(Color.LIGHT_GRAY);
				if (openingBalances.get("TEXT_COLUMN").equals(c.get("COLUMN_NAME"))) {
					text.setText("Closing Balance");
				} else {
					text.setText("");
				}
				band.addElement(text);
			}
			x += width;
		}
		jasperDesign.setSummary(band);
	}

	public void addDetail(ArrayList<HashMap<String, String>> columns) throws Exception {
		int s = columns.size();
		int x = 0;
		int y = 0;// jasperDesign.getTitle().getHeight();//+jasperDesign.getPageHeader().getHeight()+2;
		JRDesignBand band = new JRDesignBand();
		band.setHeight(15);
		for (int i = 0; i < s; i++) {
			HashMap<String, String> c = columns.get(i);
			int width = Integer.parseInt(c.get("COLUMN_WIDTH"));
			JRDesignTextField textField = new JRDesignTextField();
			textField.setX(x);
			textField.setY(y);
			textField.setWidth(width);
			textField.setHeight(15);
			textField.setBlankWhenNull(true);
			String columnAlign = c.get("COLUMN_ALIGN");
			String columnLink = c.get("COLUMN_LINK");
			if ("right".equals(columnAlign)) {
				textField.setHorizontalTextAlign(HorizontalTextAlignEnum.RIGHT);
			} else if ("center".equals(columnAlign)) {
				textField.setHorizontalTextAlign(HorizontalTextAlignEnum.CENTER);
			} else {
				textField.setHorizontalTextAlign(HorizontalTextAlignEnum.LEFT);
			}
			textField.setStyle(normalStyle);
			textField.setBackcolor(Color.LIGHT_GRAY);
			String t = getColumnType(c.get("COLUMN_TYPE"));
			if (t.contains("Date")) {
				textField.setPattern("dd/MM/yyyy");
			} else if (t.contains("Double")) {
				textField.setPattern("0.00");
			} else if (t.contains("String")) {
				textField.setStretchWithOverflow(true);
				textField.setStretchType(StretchTypeEnum.RELATIVE_TO_TALLEST_OBJECT);
			}
			if (columnLink != null && !"".equals(columnLink)) {
				textField.setHyperlinkTarget(HyperlinkTargetEnum.BLANK);
				textField.setHyperlinkType(HyperlinkTypeEnum.REFERENCE);
				JRDesignExpression link = new JRDesignExpression();
				String[] linkParameters = c.get("LINK_PARAMETERS").split(",");
				String[] paramColumns = c.get("PARAM_COLUMNS").split(",");
				StringBuffer expression = new StringBuffer(100);
				int cnt = linkParameters.length;
				for (int l = 0; l < cnt; l++) {
					if (l > 0) {
						expression.append("+\"&");
					}
					expression.append(linkParameters[l]);
					expression.append("=\"+$F{");
					expression.append(paramColumns[l]);
					expression.append("}");
				}
				link.setText("\"" + linkServerName + columnLink + "?" + expression.toString());
				textField.setHyperlinkReferenceExpression(link);
			}
			JRDesignExpression expression = new JRDesignExpression();
			Class className = Class.forName(getColumnType(c.get("COLUMN_TYPE")));
			expression.setValueClass(className);
			expression.setText("$F{" + c.get("COLUMN_NAME") + "}");
			textField.setExpression(expression);
			band.addElement(textField);
			x += width;
		}
		((JRDesignSection) jasperDesign.getDetailSection()).addBand(band);
	}

	public void addVariables(ArrayList<HashMap<String, String>> columns, HashMap<String, String> openingBalances)
			throws Exception {
		int s = columns.size();
		closingExpression.setLength(0);
		for (int i = 0; i < s; i++) {
			HashMap<String, String> c = columns.get(i);
			if ("1".equals(c.get("COLUMN_SUM"))) {
				JRDesignVariable variable = new JRDesignVariable();
				variable.setName("SVAR_" + c.get("COLUMN_NAME"));
				variable.setCalculation(CalculationEnum.SUM);
				variable.setResetType(ResetTypeEnum.REPORT);
				variable.setValueClassName("java.lang.Double");

				JRDesignExpression expression = null;
				expression = new JRDesignExpression();
				expression.setValueClassName("java.lang.Double");
				if (c.get("CLOSING_OPERATOR") != null && !"".equals(c.get("CLOSING_OPERATOR"))) {
					closingExpression.append(c.get("CLOSING_OPERATOR") + "($V{SVAR_" + c.get("COLUMN_NAME") + "}");
				}
				if (openingBalances.get(c.get("COLUMN_NAME")) != null) {
					closingExpression.append("+");
					closingExpression.append(openingBalances.get(c.get("COLUMN_NAME")));
					closingExpression.append(")");
					expression.setText(openingBalances.get(c.get("COLUMN_NAME")));
				} else {
					closingExpression.append(")");
					expression.setText("0.0");
				}
				variable.setInitialValueExpression(expression);

				expression = null;
				expression = new JRDesignExpression();
				expression.setText("$F{" + c.get("COLUMN_NAME") + "}");
				variable.setExpression(expression);
				jasperDesign.addVariable(variable);
			}
		}
	}

	public void setOpeningBalance(ArrayList<HashMap<String, String>> columns, boolean printOpeningBalance,
			HashMap<String, String> openingBalances) throws Exception {
		int s = columns.size();
		int x = 0;
		int y = 0;
		JRDesignGroup openingBalanceGroup = new JRDesignGroup();
		openingBalanceGroup.setName("openingGroup");
		openingBalanceGroup.setReprintHeaderOnEachPage(true);
		openingBalanceGroup.setStartNewColumn(false);
		JRDesignExpression expressionPrint = new JRDesignExpression();
		expressionPrint.setValueClassName("java.lang.Boolean");
		JRDesignBand band = new JRDesignBand();
		band.setHeight(20);
		for (int i = 0; i < s; i++) {
			HashMap<String, String> c = columns.get(i);
			int width = Integer.parseInt(c.get("COLUMN_WIDTH"));
			if (openingBalances.get("TEXT_COLUMN").equals(c.get("COLUMN_NAME"))) {
				JRDesignTextField text = new JRDesignTextField();
				text.setX(x);
				text.setY(y);
				text.setWidth(width);
				text.setHeight(15);
				text.setStyle(boldStyle);
				JRDesignExpression expression = new JRDesignExpression();
				Class<?> className = Class.forName(getColumnType(c.get("COLUMN_TYPE")));
				expression.setValueClass(className);
				expression.setText(
						"$V{PAGE_NUMBER}.intValue()!=1?\"" + openingBalances.get("BF_TEXT") + "\":\"Opening Balance\"");
				text.setExpression(expression);
				band.addElement(text);
			} else if ("1".equals(c.get("COLUMN_SUM"))) {
				JRDesignTextField textField = new JRDesignTextField();
				textField.setX(x);
				textField.setY(y);
				textField.setWidth(width);
				textField.setHeight(15);
				textField.setBlankWhenNull(true);
				textField.setHorizontalTextAlign(HorizontalTextAlignEnum.RIGHT);
				textField.setStyle(boldStyle);
				textField.setFontSize((float) 12);
				textField.setStretchWithOverflow(false);
				textField.setPattern("0.00");
				JRDesignExpression expression = new JRDesignExpression();
				Class className = Class.forName(getColumnType(c.get("COLUMN_TYPE")));
				expression.setValueClass(className);
				if (openingBalances.get(c.get("COLUMN_NAME")) != null) {
					expression.setText("$V{PAGE_NUMBER}.intValue()!=1?new Double($V{SVAR_" + c.get("COLUMN_NAME")
							+ "}.doubleValue()+" + openingBalances.get(c.get("COLUMN_NAME")) + "):new Double("
							+ openingBalances.get(c.get("COLUMN_NAME")) + ")");
				} else {
					expression.setText("$V{SVAR_" + c.get("COLUMN_NAME") + "}");
				}
				textField.setExpression(expression);
				band.addElement(textField);
			}
			x += width;
		}
		if (!printOpeningBalance) {
			expressionPrint.setText("new Boolean($V{PAGE_NUMBER}.intValue()!=1)");
			band.setPrintWhenExpression(expressionPrint);
		}
		((JRDesignSection) openingBalanceGroup.getGroupHeaderSection()).addBand(band);
		jasperDesign.addGroup(openingBalanceGroup);
	}

	public void addParameters(HashMap<String, String> map) throws Exception {
		Set<String> s = map.keySet();
		Iterator<String> i = s.iterator();
		while (i.hasNext()) {
			String name = i.next();
			JRDesignParameter parameter = new JRDesignParameter();
			parameter.setName(name);
			Class c = Class.forName(map.get(name));
			parameter.setValueClass(c);
			jasperDesign.addParameter(parameter);
		}
	}

	private void initializeFonts() throws Exception {
		normalStyle = new JRDesignStyle();
		normalStyle.setName("Sans_Normal");
		normalStyle.setDefault(true);
		normalStyle.setFontName("DejaVu Sans");
		normalStyle.setFontSize((float) 10);
		normalStyle.setPdfFontName("Helvetica");
		normalStyle.setPdfEncoding("Cp1252");
		normalStyle.setPdfEmbedded(false);

		boldStyle = new JRDesignStyle();
		boldStyle.setName("Sans_Bold");
		boldStyle.setFontName("DejaVu Sans");
		boldStyle.setFontSize((float) 12.0);
		boldStyle.setBold(true);
		boldStyle.setPdfFontName("Helvetica-Bold");
		boldStyle.setPdfEncoding("Cp1252");
		boldStyle.setPdfEmbedded(false);
		boldStyle.setBackcolor(Color.decode("#0479BF"));

		italicStyle = new JRDesignStyle();
		italicStyle.setName("Sans_Italic");
		italicStyle.setFontName("DejaVu Sans");
		italicStyle.setFontSize((float) 12);
		italicStyle.setItalic(true);
		italicStyle.setPdfFontName("Helvetica-Oblique");
		italicStyle.setPdfEncoding("Cp1252");
		italicStyle.setPdfEmbedded(false);

		jasperDesign.addStyle(normalStyle);
		jasperDesign.addStyle(boldStyle);
		jasperDesign.addStyle(italicStyle);

	}

	private String getColumnType(String type) {
		String columnType = "";
		if ("text".equals(type)) {
			columnType = "java.lang.String";
		} else if ("number".equals(type)) {
			columnType = "java.lang.Double";
		} else if ("integer".equals(type)) {
			columnType = "java.lang.Long";
		} else if ("date".equals(type)) {
			columnType = "java.util.Date";
		}
		return columnType;
	}
}
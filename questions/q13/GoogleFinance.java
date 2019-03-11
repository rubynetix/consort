import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.URL;
import java.text.NumberFormat;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;


public class GoogleFinance {
    private static final Map<String, BigDecimal> priceMap;
    static {
        HashMap<String, BigDecimal> map = new HashMap<String, BigDecimal>();
        map.put("IBM", BigDecimal.valueOf(137.71));
        map.put("AAPL", BigDecimal.valueOf(178.90));
        map.put("AMZN", BigDecimal.valueOf(1670.62));
        map.put("CSCO", BigDecimal.valueOf(51.92));
        map.put("SNE", BigDecimal.valueOf(46.10));
        map.put("GOOG", BigDecimal.valueOf(1175.76));
        map.put("MSFT", BigDecimal.valueOf(112.83));
        map.put("ORCL", BigDecimal.valueOf(52.66));
        map.put("FB", BigDecimal.valueOf(172.07));
        map.put("VRSN", BigDecimal.valueOf(179.07));
        priceMap = Collections.unmodifiableMap(map);
    }

    // TODO: Redo with Alpha Vantage API
    //This provided code segment doesn't work due to Google Finance API being depreciated
    //public static BigDecimal getPrice(final String symbol){
    //    try{
    //        URL url = new URL("https://finance.google.ca/finance?q="+symbol);
    //        final BufferedReader reader = new BufferedReader(new InputStreamReader(url.openStream()));
    //        final String data = reader.lines().skip(170).findFirst().get();
    //        final String[] dataItems = data.split(">");
    //        return new BigDecimal(NumberFormat.getNumberInstance().parse(dataItems[dataItems.length-1].split("<")[0]).toString());
    //    }
    //    catch(Exception ex){
    //        throw new RuntimeException(ex);
    //    }
    //}

    //For testing just return Hard Coded price value
    public static BigDecimal getPrice(final String symbol){
        return priceMap.get(symbol);
    }
}


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.URL;
import java.text.NumberFormat;

public class GoogleFinance {
    public static BigDecimal getPrice(final String symbol){
        try{
            URL url = new URL("https://finance.google.ca/finance?q="+symbol);
            final BufferedReader reader = new BufferedReader(new InputStreamReader(url.openStream()));
            final String data = reader.lines().skip(170).findFirst().get();
            final String[] dataItems = data.split(">");
            return new BigDecimal(NumberFormat.getNumberInstance().parse(dataItems[dataItems.length-1].split("<")[0]).toString());
        }
        catch(Exception ex){
            throw new RuntimeException(ex);
        }
    }
}


import java.math.BigDecimal;
import java.util.Comparator;
import java.util.stream.Stream;

public class PickShareFunctional {

    private static BigDecimal cutOffPrice = BigDecimal.valueOf(500);

    public static void findHighPrices(Stream<String> symbolStream){

        // Create a list of ShareInfo filled with the price of each symbol
        // Trim down this list to a list of shares whose price under $500
        // Return the highest-price sshare
        ShareInfo largestBoundedShare = symbolStream
                .map(s -> new ShareInfo(s, GoogleFinance.getPrice(s)))
                .filter(s -> s.getPrice().compareTo(cutOffPrice) < 0)
                .max(Comparator.comparing(ShareInfo::getPrice))
                .get();

        System.out.println("High priced under $500 is " + largestBoundedShare);
    }

    public static void main(String[] args){
        findHighPrices(Shares.symbols.stream());
    }

}


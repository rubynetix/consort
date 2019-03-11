import java.math.BigDecimal;
import java.util.Comparator;
import java.util.stream.Stream;

public class PickShareFunctional {

    private static BigDecimal cutOffPrice = BigDecimal.valueOf(500);

    public static void findHighPrices(Stream<String> symbolStream){

        ShareInfo largestBoundedShare = symbolStream
                .map(s -> new ShareInfo(s, GoogleFinance.getPrice(s)))
                .filter(s -> s.getPrice().compareTo(cutOffPrice) < 0)
                .max(Comparator.comparing(ShareInfo::getPrice))
                .get();

        System.out.println("High priced under $500 is " + largestBoundedShare);
    }

    public static void main(String[] args){
        long startTime = System.currentTimeMillis();
        findHighPrices(Shares.symbols.stream());
        long duration = System.currentTimeMillis() - startTime;

        System.out.println("Stream execution time (ms): " + duration);

        long startTime2 = System.currentTimeMillis();
        findHighPrices(Shares.symbols.parallelStream());
        long duration2 = System.currentTimeMillis() - startTime;

        System.out.println("Parallel stream execution time (ms): " + duration);
    }

}


import java.math.BigDecimal;

public class ShareInfo {
    private final String symbol;
    private final BigDecimal price;

    public ShareInfo(final String theSymbol, final BigDecimal thePrice){
        this.symbol = theSymbol;
        this.price = thePrice;
    }

    public String toString(){
        return String.format("symbol: %s price %g", symbol, price);
    }

    public BigDecimal getPrice(){
        return this.price;
    }

    public String getSymbol(){
        return this.symbol;
    }

}


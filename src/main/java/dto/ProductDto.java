package dto;

import com.google.gson.annotations.SerializedName;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductDto {
	@SerializedName("product_id")
	private int productId;
	@SerializedName("seller_id")
	private String sellerId;
	@SerializedName("category")
	private String category;
	@SerializedName("title")
	private String title;
	@SerializedName("description")
	private String description;
	@SerializedName("org_price")
	private int orgPrice;
	@SerializedName("sale_price")
	private int salePrice;
	@SerializedName("sales_state")
	private String salesState;
	@SerializedName("thumbnail")
	private String thumbnail;
	
}

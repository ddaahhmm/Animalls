package dto;

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
	private int productId;
	private String sellerId;
	private String category;
	private String title;
	private String description;
	private int orgPrice;
	private int salePrice;
	private String salesState;
	private String thumbnail;
}

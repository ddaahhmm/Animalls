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

public class ProductOptionDto {
	private int optionId;
	private int productId;
	private String description;
	private int additionalPrice;
	private int amount;
}

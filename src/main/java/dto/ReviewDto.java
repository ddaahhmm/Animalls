package dto;

import com.google.gson.annotations.SerializedName;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ReviewDto {
	@SerializedName("review_id")
	private int reviewId;
	@SerializedName("product_id")
	private int productId; //로그인 사용자의 아이디
	@SerializedName("reviewer_id")
	private String reviewerId;
	@SerializedName("content")
	private String content;
	@SerializedName("thumbnail")
	private String thumbnail;
	@SerializedName("rating")
	private int rating;
	@SerializedName("like_count")
	private int likeCount;
	@SerializedName("created_at")
	private String createdAt;
	@SerializedName("updated_at")
	private String updatedAt;

}

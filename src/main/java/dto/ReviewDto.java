package dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ReviewDto {
	private int reviewId;
	private int productId; //로그인 사용자의 아이디
	private String reviewerId;
	private String title;
	private String content;
	private String thumbnail;
	private int rating;
	private int likeCount;
	private String createdAt;
	private String updatedAt;

}

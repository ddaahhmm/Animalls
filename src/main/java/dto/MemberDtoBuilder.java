package dto;

import java.lang.reflect.Member;

public class MemberDtoBuilder {
	private String memberId; 
	private int deliveryId; 
	private String password;
	private String name;
	private String nickname; 
	private String role;
	private String phoneNumber;
	private String rank; 
	private String profileImage; 
	private String email;
	private boolean emailVerified; 
	private String registeredDate;	
	
	public MemberDtoBuilder() {}
	
	public MemberDtoBuilder memberId(String memberId) {
		this.memberId = memberId;
		return this; 
	}
	
	public MemberDtoBuilder deliveryId(int deliveryId) {
		this.deliveryId = deliveryId;
		return this;
	}
	
	public MemberDtoBuilder password(String password) {
		this.password = password;
		return this; 
	}
	
	public MemberDtoBuilder name(String name) {
		this.name = name; 
		return this;
	}
	
	public MemberDtoBuilder nickname(String nickname) {
		this.nickname = nickname; 
		return this; 
	}
	
	public MemberDtoBuilder role(String role) {
		this.role = role; 
		return this; 
	}
	
	public MemberDtoBuilder phoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
		return this; 
	}
	
	public MemberDtoBuilder rank(String rank) {
		this.rank = rank; 
		return this; 
	}
	
	public MemberDtoBuilder profileImage(String profileImage) {
		this.profileImage = profileImage;
		return this;
	}
	
	public MemberDtoBuilder email(String email) {
		this.email = email; 
		return this;
	}
	
	public MemberDtoBuilder emailVerified(boolean emailVerified) {
		this.emailVerified = emailVerified;
		return this;
	}
	
	public MemberDtoBuilder registeredDate(String registeredDate) {
		this.registeredDate = registeredDate;
		return this;
	}
	
	public MemberDto build() {
		return new MemberDto(memberId, deliveryId, password, name, nickname, role, phoneNumber, rank, profileImage, email, emailVerified, registeredDate);
	}
}
 
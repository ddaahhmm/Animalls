<<<<<<< HEAD
<%@page import="java.util.ArrayList"%>
=======
<%@page import="dto.MemberDto"%>
<%@page import="util.SessionManager"%>
<%@page import="dao.ReviewDao"%>
>>>>>>> refs/remotes/upstream/main
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductOptionDao"%>
<%@page import="dto.ProductOptionDto"%>
<%@page import="dao.ProductDao"%>
<%@page import="dto.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    ProductDto dto = ProductDao.getInstance().getData(productId);   
    List<ProductOptionDto> optionList = ProductOptionDao.getInstance().getListByProudctId(productId);
    boolean useMultipleOption = optionList != null && optionList.size() > 0;
    
<<<<<<< HEAD
	ProductDto dto = ProductDao.getInstance().getData(productId);
	
	List<ProductOptionDto> optionList = ProductOptionDao.getInstance().getList();
	
	List<ProductOptionDto> selected_List = new ArrayList<>();

	
	
=======
    MemberDto member  = SessionManager.getMember(request);
    boolean isGuest = member == null; 
>>>>>>> refs/remotes/upstream/main
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productDetail.jsp</title>
<link rel="stylesheet" href="/Animalls/css/bootstrap.css" />
<link rel="stylesheet" href="/Animalls/css/common.css" />
<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/carousel/">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@2.0/nanumsquare.css">
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<style type="text/css">
.btn-share {
    background-image: url('/Animalls/assets/share.png'); 
    background-size: fill;
    background-repeat: no-repeat;
    background-color: transparent;
    
    width: 42px;
    height: 42px;
    padding: 0;
    border: none;
}

<<<<<<< HEAD
<style>
		 ul {
      		list-style: none;
   			 }
   		li {
   			list-style:none;
   		}
   		
   		 .page {
		    list-style: none;
		    padding: 0;
		    margin: 0;
		    display: flex;
		    flex-wrap: wrap;
  			}
  		#optionProducts{
  			width:1000px;
  		}
	</style>
</head>

<body>
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="index" name="current"/>
	</jsp:include>
	
	<script>
	
	
	</script>

	
	
	<div class="wrap">
		<div class="container">
			<div class="detailArea">
				<div class="thumbnail">
					<div class="imgArea">
						<%--썸네일 각 항목별로 div 메인이미지, 다른이미지(ui)--%>
						<img src="<%=dto.getThumbnail()%>" width="300px" height="300px">
					</div>
					
					<div class="smallImgArea xans-element- xans-product xans-product-addimage listImg">	
						<ul> <%--썸네일 하단 상세 그림 구현 예정 --%>
							<li>
								<img src="<%=dto.getThumbnail()%>" width="60px" height="60px">
							</li>
						</ul>
						<button type="button">
							<span class="blind">다음</span>
						</button>
					
				</div>
				</div>
				<div class="infoArea">
					<%--경로 --%>
					<div>
						<ul>
							<li><a href="${pageContext.request.contextPath}/index.jsp">home</a></li>
							<li><a href="${pageContext.request.contextPath}/product/productList.jsp">제품</a>
						</ul>
					</div>

					
					<div class="totalProducts">
					</div>
					
					<div class="priceArea">
						<%if(dto.getSalePrice() != 0){ %>
							<p><%=dto.getSalePrice() %><span>원</span></p>
							<p class="prd_price"> <del><%=dto.getOrgPrice() %></del> </p> <%--여기에 가운데 취소표시(class) --%>
						
						
						<%}else{ %> 
							<p><%=dto.getOrgPrice() %><span>원</span></p>
						<%} %>
					</div>
					
					<div class="basicInfo">
						<table border="1"><%--옵션 (적립금있음 나중에추가) --%>
							<caption>기본 정보</caption>
							<tbody>
								<tr>
									<th><span>배송비</span></th>
									<td>
										<span style="font-size:16px;color:#353132;">
											<strong>2,500(50,000 이상 구매 시 무료)</strong>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					
=======
.btn-like {
    background-image: url('/Animalls/assets/like.png');
    background-size: fill;
    background-repeat: no-repeat;
    background-color: transparent;
    
    width: 42px; 
    height: 42px;
    padding: 0;
    border: none;
}


</style>
</head>
<body class="d-flex flex-column">
    <jsp:include page="/include/navbar.jsp">
        <jsp:param value="product" name="current" />
    </jsp:include>

    <div id="product-detail-container" class="container flex-grow-1 pb-5 py-4" >
        <div class="d-flex">
            <div>
                <img src="<%= dto.getThumbnail() %>" alt="thumbnail image" width="500" height="500"/>
            </div>
            <div class="px-5 flex-grow-1">
                <nav aria-label="breadcrumb">
                  <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a class="text-reset text-decoration-none" style="font-color: #cccccc;" href="/Animalls">홈</a></li>
                    <li class="breadcrumb-item active" aria-current="page"><a class="text-reset text-decoration-none" style="font-color: #cccccc; " href="/Animalls/product/productList.jsp">제품</a></li>
                  </ol>
                </nav>
                
                <div aria-label="title-box" class="d-flex justify-content-between py-4">
                    <div class="fw-bolder h2"> <%= dto.getTitle() %></div>
                    <div>
                        <button class="btn-share mx-2"></button>
                        <button class="btn-like mx-2"></button>
                    </div>
                </div>
   
                <div class="pb-3">
                    <% if (dto.getSalePrice() != 0) {%>
                        <div>
                            <strong>
                                <span style="font-size: 36px;"><%= String.format("%,d", dto.getSalePrice()) %></span>원 
                            </strong> 
                            
                            
                            <del class="px-3" style="font-size: 16px; font-color: #cecece;"><%= String.format("%,d", dto.getOrgPrice()) %></del>
                        </div> 
                   <%} else { %>
                        <div>
                            <strong >
                                <span style="font-size: 36px;"><%= String.format("%,d", dto.getOrgPrice()) %></span>원 
                            </strong> 
                        </div>
                   <%} %>
                </div>   
                <hr />
                
                <div>
                    <div>
                        <b>배송비</b>
                        <p>2,500원 (50,000원 이상 구매시 무료)</p>
                    </div>
                    <div>
                        <b>적립금</b>
                        <p><%= String.format("%,d", (int)((double)dto.getOrgPrice() * 0.01)) %>원 (1%)</p>
                    </div>
                </div>   
                
                
                <div>
                    <% if (useMultipleOption) { %> 
                    <select class="form-select-lg w-100" name="product-opt" id="product-opt" v-model="selectedOption" @change="handleOptionChange">
                        <option value="">[필수] 같이 구매하기 선택</option>
                        <option value="">-------------------</option>
                        <option v-for="opt in productOptions" :value="opt.id">{{opt.description}} (+ {{opt.additional}}원) </option>
                    </select>
                    <%} %> 
                </div>      
                
                
                <div id="selection" v-for="item in choosed">
                    <div class="d-flex p-2 my-2 justify-content-between align-items-center flex-wrap" style="background-color: #f2f2f2; ">
                        <div class="pr-5">
                            <div class="fs-5 "><%= dto.getTitle() %></div>
                            <div class="fs-6">{{item.description}}</div>
                        </div>
                        
                        <div>
                            <input type="number" step="1" min="1" v-model="item.count" />
                        </div>
                        
                        <div>
                            <span>{{item.count * item.price}}</span>원
                        </div>
                        
                        <% if (useMultipleOption) { %>
                        <div class="btn-close" @click="removeChoice(item.id)"></div>
                        <% } %>
                    </div>
                </div> 
                
                <div class="d-flex justify-content-end align-items-end p-2">
                    <span class="px-2 py-2">총 금액 </span><h3 class="fw-bold text-primary"> {{totalPrice()}} 원</h3> 
                </div>
                
                <div class="d-flex justify-content-around">
                    <button class="btn btn-outline-primary flex-grow-1 py-2 mx-1">장바구니</button>
                    <button class="btn btn-primary flex-grow-1 py-2 mx-1">구매하기</button>
                </div>
            </div>
        </div>
    
        <div style="margin-top: 120px;">
            <div>
                <h3 class="fw-bold my-2 py-2">상세 정보</h3>
                <hr />
                <div class="d-flex flex-column align-items-center" style="min-height: 300px;">
                    <%= dto.getDescription() %>
                </div>
            </div>
            
            
            <div>
                <h3 class="fw-bold my-2 py-2">리뷰 ({{review_stat.total_count}})</h3>
                <hr />
>>>>>>> refs/remotes/upstream/main

<<<<<<< HEAD
					<div class="optionInfo" id="app">
						<table border="1" class="xans-element- xans-product xans-product-option xans-record-">
							<caption>상품 옵션</caption>
							<tbody>
							 	<tr>
							 		
							 		<td>
							 		
							 			<form action ="" method="get" class="product_detail_option_select" > <!-- cart.jsp , payment.jsp 보내기  -->
							 				
							 				<select id="tmp" @change="onSelected" v-model="selectedOption">
								 				<option value="*" selected >-[필수] 같이 구매하기 선택-</option>
								 				<option disabled>----------------------------------</option>
									 				<%for(ProductOptionDto tmp:optionList){ %>
									 					<% if(tmp.getProductId()==productId || tmp.getProductId()==0){%>
									 				
									 					<option  id="opt_<%= tmp.getOptionId() %>" value="<%=tmp.getOptionId()%>/<%=tmp.getAdditionalPrice()%>/<%=tmp.getProductId() %>/<%=tmp.getDescription() %>" >
									 						<%=tmp.getDescription() %> (+ <%=tmp.getAdditionalPrice() %> )
									 					</option>

									 					<%}%>
									 			<%} %>
							 				</select>
							 				
							 			</form>
							 			
							 		</td>
							 	
							 	</tr>
							
							</tbody>
						</table>
					
					  
					
						  
						  
					<div v-if="onSelected"  style="display:  {{checked}}" class="option_add">
					     
					      <table>
					      		<colgroup>
					      		 	<col style="width: 300px;">
					      		 	<col style="width: 300px;">
					      		 	<col style="width: 300px;">
					      		</colgroup>
						      <thead>
						        <tr>
						          <th>상품명</th>
						          <th>옵션</th>
						          <th>가격</th>
						        </tr>
						      </thead>
						      
						      
						       <tbody>
								<tr v-for="(menu,index) in selectedOptions" :key="index"> 
									<td >
										<strong>{{menu.name}}</strong><br>
									</td>
									
									<td>
										<span class="quantity">
											<counter></counter>											
										</span>
									</td>
									
									<td >
										<strong>{{menu.price}} </strong><br>
									</td>
								</tr>
						      </tbody>
				    	</table>
					</div>
					
					<div class="totalProducts" id="optionProducts" >
						<table border="1">
							<colgroup>
							
							</colgroup>
							
							<thead>
								<tr>
									<th scope="col">상품명</th>
									<th scope="col">개수</th>
									<th scope="col">가격</th>
								</tr>
							</thead>
							
							<tbody class="displaynone">
								
								<tr>
									<td>
										<strong>{{des}}</strong>
										<strong>{{totalPrice}}</strong>원 <%--옵션 여러개 있으면 각자 가격 x 갯수 한 값들 출력  --%>
									 <%--옵션 선택한 상품명 --%>
									</td>
								</tr>
								<tr>
									<td>
										<span class="quantity">
											<input id="quantity" name="quantity_detail" type="text" v-model="count" >
											<strong>{{count}}</strong>
											<button @click="plus" class="quantity_up"><a><img src="//img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_up.gif" alt="수량증가"></a></button>
											<button @click="minus" class="quantity_down"><a><img src="//img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_down.gif" alt="수량감소"></a></button>
											
										</span>
									</td>
								</tr>
								
								<tr>
									<td>
										 <%--옵션 여러개 있으면 각자 가격 x 갯수 한 값들 출력  --%>
											<strong>{{totalPrice}}</strong>
											
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					
					<div class="totalPrice">
						총 금액
						<span class="total"><strong>{{totalPrice}}({{product_num}}개)</strong></span>
						
					</div>
					
					<div class="btnWrap">
						<a href="${pageContext.request.contextPath}/cart.jsp">장바구니</a>
						<a href="${pageContext.request.contextPath}/payment.jsp">구매하기</a>
					</div>
					
					
				</div>
			
			
			
				<div class="detail_li"> <%--같은 페이지 내에서 이동 --%>
					<ul>
						<li><a href="">상세정보</a></li>
						
						<li><a href="">리뷰</a></li>
						
						<li><a href="">상품 Q&A</a></li>
					</ul>
				</div>
			<div class="xans-element- xans-product xans-product-additional">
				<div class="detail_menu" style="display:none;"> <%--첫 화면에서 아래로 스크롤 할 때 나옴 --%>
					<div class="detail_list">
						<ul>
							<li> <a href="">상세정보</a> </li>
							<li> <a href="">리뷰<span>()</span></a> </li>
							<li> <a href="">상품 Q&A<span>()</span></a> </li>
							<li> <a href="">상품 구매 안내</a> </li>
						</ul>
					</div>
				</div>
				
				<div id="product_details" class="ec-base-tab gFlex">
					<div class="menu_area">
						<ul class="menu">
							<li class="selected"> <%--위치이동 하기--%>
								<a href="selected">상세정보</a>
							</li>
							<li>
								<a href="#product_reviews">리뷰<span>()</span></a>
							</li>
							<li>
								<a href="#product_QnA">Q&A<span>()</span></a>
							</li>
							<li>
								<a href="#product_info">상품구매안내</a>
							</li>
						</ul>
					</div>
					
					<div class="cont">
						<p align="center"><img src="https://okdoctordog.com/openImg/2022/notice/notice_all_officialmark.png"></p>
						<p align="center"><img src="https://hucheum.openhost.cafe24.com/openImg/2022/food/grainfree/detail_food_gf_tuna.jpg"></p>
					</div>
					
					
				</div>
				
				<div id="product_reviews" class="ec-base-tab gFlex">
					<div class="board">
						<div class="detail_tab_tit">
						TEST
						</div>
						<div class="crema-product-reviews crema-applied" data-widget-id="2" data-installation-id="22" data-product-code="670" data-install-method="smart" data-applied-widgets="[&quot;.crema-product-reviews&quot;]" style="margin-top: 32px; margin-bottom: 32px;"><iframe id="crema-product-reviews-2" src="https://review1.cre.ma/okdoctordog.com/products/reviews?product_code=670&amp;iframe_id=crema-product-reviews-2&amp;widget_id=2&amp;widget_style=&amp;app=0&amp;parent_url=https%3A%2F%2Fokdoctordog.com%2Fproduct%2F%25EB%258B%25A5%25ED%2584%25B0%25EB%258F%2585-%25EA%25B7%25B8%25EB%25A0%2588%25EC%259D%25B8%25ED%2594%2584%25EB%25A6%25AC-%25EC%25B0%25B8%25EC%25B9%2598-%25EC%2582%25AC%25EB%25A3%258C-16kg%2F670%2Fcategory%2F278%2Fdisplay%2F1%2F&amp;nonmember_token=&amp;secure_device_token=V2fa89584a4963c512fa6a0c471fec954b315b553e04a818122d04aa6d39e9b39175b0153b49f59ac3a27ad07aa18e130f&amp;iframe=1" height="0" width="100%"  name="crema-product-reviews-2-1703338154709" style="display: block; visibility: visible; height: 1996px;"></iframe>
						TEST
						</div>
					</div>
				</div>
				
				<div id="product_QnA" class="ec-base-tab gFlex">
					<div class="board">
						<div class="detail_tab_tit">
							<a href="">상품 Q&A<span>()</span></a>
							<p class="btn_area">
								<a href="" class="btn_write">상품 문의하기</a> <%--QnA 페이지로 전환 --%>
							</p>
						</div>
						
						<div class="xans-element- xans-product xans-product-qna">
							<a class="use_qna"></a>
							<p class="noAccess displaynone">글읽기 권한 X</p>
							
							<div class="ec-base-table typeList">
								<table border="1" >
									<caption>상품 Q&A</caption>
									<colgroup>
										<col style="width:120px">
										<col style="width:auto">
										<col style="width:180px">
										<col style="width:135px">
									</colgroup>
									
									<thead class="displaynone">
										<tr> <%--display:none 처리 예정 --%>
											<th scope="col">카테고리</th>
											<th scope="col">제목</th>
											<th scope="col">작성자</th>
											<th scope="col">작성일</th>
										</tr>
									</thead>
										<tbody class="center"> <%--이후 DB에서 가져오기 --%>
											<tr class="xans-record-">
												<td class="cate_name"></td>
												<td class="subject left txtBreak">
												<img src="https://okdoctordog.com/web/upload/icon_201507130033301200.gif" alt="secret" class="ec-common-rwd-image">
														<a href="">문의드립니다.(비밀글)</a>
												</td>
												<td class="writer">김**</td>
												<td class="write_date">23.12.26</td> 
											</tr>
										
										</tbody>	
								</table>
							</div>
						</div>
						
						<div class="page xans-element- xans-product xans-product-qnapaging ec-base-paginate typeSub" >
							<a href="">
								<img src="https://okdoctordog.com/web/zinidami/pc/page_prev.png" alt="before_page">
							</a>
							<ol>
								<li class="xans-record" >
									<a href="" class="this">1</a> <%--현재페이지 --%>
								</li>
							</ol>
							
							<a href="">
								<img src="https://okdoctordog.com/web/zinidami/pc/page_next.png" alt="next_page">
							</a>
						
						</div>
					</div>
				</div>
				
				<div id="product_info" class="ec-base-tab gFlex">
					<div class="board">
						<a href="#product_info">상품구매 안내</a>
					</div>
					
					<div class="df-bannermanager df-bannermanger-pc-detail-info">
						<a href="#none" >
							<img src="https://okdoctordog.com/web/upload/NNEditor/20220721/692a3b704511e13986863c6163bfad5f.png">
							
						</a>
					
					</div>
				</div>
				
				
			</div>
			
				<div class="detail_li"> <%--같은 페이지 내에서 이동 --%>
					<ul>
						<li>
							<a href="">상세정보</a> 
						</li>
						
						<li>
							<a href="">리뷰</a>
						</li>
						
						<li>
							<a href="">상품 Q&A</a>
						</li>
					</ul>
				</div>
			
			</div>
		</div>
		
	</div>
		
		
		
	</div>
	
	<script>
	
	Vue.component("counter", {
		
		  template: `
		    <div>
		      <strong>{{ count1 }}</strong>
		      <button @click="onClickedPlus"><img src="//img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_up.gif" alt="수량증가"></button>
		      <button @click="onClickedMinus"><img src="//img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_down.gif" alt="수량감소"></button>
		    </div>
		  `,
		  data() {
		
		    return {
		      count1: 1
		    };
		  },
		  methods: {
		    onClickedPlus() {
		      this.count1++;
		    },
		    onClickedMinus() {
		      
		    	  this.count1--;
		      
		    }
		  }
		});
	
    new Vue({
        el: '#app',
        data: {
        	//총가격 (기본가격 + 옵션가격)
           	totalPrice:<%=dto.getSalePrice()%>,
			//optionId productId 
			oId :0,
			pId :0,
			des : "",
           	count:0,
 			checked:"none",

 			selectedOption: '',
 			selectedOption2: 0,
 		    selectedOptions: [],
 		    
 		   product_num:0
 		  
			
        },
        methods: {
          	onSelected(e){
          		// "상품번호/가격"
          		const value=e.target.value;
          	
          		//option Id | 가격 | product Id | 상품이름
          		const optionNum = Number(value.split("/")[0]);
          		const price= Number(value.split("/")[1]);
          		const productNum = Number(value.split("/")[2]);
				const descript = value.split("/")[3]; 
				
          		this.oId += optionNum;
          		this.totalPrice += price;
          		this.pId += productNum;
          		this.des += descript;
          		
          		if(this.selectedOption){
          			this.selectedOption = descript;
          			this.selectedOption2 = price;
          			
          			const newOption = {
	          			name : this.selectedOption,
	          			price : this.selectedOption2
          			}
          			this.selectedOptions.push(newOption);
          			this.selectedOption = '';
          			this.selectedOption2 = '';
          		}
          		this.product_num ++;
          		
          	
          	},
          	plus(){
				this.count++;
			},
			minus(){
				if(count > 0){
					this.count--;
				}
			}
			    
		
			
        }
    });
    
    
    
	</script>
	
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="index" name="current"/>
	</jsp:include>
=======
                <div id="review-overview" class="d-flex" style="min-height: 300px;">
                    <div class="d-flex flex-column align-items-center justify-content-center">
                        <div class="d-flex flex-column align-items-center py-4">
                            <div class="d-flex justify-content-center">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="45" height="45" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star " style="fill: #FF753F">
                                    <defs>
                                        <path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>
                                    </defs>
                                    <use xlink:href="#star-full"></use>
                                </svg>
                                <div class="fs-2 fw-bold"> {{review_stat.avg_review}} </div> 
                            </div>
                            <div class="py-4">{{ likePercent(review_stat) }}%의 구매자가 이 상품을 좋아합니다</div>
                        </div>
                        <button id="write-review" class="btn btn-dark text-light py-2 fw-bold" >상품리뷰 작성하기</button>
                    </div>
                    <div class="vr mx-5"></div>   
                    <div class="flex-grow-1">
                        <div class="m-2">
                            <div class="pb-1">아주 좋아요 ({{ review_stat.count[4] }})</div>
                            <div class="progress">
                                <div class="progress-bar " :style="createRatingWidth(review_stat.count[4])" role="progressbar"></div>
                            </div>
                        </div>
                        <div class="m-2">
                            <div class="pb-1">맘에 들어요 ({{ review_stat.count[3] }})</div>
                            <div class="progress">
                                <div class="progress-bar " :style="createRatingWidth(review_stat.count[3])" role="progressbar"></div>
                            </div>
                        </div>
                        <div class="m-2">
                            <div class="pb-1">보통이에요 ({{ review_stat.count[2] }})</div>
                            <div class="progress">
                                <div class="progress-bar " :style="createRatingWidth(review_stat.count[2])" role="progressbar"></div>
                            </div>
                        </div>
                        <div class="m-2">
                            <div class="pb-1">그냥 그래요 ({{ review_stat.count[1] }})</div>
                            <div class="progress">
                                <div class="progress-bar " :style="createRatingWidth(review_stat.count[1])" role="progressbar"></div>
                            </div>
                        </div>
                        <div class="m-2">
                            <div class="pb-1">별로예요 ({{ review_stat.count[0] }})</div>
                            <div class="progress">
                                <div class="progress-bar " :style="createRatingWidth(review_stat.count[0])" role="progressbar"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr />
                <div id="user-reviews" class="my-2">
                    <div class="border-bottom my-4" v-for="rv in reviews">
                        <div class="d-flex justify-content-between">
                            <div><strong>{{ rv.reviewer_id}} </strong>님의 리뷰</div>
                            <div>{{ rv.created_at }}</div> 
                        </div>
                        <div class="py-2" style="min-height: 60px;">
                            <div v-if="!!rv.thumbnail" class="pe-2">
                                <img :src="rv.thumbnail" class="border" width=80 height=80/>
                            </div>
                            <div>
                                {{ rv.content }}
                            </div>                        
                        </div>
                        <div class="d-flex justify-content-between py-2 my-2">
                            <div class="text-secondary" style="font-size: 22px;"> {{ createStar(rv.rating )}} </div>
                            <a href='#' class="text-reset text-decoration-none"><img src="/Animalls/assets/like.png" alt="" width="22" /> {{ rv.like_count }} </a>
                        </div>
                    </div>
                </div>
            </div>
            
           <div>
                <h3 class="fw-bold my-2 py-2">상품 Q&A ({{qnas.length}})</h3>
                <hr />
                <div class="d-flex flex-column" style="min-height: 300px;"></div>
            </div>
        </div>
            

    </div>
    
    <jsp:include page="/include/footer.jsp">
        <jsp:param value="product" name="current" />
    </jsp:include>
    
    <script>
    	const v = new Vue({
    		el: '#product-detail-container',
    		data: {
    			"productOptions": [
    				<% for (ProductOptionDto opt : optionList) { %>
    					{ 
    						id: "<%= opt.getOptionId() %>", 
    						description: "<%= opt.getDescription() %>",
    						additional: "<%= opt.getAdditionalPrice() %>",
    						count: 1,
    					},
    				<% } %>
    			],
    			"selectedOption": "",
    			"choosed": [
    				<% if (!useMultipleOption) { %>
					{
						id: 0, 
						description: "기본 상품", 
						additional: "0",
						count: 1,
						price: <%= dto.getSalePrice() != 0 ? dto.getSalePrice() : dto.getOrgPrice() %>
					}
				<%} %>
    			], 
    			"reviews": [],
    			"qnas": [],
    			"review_stat": { "avg_review": "0", "total_count": 0, "count": [0,0,0,0,0] },
    			"page": 1,
    		},
    		methods: {
    			handleOptionChange: function(e) {
    				if (this.selectedOption === '') return; 
    				const idx = this.choosed.findIndex((obj) => obj.id === this.selectedOption);
    				if (idx === -1) {
    					const ref = this.productOptions.filter(x => x.id === this.selectedOption)[0]; 	
    					this.choosed.push({
    						...ref, 
    						price: <%= dto.getSalePrice() != 0 ? dto.getSalePrice() : dto.getOrgPrice() %> + parseInt(ref.additional),
    						count: 1,
    					});
    				} else {
    					this.choosed[idx].count += 1; 
    				}
    			},
    			removeChoice: function(id) {
    				this.choosed = this.choosed.filter(x => x.id !== id);
    			},
    			totalPrice: function() {
    				return this.choosed.reduce((acc, cur) => acc + cur.price * cur.count, 0);
    			},
    			getReviews: async function(p) {
    				if (!p) p = 1; 
    				const resp = await fetch(`/Animalls/api/review?productId=<%= productId %>&page=\${p}`); 
    				this.reviews = await resp.json();
    			},
    			getReviewStats: async function() {
    				const resp = await fetch(`/Animalls/api/review/stats?productId=<%= productId %>`);
    				const json = await resp.json(); 
    				if (json.avg_review == 'NaN') {
    					json.avg_review = '0';
    				}
    				this.review_stat = json;
    			},
    			createStar: function (rating) {
    				const arr = []; 
    				for (let i = 1 ; i <= 5; i++) {
    					if (i <= rating) {
    						arr.push('★'); 
    					} else {
    						arr.push('☆');
    					}
    				}
    				return arr.join('');
    			},
    			likePercent: function(stat) {
    				let percent = Math.round((stat.count[3] + stat.count[4]) / this.review_stat.total_count * 100);
    				if (Number.isNaN(percent)) {
    					percent = 0; 
    				}
    				return percent;
    			},
    			createRatingWidth: function (rating) {
    				let r = rating / this.review_stat.total_count * 100;
    				if (Number.isNaN(r)) {
    					r = 0; 
    				}
    				return { width: `\${r}%` }
    			}	
    		},
    		created: function() {
    			this.getReviews();
    			this.getReviewStats(); 
    		}
    	}); 
    	
    	document.querySelector('#write-review').addEventListener('click', (e) => {
    		if (<%= isGuest %>) {
    			alert("로그인 후 이용하세요");
    			return; 
    		}
    		document.location.href = '/Animalls/review/reviewInsertForm.jsp?productId=<%= productId %>';
    	})
    </script>
>>>>>>> refs/remotes/upstream/main
</body>
</html>



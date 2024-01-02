<%@page import="dto.MemberDto"%>
<%@page import="util.SessionManager"%>
<%@page import="dao.ReviewDao"%>
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
    
    MemberDto member  = SessionManager.getMember(request);
    boolean isGuest = member == null; 
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
</body>
</html>
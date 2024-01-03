<%@page import="dao.ReviewDao"%>
<%@page import="dto.ReviewDto"%>
<%@page import="dto.FileDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   

<% 
	String currentPage = request.getParameter("page"); 
	if (currentPage == null) {
		currentPage = "1"; 
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="/Animalls/css/common.css" rel="stylesheet" />
<link href="/Animalls/css/bootstrap.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

</head>
<body class="d-flex flex-column">
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="review" name="current"/>
	</jsp:include>
	
    <img class="w-100" src="/Animalls/assets/review-banner.png" alt="" />
    
	<div id="review-container" class="container flex-grow-1">
		<h1>Review</h1>
        
        <div class="category"> 
            <ul class="menuCategory nav nav-tabs" >
                <li class="nav-item"><button class="nav-link" :class="activeIfNew"  @click="setReviewOrder('new')">최신순</button></li>
                <li class="nav-item"><button class="nav-link" :class="activeIfRecommend" @click="setReviewOrder('recommend')">추천순</button></li>
            </ul>
        </div>
        <hr />
		<div class="mt-1">
            
            <div id="user-reviews" class="my-2">

                <div class="d-flex border-bottom my-4 w-100" v-for="rv in reviews">
                    <div class="d-flex flex-wrap justify-content-center" style="max-width: 200px;">
                        <a :href="productUrl(rv.product_id)">
                            <img :src="product[rv.product_id].thumbnail" class="me-3" alt="" width=100 height=100 />
                        </a>
                        <div>
                            <h5>{{ product[rv.product_id].title }} </h5>
                            <div v-if="product[rv.product_id].sale_price != 0">
                                <span class="fw-bold">{{ product[rv.product_id].sale_price }}</span>
                                <del>{{ product[rv.product_id].org_price }}</del> 
                            </div>
                            <div v-else>
                                <span class="fw-bold">{{ product[rv.product_id].org_price }}</span>                                
                            </div>
                        </div>
                        <!--  --> 
                    </div>
                    <div class="vr mx-4"></div>
                    <div class="flex-grow-1">
                        <div class="d-flex justify-content-between">
                            <div><strong>{{ rv.reviewer_id}} </strong>님의 리뷰</div>
                            <div>{{ rv.created_at }}</div> 
                        </div>
                        <div class="py-2 d-flex" style="min-height: 60px;">
                            <div v-if="!!rv.thumbnail" class="pe-2">
                                <img :src="rv.thumbnail" class="border" width=80 height=80/>
                            </div>
                            <div>
                                {{ rv.content }}
                            </div>
                        </div>
                        <div class="d-flex justify-content-between py-2 my-2">
                            <div class="text-secondary" style="font-size: 22px;"> {{ createStar(rv.rating)}} </div>
                            <a href='#' class="text-reset text-decoration-none"><img src="/Animalls/assets/like.png" alt="" width="22" /> {{ rv.like_count }} </a>
                        </div>
                    </div>
                </div>
            	
            	<div class="d-flex justify-content-center">
	            	<nav aria-label="Page navigation example">
					  <ul class="pagination" >
					  	<li class="page-item" :class="previousDisabledStyle"><a class="page-link" @click="handleClickPrevious">Previous</a></li>
						<li class="page-item" v-for="p in pageGroup" :class=getPageActiveStyle(p)><a class="page-link" @click="handlePageClick(p)">{{ p }} </a></li>
					    
					    <li class="page-item"  :class="lastDisabledStyle"><a class="page-link" @click="handleClickNext">Next</a></li>
					  </ul>
					</nav>
            	</div>
	            
            </div>
		</div>
        
	</div>
    
    <jsp:include page="/include/footer.jsp">
		<jsp:param value="review" name="current"/>
	</jsp:include></body>
    <script>
        new Vue({
        	el: '#review-container', 
        	data: {
        		order: 'new',
        		page: <%= currentPage %>,	
        		reviews: {},
        		product: {},
        		pageGroup: [],  
        		total_review_stat : { "avg_review": "5", "total_count":0, "count":[0,0,0,0,0] }
        	},
        	methods: {
        		getReviewAtPage: async function(page) {
        			const resp = await fetch(`/Animalls/api/review?page=\${page}`);
        			this.reviews = await resp.json();
        			for (const review of this.reviews) {
        				this.getProduct(review.product_id);
        			}
        		}, 
        		setReviewOrder(val) {
        			this.order = val; 
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
    			getProduct: async function (product_id) {
    				if (product_id in this.product) {
    					return; 
    				}
    				const resp = await fetch(`/Animalls/api/product?productId=\${product_id}`);
    				const json = await resp.json();
    				this.product = {
    					...this.product, 
    					[product_id]: json, 
    				}; 
    			},
    			productUrl: function (product_id) {
    				return `/Animalls/product/productDetail.jsp?productId=\${product_id}`;
    			}, 
    			getPageGroupNumber(p) {
    				return parseInt((p + 4) / 5);
    			}, 
    			getPageGroup(p) {
    				this.pageGroup = []; 
    				
    				const g = this.getPageGroupNumber(p); 
					const pageStart = (g - 1) * 5 + 1; 
					
					const lastPage = (this.total_review_stat.total_count + 4) / 5
					const pageEnd = Math.min(g * 5, lastPage);
					
				
					for (let i = pageStart ; i <= pageEnd; i++) {
						this.pageGroup.push(i); 
					}
    			},
    			getPageActiveStyle(p) {
    				return this.page == p ? "active" : ""; 
    			},
    			handlePageClick(p) {
    				this.page = p; 
    				
    		 		this.getReviewAtPage(this.page);
            		this.getPageGroup(this.page);    				
    			}, 
    			handleClickPrevious() {
    				const g = this.getPageGroupNumber(this.page); 
					this.handlePageClick((g - 1) * 5);
    			}, 
    			handleClickNext() {
    				const g= this.getPageGroupNumber(this.page); 
    				this.handlePageClick(g * 5 + 1); 
    			},
    			getTotalReviewStat: async function() {
        			const resp = await fetch("/Animalls/api/review/stats");
        			this.total_review_stat = await resp.json(); 
        		}, 
        	},  
        	computed: {
        		activeIfNew: function() {
        			return this.order === 'new' ? 'active' : '';
        		},
        		activeIfRecommend: function() {
 					return this.order === 'recommend' ? 'active' : '';       			
        		}, 
        		previousDisabledStyle: function() { 
        			return this.getPageGroupNumber(this.page) == 1 ? 'disabled' : ''; 
        		}, 
        		lastDisabledStyle: function() { 
					const lastPage = (this.total_review_stat.total_count + 4) / 5;
        			return this.getPageGroupNumber(lastPage) === this.getPageGroupNumber(this.page) ? 'disabled' : '';  
        		}
        	},
        	created: async function() {
        		console.log('vue init');
        		await this.getTotalReviewStat(); 
        		await this.getReviewAtPage(this.page);
        		this.getPageGroup(this.page);
        	}
        });
	</script>
</html>
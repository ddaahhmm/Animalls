<%@page import="dao.ReviewDao"%>
<%@page import="dto.ReviewDto"%>
<%@page import="dto.FileDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#myform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
	}
	#myform fieldset legend{
	    text-align: right;
	}
	#myform input[type=radio]{
	    display: none;
	}
	#myform label{
	    font-size: 3em;
	    color: transparent;
	    text-shadow: 0 0 0 #f0f0f0;
	}

	#myform input[type=radio]:checked ~ label{
	    text-shadow: 0 0 0 #ff753f;
	}

	#reviewContents {
	    width: 100%;
	    height: 150px;
	    padding: 10px;
	    box-sizing: border-box;
	    border: solid 1.5px #D3D3D3;
	    border-radius: 5px;
	    font-size: 16px;
	    resize: none;
	}
	/* ul 의 기본 스타일제거*/
	.page-list{
		margin: 0;
		padding: 0;
		list-style-type: none;
	}
	
	.page-list li{
		float: left; /* li 가 필요한 만큼의 폭만 차지하면서 가로로 배치 되도록 */
		padding: 5px;
	}
	
	.page-list li:hover{
		background-color: #cecece;
	}
	
	.page-list li a{
		color: #000;
		text-decoration: none;
	}
	
	.page-list li.active a{
		color: red;
		text-decoration: underline;
		font-weight: bold;
	}
	.paging-container {
        margin-bottom: 75px; 
	}
	.fog {
		position: aboslute; 
		width: 100%; 
		height: 100%;
	}
</style>
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
        		page: 1,
        		reviews: {},
        		product: {}
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
    			}
        	},  
        	computed: {
        		activeIfNew: function() {
        			return this.order === 'new' ? 'active' : '';
        		},
        		activeIfRecommend: function() {
 					return this.order === 'recommend' ? 'active' : '';       			
        		}
        	},
        	created: function() {
        		console.log('vue init');

        		this.getReviewAtPage(this.page);
        	}
        });
	</script>
</html>
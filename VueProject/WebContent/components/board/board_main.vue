<template>
	<!-- 게시글 리스트 -->
	<div class="container" style="margin-top:100px">
		<div class="card shadow">
			<div class="card-body">
				<h4 class="card-title">{{server_data.board_info_name}}</h4>
				<table class="table table-hover" id='board_list'>
					<thead>
						<tr>
							<th class="text-center d-none d-md-table-cell">글번호</th>
							<th class="w-50">제목</th>
							<th class="text-center d-none d-md-table-cell">작성자</th>
							<th class="text-center d-none d-md-table-cell">작성날짜</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for='obj in server_data.board_lists' @click='go_board_read' v-bind:key="obj">
							<td class="text-center d-none d-md-table-cell">{{obj.content_idx}}</td>
							<td>{{obj.content_subject}}</td>
							<td class="text-center d-none d-md-table-cell">{{obj.content_writer_name}}</td>
							<td class="text-center d-none d-md-table-cell">{{obj.content_date}}</td>
							
						</tr>
					</tbody>
				</table>
				
				<div class="d-none d-md-block">
					<ul class="pagination justify-content-center">
						<li class="page-item">
							<router-link to="/board_main" class="page-link">이전</router-link>
						</li>
						<li class="page-item" v-for="a1 in temp_list" v-bind:key="a1">
							<router-link to="/board_main" class="page-link">{{a1}}</router-link>
						</li>
						<li class="page-item">
						     <router-link to="/board_main" class="page-link">다음</router-link>
						</li>
					</ul>
				</div>
				
				<div class="d-block d-md-none">
					<ul class="pagination justify-content-center">
						<li class="page-item">
							 <router-link to="/board_main" class="page-link">이전</router-link>
						</li>
						<li class="page-item">
							 <router-link to="/board_main" class="page-link">다음</router-link>
						</li>
					</ul>
				</div>
				
				<div class="text-right" v-if="$store.state.user_login_chk==true">
					<router-link :to="'/board_write/'+$route.params.board_idx" class="btn btn-primary" >글쓰기</router-link>
				</div>
				
			</div>
		</div>
	</div>
</template>
<style>
	#board_list > tbody > tr {
		cursor: pointer;
	}
</style>
<script>
	module.exports = {
		data : function(){
			return {
				temp_list : [1,2,3,4,5,6,7,8,9,10],
				server_data : {}
			}
		},
		methods : {
			go_board_read : function(){
				this.$router.push('/board_read')
			},
			get_board_data : function(){
				//alert(this.$route.params.board_idx)
				var params = new URLSearchParams()
				params.append("board_idx",this.$route.params.board_idx)
				axios.post('server/board/get_board_list.jsp',params).then((response)=>{
					this.server_data = response.data
				})
			}
		},
		watch : {
			'$route' (to, from){
					this.get_board_data()
			}
			
		},
		created(){  //컴포넌트가 만들어질때 호출
			this.get_board_data()
		}
	}
</script>
<template>
<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<div class="form-group">
						<label for="board_writer_name">작성자</label>
						<input type="text" id="board_writer_name" v-model="server_data.user_name" class="form-control"  disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_date">작성날짜</label>
						<input type="text" id="board_date" v-model="server_data.content_date" class="form-control" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_subject">제목</label>
						<input type="text" id="board_subject" v-model="server_data.content_subject" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="board_content">내용</label>
						<textarea id="board_content" v-model="server_data.content_text" class="form-control" rows="10" style="resize:none"></textarea>
					</div>
					<div class="form-group">
						<label for="board_file">첨부 이미지</label>
						<img :src="'upload/'+server_data.content_file" width="100%" v-if="server_data.content_file != null"/>	
						<input type="file"  name="board_image" id="board_file" class="form-control" accept="image/*"/>					
					</div>
					<div class="form-group">
						<div class="text-right">
							<button type="button" class="btn btn-primary " @click="check_input">수정완료</button>
							<router-link to="/board_read" class="btn btn-info">취소</router-link>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>
</template>
<script>
	
	module.exports = {
		data : function(){
			return {
				server_data : {}
			}
		},
		methods : {
			check_input : function(){
			
					if(this.server_data.content_subject.length == 0){
						alert("제목을 입력해주세요")
						$("#board_subject").focus()
						return 
					}
					if(this.server_data.content_text.length == 0){
						alert("내용을 입력해주세요")
						$("#board_content").focus()
						return 
					}
					
					//alert($('#board_file')[0].files[0]);
					var params = new FormData()
					params.append('content_subject', this.server_data.content_subject)
					params.append('content_text', this.server_data.content_text)
					params.append('content_idx', this.$route.params.content_idx)

					if($('#board_file')[0].files[0] != undefined){
						params.append('content_file', $('#board_file')[0].files[0])
					}
					axios.post('server/board/modify_content.jsp',params).then((response)=>{
						if(response.data.result == true){
							alert('수정 되었습니다');
						    this.$router.push('/board_read/'+this.$route.params.board_idx+'/'+this.$route.params.page+'/'+this.$route.params.content_idx)
						}
					})
				

			}
		},
		created(){
			var params = new URLSearchParams()
			params.append('content_idx',this.$route.params.content_idx)
			axios.post('server/board/get_content.jsp',params).then((response)=>{
				this.server_data = response.data
			})
		}
	
}

</script>
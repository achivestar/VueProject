<template>
<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<div class="form-group">
						<label for="board_subject">제목</label>
						<input type="text" id="board_subject" v-model="board_subject" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="board_content">내용</label>
						<textarea id="board_content" v-model="board_content" class="form-control" rows="10" style="resize:none"></textarea>
					</div>
					<div class="form-group">
						<label for="board_file">첨부 이미지</label>
						<input type="file" id="board_file" name="board_file" class="form-control" accept="image/*"/>
					</div>
					<div class="form-group">
						<div class="text-right">
							<button type="button" class="btn btn-primary" @click="check_input">작성하기</button>
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
				board_subject : '',
				board_content : ''
			}
		
		},
		methods : {
			check_input : function(){
			
					if(this.board_subject.length == 0){
						alert("제목을 입력해주세요")
						$("#board_subject").focus()
						return
					}
					if(this.board_content.length == 0){
						alert("내용을 입력해주세요")
						$("#board_content").focus()
						return
					}

					//var params = new URLSearchParams() // 문자열 데이터만 보낼때
					var params = new FormData() //파일데이터 까지 보낼때
					params.append('board_writer_idx',this.$store.state.user_idx)
					params.append('board_subject',this.board_subject)
					params.append('board_content',this.board_content)
					params.append('board_file',$("#board_file")[0].files[0])
					params.append('content_board_idx',this.$route.params.board_idx)  //$route 는 파라미터로 넘어온 값을 말함
				
					axios.post('server/board/add_content.jsp',params).then((response)=>{
						if(response.data.result == true){
								alert('작성이 완료 되었습니다')
								this.$router.push('/board_read/'+this.$route.params.board_idx+'/1/'+response.data.content_idx)
						}
						
					})
					
				
					
			}
		
		}			
	
	}

</script>
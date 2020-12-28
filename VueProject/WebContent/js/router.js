var store = new Vuex.Store({
	//공용변수
	//애플리케이션 전체에서 사용할 변수
	state : {
		user_login_chk : false,
		user_id : '',
		user_name : '',
		user_idx : 0
	}
})
var router = new VueRouter({
	routes : [
		{
			path : '/',
			component : httpVueLoader('components/main/main.vue')
		},
		{
			path : '/board_main/:board_idx/:page',
			component : httpVueLoader('components/board/board_main.vue')
		},
		{
			path : '/board_read/:board_idx/:page/:content_idx',
			component : httpVueLoader('components/board/board_read.vue')
		},
		{
			path : '/board_modify/:board_idx/:page/:content_idx',
			component : httpVueLoader('components/board/board_modify.vue')
		},
		{
			path : '/board_delete/:board_idx/:page/:content_idx',
			beforeEnter(to, from, next){
				var params = new URLSearchParams()
				params.append('content_idx',to.params.content_idx)
				axios.post('server/board/delete_content.jsp',params).then((response)=>{
					alert('삭제되었습니다')
					next('/board_main/'+to.params.board_idx+'/'+to.params.page)
				})

			}
		},
		{
			path : '/board_write/:board_idx',
			component : httpVueLoader('components/board/board_write.vue')
		},
		{
			path : '/login',
			component : httpVueLoader('components/user/login.vue')
		},
		{
			path : '/join',
			component : httpVueLoader('components/user/join.vue')
		},
		{
			path : '/modify_user',
			component : httpVueLoader('components/user/modify_user.vue')
		},
		{
			path : '/logout',
			beforeEnter(to, from, next){
				alert('로그아웃 되었습니다.')
				store.state.user_login_chk = false
				store.state.user_id = ''
				store.state.user_name = ''
				store.state.user_idx = 0
				sessionStorage.clear()
				next('/')
			}
		}
		
	],
	scrollBehavior(to, from, savedPosition){
		return {
			x : 0,
			y : 0
		}
	}
})
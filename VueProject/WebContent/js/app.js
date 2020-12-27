$(function(){
	
	var app = new Vue({
		el : '#app',
		router : router,
		store : store,
		components : {
			'top-menu' : httpVueLoader ('components/common/top_menu.vue'),
			'bottom-info' : httpVueLoader ('components/common/bottom_info.vue')
		},
		beforeCreate : function(){
			if(sessionStorage.user_login_chk != undefined){  // 세션스토리지 정보가 자장되어 있다
				this.$store.state.user_login_chk = sessionStorage.user_login_chk
				this.$store.state.user_id = sessionStorage.user_id
				this.$store.state.user_name = sessionStorage.user_name
				this.$store.state.user_idx = sessionStorage.user_idx
			}
		}
	})
	
})
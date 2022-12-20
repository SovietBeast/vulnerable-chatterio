import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => {
    return {
      user: null,
      token:localStorage.getItem('token')
    }
  },
  getters: {
    getUser: state => state.user,
    getToken: state => state.token
  },
  actions: {
    setUser(user) {
      this.user = user
    },
    setToken(token){
      this.token = token
    }
  },
})

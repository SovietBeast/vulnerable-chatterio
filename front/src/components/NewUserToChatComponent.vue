<template>
  <div class="gray-background">
    <span class="exit" @click="exit">EXIT</span>
    <div class="new-chat-container">
      <h1>Add user to chat room!</h1>
      <div>User name:<v-text-field class="new-user-input" v-model="name" label="Name"></v-text-field></div>
      <v-btn @click="addNewUser">Add User!</v-btn>
    </div>
  </div>
</template>
<style>
  .gray-background{
    color:black;
    position:fixed;
    top:0;
    left:0;
    width:100vw;
    height:100vh;
    opacity:0.9;
    background:gray;
    display:flex;
    justify-content:center;
    align-items:center;
    z-index:10;
  }
  .new-chat-container{
    width:50vw;
    height:50vh;
    background:white;
    
  }
  .exit{
    font-size:36px;
    position:absolute;
    right:0;
    top:0;
  }
  .new-user-input{
    width:150%;
    margin:0;
  }
</style>
<script>
import { defineComponent, ref } from "vue";
import { addUserToChatroom } from "../service/chat";
import { useChatStore } from "../store/chatStore";
import { VTextField,VBtn } from "vuetify/components";
  export default defineComponent({
    components:{VTextField,VBtn},
    name:"AddNewUser",
    emits: ['clickedExit'],
    setup(_, { emit }){
      const name = ref('');
      const chatStore = useChatStore();

      const addNewUser = () => {
        const payload = {user:name.value,chatroom_id:chatStore.getSelectedChatRoom.chatroom_id};
        addUserToChatroom(payload)
        emit('clickedExit')
      }

      return{
        addNewUser,
        name,
      }
    },
    methods:{
      exit(){
        this.$emit('clickedExit')
      }
    }
  })
</script>
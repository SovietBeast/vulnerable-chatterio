<template>
  <div class="gray-background">
    <span class="exit" @click="exit">EXIT</span>
    <div class="new-chat-container">
      <h1>Add a new chat!</h1>
      Chat name:<v-text-field class="input-new-chat" v-model="name" label="Name"></v-text-field>
      <div class="private-chat">Private chat:<VCheckbox class="private-checkbox" v-model="isPrivate"></VCheckbox></div>
      <v-btn @click="addNewChat" class="chat-add-button">ADD CHAT</v-btn>
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
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    width:30vw;
    height:50vh;
    background:white;
    -webkit-box-shadow: 9px 21px 41px -6px rgba(66, 68, 90, 1);
-moz-box-shadow: 9px 21px 41px -6px rgba(66, 68, 90, 1);
box-shadow: 9px 21px 41px -6px rgba(66, 68, 90, 1);
  }
  .exit{
    font-size:36px;
    position:absolute;
    right:0;
    top:0;
  }
  .input-new-chat{
    width:35%;
    min-height:auto !important;
    line-height:36px;
    padding:0;
  }
  .private-chat{
    display:flex;
    align-items:center;
    justify-content:center;
  }
  .private-checkbox{
    margin-top:20px;
  }
  .chat-add-button{
    margin-bottom:15px;
  }
</style>
<script>
import { defineComponent, ref } from "vue";
import { addNewChatroom } from "../service/chat";
import { VTextField, VBtn, VCheckbox } from 'vuetify/components'
  export default defineComponent({
    components:{VTextField,VBtn, VCheckbox},
    name:"AddNewChat",
    emits: ['clickedExit'],
    setup(_, { emit }){
      const name = ref('');
      const isPrivate = ref(false);

    const addNewChat = () => {
      const chat = {
        name: name.value,
        private: isPrivate.value,
      };
      try{
        addNewChatroom(chat);
        emit('clickedExit');
      }
      catch(e){
        console.log(e);
      }
      
    };

    return {
      addNewChat,
      name,
      isPrivate,
    };
  },
  methods: {
    exit() {
      this.$emit("clickedExit");
    },
  },
});
</script>

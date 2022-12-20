<template>
  <main-navbar-vue></main-navbar-vue>
  <v-navigation-drawer permanent>
    <new-chat-component
      v-if="newChatOpen"
      @clickedExit="showAddNewChat"
    ></new-chat-component>
    <new-user-to-chat-component
      v-if="newUserOpen"
      @clickedExit="showAddNewUserToChat"
    ></new-user-to-chat-component>
    <v-btn
      color="primary"
      class="mt-4 mb-2 ml-3"
      prepend-icon="mdi-message-plus"
      @click="showAddNewChat"
      >Create room</v-btn
    >
    <v-list color="transparent">
      <v-list-item
        @click="handleSelectChatRoom(chat)"
        :class="{
          'bg-blue-lighten-3':
            selectedChatRoom?.chatroom_id === chat.chatroom_id,
        }"
        :key="chat.chatroom_id"
        v-for="chat in chatRooms"
        :title="chat.name"
      ></v-list-item>
    </v-list>
  </v-navigation-drawer>
  <v-main>
    <div v-if="selectedChatRoom" class="chat-box-container">
      <div class="d-flex justify-center chat-title">
        <v-btn
          v-if="selectedChatRoom.private"
          color="primary"
          variant="outlined"
          class="ma-2"
          prepend-icon="mdi-account-plus"
          @click="showAddNewUserToChat"
          >Add user</v-btn
        >
        <div class="chat-box-title ma-2">
          Welcome to {{ selectedChatRoom.name }}
        </div>
      </div>
      <div class="chat-box" ref="chatBox">
        <div
          v-for="message in messages"
          :key="message.message_id"
          class="chat-box-wrapper"
          :class="{
            author:
              message.username === user.username ||
              message.user_id === user.user_id,
          }"
        >
          <div class="chat-box-author">{{ message.username }}</div>
          <div class="chat-box-message">{{ message.message_text }}</div>
        </div>
      </div>
      <div class="chat-input">
        <v-text-field
          color="secondary"
          v-model="chatMessage"
          variant="outlined"
          @keyup.enter="handleSubmit"
        ></v-text-field>
        <div>
          <v-btn color="secondary" @click="handleSubmit">Send</v-btn>
        </div>
      </div>
    </div>
    <div v-else>Najpierw wybierz pokój</div>
  </v-main>
</template>
<script setup>
import { defineComponent, onMounted, ref, computed, watchEffect, watch, onUpdated, onUnmounted } from "vue";
import {
  VNavigationDrawer,
  VMain,
  VBtn,
  VList,
  VListItem,
  VTextField,
} from "vuetify/components";
import { useRouter } from "vue-router";
import { useUserStore } from "../store/userStore";
import { useChatStore } from "../store/chatStore";
import { getChatrooms, getMessages } from "../service/chat";
import { v4 as uuidv4 } from "uuid";
import NewChatComponent from "../components/NewChatComponent.vue";
import NewUserToChatComponent from "../components/NewUserToChatComponent.vue";
import MainNavbarVue from "../components/MainNavbar.vue";

const api = `ws://127.0.0.1:8000/api`;
const chatMessage = ref("");
const userStore = useUserStore();
const chatStore = useChatStore();
const user = computed(() => userStore.getUser);
const router = useRouter();
const observer = ref(null);
const chatRooms = computed(() => chatStore.getChatRooms);
const selectedChatRoom = computed(() => chatStore.getSelectedChatRoom);
const messages = computed(() => chatStore.getMessages);

  
const newChatOpen = ref(false);
const newUserOpen = ref(false);
const socket = ref(null);
const chatBox = ref(null);

const scrollToEnd = (el) => {
  chatBox.value.scrollTop = chatBox.value.scrollHeight;
}

onMounted(() => {
  getChatrooms();
  if (chatRooms.selectedChatRoom) {
    getMessages();
  }
});

const handleSelectChatRoom = async (chat) => {
  chatStore.setSelectedChatRoom(chat);
  observer.value?.disconnect();
  if (socket.value) {
    socket.value.close();
    socket.value = null;
  }

  socket.value = new WebSocket(
    `${api}/messages/ws/${chat.chatroom_id}?token=${userStore.getToken}`
  );
  socket.value.onmessage = (payload) => {
    const message = JSON.parse(payload.data);
    if (!message.status) {
      chatStore.messages.push({
        message_text: message.message,
        username: message.username,
      });
    }
  };
  await getMessages(chat.chatroom_id);
  const config = { attributes: true, childList: true, subtree: true };
  observer.value = new MutationObserver(scrollToEnd);
  observer.value.observe(chatBox.value,config)
  scrollToEnd();
};
const showAddNewChat = () => {
  if(newChatOpen.value === true){
    getChatrooms();
  }
  newChatOpen.value = !newChatOpen.value;
  //todo
};
const showAddNewUserToChat = () => {
  newUserOpen.value = !newUserOpen.value;
  //todo
};
const handleSubmit = () => {
  const message = {
    message: chatMessage.value,
    username: userStore.getUser.username,
  };
  chatMessage.value = "";
  socket.value.send(JSON.stringify(message));
};
onUnmounted(() => {
  observer.value?.disconnect();
})
</script>

<style lang="scss">
.chat-box-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  padding: 10px;
}
.chat-title {
  flex: 0 0 auto;
}

.chat-box {
  display: flex;
  flex-direction: column;
  flex: 1 0 0;
  gap: 5px;
  overflow: auto;
  &-title {
    text-align: center;
    font-size: 24px;
  }
  &-author {
    font-size: 12px;
  }
  &-wrapper {
    display: flex;
    flex-direction: column;

    &.author {
      align-self: flex-end;
      & .chat-box-message {
        background: #55aaff;
      }
      & .chat-box-author {
        text-align: right;
      }
    }
  }
  &-message {
    padding: 5px 10px;
    background: #e4e6eb;
    align-self: flex-start;
    border-radius: 8px;
  }
}

.chat-input {
  display: flex;
  justify-content: stretch;
  align-items: center;
  gap: 20px;
  flex: 0 0 auto;
  margin-top: 20px;
  & input {
    align-self: stretch;
    flex: 1;
  }
}
</style>

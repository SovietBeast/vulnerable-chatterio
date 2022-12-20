import { defineStore } from "pinia";

export const useChatStore = defineStore("chat", {
  state: () => {
    return {
      chatRooms: [],
      selectedChatRoom: null,
      messages: [],
    };
  },
  getters: {
    getChatRooms: (state) => state.chatRooms,
    getSelectedChatRoom: (state) => state.selectedChatRoom,
    getMessages: (state) => state.messages,
  },
  actions: {
    setChatRooms(rooms) {
      this.chatRooms = rooms;
    },
    addMessage(message) {
      this.messages = [...this.messages, message];
    },
    setMessages(messages) {
      this.messages = messages;
    },
    setSelectedChatRoom(chat) {
      this.selectedChatRoom = chat;
    },
  },
});

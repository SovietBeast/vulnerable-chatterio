import { useUserStore } from '../store/userStore';
import { useChatStore } from '../store/chatStore';
import axios from 'axios';
import { useRouter } from 'vue-router';
const api = 'http://127.0.0.1:8000'

export const getChatrooms = async () => {
  const router = useRouter();
  const chatStore = useChatStore();
  const userStore = useUserStore();
  try{
    const {data} = await axios.get(`${api}/api/users/get/chatrooms`,{headers:{'Authorization':` Bearer ${userStore.getToken}`}})  
    chatStore.setChatRooms(data);
    return data
  }
  catch(err){
      router.push('/login')
  }
}
export const addNewChatroom = async (chat) =>{
  chat.passcode = '';
  const userStore = useUserStore();
  const config = {headers:{'Authorization':` Bearer ${userStore.getToken}`}}
  const {data} = await axios.post(`${api}/api/chatrooms`,chat,config)
  return data;
}
export const addUserToChatroom = async (payload) => {
  const userStore = useUserStore();
  const config = {headers:{'Authorization':` Bearer ${userStore.getToken}`}}
  const {data} = await axios.post(`${api}/api/users/add/chatroom`,payload,config)
  console.log(data);
}
export const getMessages = async (selectedChatRoomId) => {
  const userStore = useUserStore();
  const chatStore = useChatStore();
  const config = {headers:{'Authorization':` Bearer ${userStore.getToken}`}}
  const {data} = await  axios.get(`${api}/api/chatrooms/${selectedChatRoomId}/messages`,config)
  chatStore.setMessages(data);
  
}
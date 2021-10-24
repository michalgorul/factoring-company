import axios from "axios";
import { errorToast } from "../components/toast/makeToast";
import config from "./config";

const register = async (registration) => {

  fetch(`${config.API_URL}/registration`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(registration)
  })
};

const login = async (username, password) => {

  const data = {
    username: username,
    password: password
  }

  const response = await axios
    .post(`${config.API_URL}/login`, data);

    if(!response.ok){
      errorToast('Your username or password were incorrect!')
    }

  if (response) {
    console.log(response);
    if(!response.ok){
      errorToast('Your username or password were incorrect!')
    }
    let myHeaders = new Headers(response.headers);
    let token = myHeaders.get('Authorization').replace("Bearer ", "");

    if (token && token.length > 0) {
      localStorage.setItem('token', token);
      localStorage.setItem('isAuthenticated', true);
    }

  }
};

const logout = () => {
  localStorage.clear();

};

const getCurrentUser = () => {
  return JSON.parse(localStorage.getItem("user"));
};

export {
  register,
  login,
  logout,
  getCurrentUser,
};
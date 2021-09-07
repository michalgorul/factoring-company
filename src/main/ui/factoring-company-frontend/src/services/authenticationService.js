import axios from "axios";
import config from "./config";

const register = (username, email, password) => {
  return axios.post(config.API_URL + "signup", {
    username,
    email,
    password,
  });
};

const login = async (username, password) => {

  const data = {
        username: username,
        password: password
    }

  const response = await axios
        .post(`${config.API_URL}/login`, data);

    if (response.headers) {
			let myHeaders = new Headers(response.headers);
      let token = myHeaders.get('Authorization').replace("Bearer ", "");

      if(token && token.length > 0){
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

export  {
  register,
  login,
  logout,
  getCurrentUser,
};
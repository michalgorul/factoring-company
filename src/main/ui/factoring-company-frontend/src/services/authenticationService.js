import axios from "axios";

const API_URL = "http://localhost:8443/";

const register = (username, email, password) => {
  return axios.post(API_URL + "signup", {
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
        .post(API_URL + "login", data);

    if (response.headers) {
			let myHeaders = new Headers(response.headers);
      let token = myHeaders.get('Authorization').replace("Bearer ", "");
      localStorage.setItem('token', token);
    }
};

const logout = () => {
  localStorage.removeItem('token');
};

const getCurrentUser = () => {
  return JSON.parse(localStorage.getItem("user"));
};

export default {
  register,
  login,
  logout,
  getCurrentUser,
};
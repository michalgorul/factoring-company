import axios from "axios";
import config from "./config";

const getUserDetails = () => {
    return axios({
        method: "GET",
        url: `${config.API_URL}/user/current`,
        headers: {
            "Authorization": `Bearer ${localStorage.getItem('token')}`
        }
    })
}
export {getUserDetails};
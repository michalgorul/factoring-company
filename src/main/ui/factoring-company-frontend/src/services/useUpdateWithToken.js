import { useHistory } from "react-router-dom";
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Zoom } from 'react-toastify';
toast.configure();

const useUpdateWithToken = async (url, body, message) => {

    const history = useHistory();

            fetch(url, {
                method: 'PUT',
                body: JSON.stringify(body),
                headers: {
                    "Authorization": `Bearer ${localStorage.getItem('token')}`,
                    "Content-Type": "application/json"
                }
            })
            .then( () => {
                history.goBack();
            })
            .then( () => {
                toast.info(message, {
                    position: "bottom-right",
                    autoClose: 5000,
                    hideProgressBar: false,
                    closeOnClick: true,
                    pauseOnHover: true,
                    draggable: true,
                    progress: undefined,
                    transition: Zoom,
                    className:"text-white bg-primary",
                    });
            })
            .catch(err =>{
                if(err.name === "AbortError"){
                    console.log('fetch aborted');
                }
            
            })
            
}
 
export default useUpdateWithToken;
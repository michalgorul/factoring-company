import {toast, Zoom} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

toast.configure();

const infoToast = (message) => {
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
}

const errorToast = (message) => {
    toast.error(message, {
        position: "bottom-right",
        autoClose: 5000,
        hideProgressBar: false,
        closeOnClick: true,
        pauseOnHover: true,
        draggable: true,
        progress: undefined,
        });
}

export {infoToast, errorToast}
import {toast, Zoom} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

toast.configure();

const infoToast = (meaaage) => {
    toast.info(meaaage, {
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

export {infoToast}
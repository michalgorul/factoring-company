import { Row, Col, Toast, Button } from 'react-bootstrap';
import { useState } from "react";

import React from 'react';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Zoom } from 'react-toastify';
  const Example = () => {
    const notify = () => {
        toast.info('Customer was deleted', {
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
    };

    return <button onClick={notify}>Notify</button>;
  }
toast.configure();
const Invoices = () => {
    return ( 
        <>
        <Example />
        </>
     );
}
 
export default Invoices;
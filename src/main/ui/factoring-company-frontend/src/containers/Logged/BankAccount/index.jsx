import { useParams } from "react-router-dom";
import useFetch from "../../../components/useFetch/useFetch";
import { useState, useEffect } from "react";
import { Spinner } from 'react-bootstrap';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Zoom } from 'react-toastify';
toast.configure();

const EditBankAccount = () => {
    const [bankName, setBankName] = useState('');
    const [number, setNumber] = useState('');
    const [swift, setSwift] = useState('');
    const [isPendingN, setIsPendingN] = useState(false);

    const { id } = useParams();
    const {data: editAccount, error, isPending} = useFetch('http://localhost:8000/customers/' + id);

    useEffect(() => {
        getCustomer();
      });

      function getCustomer() {
        fetch('http://localhost:8000/bank-account/' + id)
        .then((result) => {
          result.json()
          .then((response) => {
            setBankName(response.bankName);
            setNumber(response.number);
            setSwift(response.swift);

          })
        })
      }

      const handleSubmit = (e) => {
        e.preventDefault();
        const account = { bankName, number, swift};
        setIsPendingN(true);
        const requestOptions = {
            method: 'PUT',
            headers: {
                'Accept':'application/json',
                'Content-Type':'application/json'
            },
            body: JSON.stringify(account)};

        fetch('http://localhost:8000/bank-account/' + id, requestOptions)
        .then(() => {
            setIsPendingN(false);

        })
        .then(() => {
            toast.info('Bank account was updated', {
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
        });    
    }

    return ( 
<div>
            {isPending && isPendingN && <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary" /></div>}
            {error && <div>{error}</div>}
            {editAccount && (
            <div class="container-fluid h-custom">
                <div class="row d-flex justify-content-start align-items-center">
                    <div class="col-md-8 col-lg-8 col-xl-6">
                        <form onSubmit={handleSubmit}>
                        <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                            <p class="lead fw-normal mt-2 mb-3 display-4">Edit Bank Account</p>

                        </div>
                        <div class="form-outline form-floating mb-3">
                            <input type="text" class="form-control form-control-lg"
                            placeholder="Enter a valid email address" required value={bankName} onChange={(e) => setBankName(e.target.value)} />
                            <label class="form-label">Bank name</label>
                        </div>

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password" required value={number} onChange={(e) => setNumber(e.target.value)} />
                            <label class="form-label">Bank account number</label>
                        </div>

                        <div class="form-floating form-outline mb-3">
                            <input type="text" class="form-control form-control-lg" 
                            placeholder="Enter password" required value={swift} onChange={(e) => setSwift(e.target.value)} />
                            <label class="form-label">SWIFT</label>
                        </div>

                        <div class="mb-3">
                            {!isPending && <button class="btn btn-primary rounded-pill btn-lg">Edit Bank Account</button>}
                            {isPending && <button class="btn btn-primary rounded-pill btn-lg" disabled>Editing account...</button>}
                        </div>
                            
                        </form>
                    </div>
                </div>
            </div>)}
        </div>
     );
}
 
export default EditBankAccount;
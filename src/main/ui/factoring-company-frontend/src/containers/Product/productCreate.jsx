import { useState } from "react";
import { useHistory } from "react-router-dom";
import 'react-phone-number-input/style.css';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { infoToast, warningToast } from "../../components/toast/makeToast";
import  config  from '../../services/config';

toast.configure();

const ProductCreate = () => {

    const [isPending, setIsPending] = useState(false);
    const [name, setName] = useState('');
    const [pkwiu, setPkwiu] = useState('');
    const [measureUnit, setMeasureUnit] = useState('');
    const history = useHistory();

    const handleSubmit = (e) => {
        e.preventDefault();

        const product = { name, pkwiu, measureUnit };
        setIsPending(true);

        fetch(`${config.API_URL}/api/product`, {
            method: 'POST',
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${localStorage.getItem("token")}`
            },
            body: JSON.stringify(product)
        })
            .then((response) => {
                setIsPending(false);
                if (response.ok) {
                    history.push('/user/invoices/create');
                    return response;
                }
                else {
                    return response
                }
            })
            .then((response) => {
                if (response.ok) {
                    infoToast('Product was added')
                }
                else {
                    warningToast('Some of inputs are incorrect')
                }
            })
    }


    return (
        <>

            <div class="container-fluid h-custom">
                <div class="row d-flex justify-content-start align-items-center">
                    <div class="col-md-8 col-lg-8 col-xl-6">
                        <form onSubmit={handleSubmit}>
                            <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                                <p class="lead fw-normal mt-2 mb-3 display-4">New Product</p>

                            </div>

                            <div class="form-outline form-floating mb-3">
                                <input type="text" class="form-control form-control-lg"
                                    placeholder="Enter a valid email address" required value={name} onChange={(e) => setName(e.target.value)} />
                                <label class="form-label">Name</label>
                            </div>

                            <div class="form-floating form-outline mb-3">
                                <input type="text" class="form-control form-control-lg"
                                    placeholder="Enter password" required value={pkwiu} onChange={(e) => setPkwiu(e.target.value)} />
                                <label class="form-label">PKWIU</label>
                            </div>

                            <div class="form-floating form-outline mb-3">
                                <input type="text" class="form-control form-control-lg"
                                    placeholder="Enter password" required value={measureUnit} onChange={(e) => setMeasureUnit(e.target.value)} />
                                <label class="form-label">Measure unit</label>
                            </div>

                            <div class="mb-3">
                                {!isPending && <button class="btn btn-primary rounded-pill btn-lg">Add Product</button>}
                                {isPending && <button class="btn btn-primary rounded-pill btn-lg" disabled>Adding product...</button>}
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </>
    );
}

export default ProductCreate;
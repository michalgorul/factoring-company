import { useHistory, useParams } from "react-router-dom";
import { useState, useEffect, useMemo } from "react";
import { Spinner } from 'react-bootstrap';
import  config  from '../../../services/config';
import { errorToast, infoToast } from "../../../components/toast/makeToast";
import useFetchWithToken from "../../../services/useFetchWithToken";

const ProductEdit = () => {

    const [name, setName] = useState('');
    const [pkwiu, setPkwiu] = useState('');
    const [measureUnit, setMeasureUnit] = useState('');
    const [isPendingN, setIsPendingN] = useState(false);

    const { id } = useParams();
    const { data: editProduct, error, isPending } = useFetchWithToken(`${config.API_URL}/api/product/${id}`);
    const history = useHistory();

    useEffect(() => {
        getProduct();
    }, [editProduct])

    function getProduct() {
        if (editProduct) {
            setName(editProduct.name);
            setPkwiu(editProduct.pkwiu);
            setMeasureUnit(editProduct.measureUnit);
        }

    }

    const handleSubmit = (e) => {
        e.preventDefault();
        const product = { name, pkwiu, measureUnit };
        setIsPendingN(true);
        fetch(`${config.API_URL}/api/product/${id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${localStorage.getItem("token")}`
            },
            body: JSON.stringify(product)
        })
            .then((response) => {
                setIsPendingN(false);
                if (response.ok) {
                    history.push('/user/invoices/create');
                    return response;
                }
                else {
                    return response;
                }
            })
            .then((response) => {
                if (response.ok) {
                    infoToast('Product was updated');
                }
                else {
                    errorToast('Some of inputs were incorrect');
                }
            })
            .catch(err => {
                console.error(err);
            })
    }

    return (
        <div>
            {isPending && isPendingN && <div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
            {error && <div>{error}</div>}
            {editProduct && (
                <div class="container-fluid h-custom">
                    <div class="row d-flex justify-content-start align-items-center">
                        <div class="col-md-8 col-lg-8 col-xl-6">
                            <form onSubmit={handleSubmit}>
                                <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                                    <p class="lead fw-normal mt-2 mb-3 display-4">Edit Product</p>

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
                                    {!isPending && <button class="btn btn-primary rounded-pill btn-lg">Edit Product</button>}
                                    {isPending && <button class="btn btn-primary rounded-pill btn-lg" disabled>Editing product...</button>}
                                </div>

                            </form>
                        </div>
                    </div>
                </div>)}
        </div>

    );
}

export default ProductEdit;
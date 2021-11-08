import Select from "react-select";
import useFetchWithToken from "../../../../services/useFetchWithToken";
import config from "../../../../services/config";
import React, {useEffect, useState} from "react";

const VatReport = () => {

    const {data: customers, errorC, isPendingC} = useFetchWithToken(`${config.API_URL}/api/customer/current`);

    const [customerPhone, setCustomerPhone] = useState('');
    const [customer, setCustomer] = useState(null);


    const makeCustomerOptions = (customers) => {
        let customersArray = [];

        if (customers) {
            customers.forEach((item) => {
                let it = {
                    value: item.phone.toString(),
                    label: item.firstName.toString() + ' ' + item.lastName.toString() + ', phone: ' + item.phone.toString()
                };
                customersArray.push(it);
            })
        }
        return customersArray;
    }

    const optionsCustomers = makeCustomerOptions(customers);

    useEffect(() => {

        fetch(`${config.API_URL}/api/customer/phone/${customerPhone}`, {
            method: 'GET',
            headers: {
                "Authorization": `Bearer ${localStorage.getItem('token')}`
            }
        })
            .then(res => {
                if (!res.ok) {
                    throw Error("could not fetch the data for that resource");
                }
                return res.json();
            })
            .then(data => {
                setCustomer(data);
            })
            .catch(err => {
                console.log('fetch aborted');
            })
    })

    const showCustomersDetails = (customer) => {
        if (customer) {
            return (
                <>
                    <div>
                        <ul className="list-group list-group-flush">
                            <li className="list-group-item">Name: <b>{customer.firstName + ' ' + customer.lastName} </b></li>
                            <li className="list-group-item">Email: <b> {customer.email} </b></li>
                            <li className="list-group-item">Country: <b>{customer.country}</b></li>
                            <li className="list-group-item">City: <b>{customer.city}</b></li>
                            <li className="list-group-item">Street: <b>{customer.street} </b></li>
                            <li className="list-group-item">Postal code: <b>{customer.postalCode}</b></li>
                            <li className="list-group-item">Phone: <b>{customer.phone}</b></li>
                        </ul>
                    </div>
                    <div className="d-flex">
                        <a href={"/user/customers/edit/" + customer.id} className="text-decoration-none ml-auto">Edit customer's
                            details</a>
                    </div>
                    <div className="d-flex mb-5">
                        <a href={"/user/customers/create"} className="text-decoration-none ml-auto">Create new customer</a>
                    </div>
                </>
            )
        }
        return (
            <div className="d-flex mb-4">
                <a href={"/user/customers/create"} className="text-decoration-none ml-auto">Create new customer</a>
            </div>
        )
    }

    const handleGenerate = () => {

    }


    const showGenerateReportButton = (customer) => {
        if (customer) {
            return (
                <div className="text-center">
                        <button className="btn btn-lg btn-primary rounded-pill text-white" onClick={handleGenerate}>Generate
                            report</button>
                </div>

            )
        }

    }

    return (
        <>
            <div className="media align-items-center py-3">
                <div className="media-body ml-4">
                    <h4 className="font-weight-bold display-2">VAT report</h4>
                </div>
            </div>
            <div className="container-fluid">
                <div className="d-flex justify-content-start align-items-center">
                    <div className="col-md-8 col-lg-8 col-xl-6">
                        <div className="row mb-2">
                            <div className="col-12">
                                <span style={{marginLeft: "5px"}} className="h5">Customer</span>
                                <Select onChange={(e) => setCustomerPhone(e.value)} options={optionsCustomers}/>
                            </div>
                        </div>

                        {showCustomersDetails(customer)}

                        {showGenerateReportButton(customer)}
                    </div>
                </div>
            </div>
        </>

    );
}

export default VatReport;
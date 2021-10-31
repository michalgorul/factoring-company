import { useEffect, useState } from 'react';
import TextField from '@material-ui/core/TextField';
import AdapterDateFns from '@material-ui/lab/AdapterDateFns';
import LocalizationProvider from '@material-ui/lab/LocalizationProvider';
import DateTimePicker from '@material-ui/lab/DateTimePicker';
import CreatableSelect from 'react-select/creatable';
import Select from 'react-select'
import { Form, Row, Col } from 'react-bootstrap';
import { Spinner } from 'react-bootstrap';
import FloatingLabel from "react-bootstrap-floating-label";
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Zoom } from 'react-toastify';
import config from '../../../services/config';
import useFetchWithToken from '../../../services/useFetchWithToken';
toast.configure();


const InvoiceCreate = () => {
	const [performanceDate, setPerformanceDate] = useState(new Date());
	const [issueDate, setIssueDate] = useState(new Date());
	const [quentity, setQuentity] = useState('');
	const [gross, setGross] = useState('');
	const [vat, setVat] = useState('');
	const [months, setMonths] = useState('');
	const [isPendingN, setIsPending] = useState(false);

	const [customerPhone, setCustomerPhone] = useState('');
	const [customer, setCustomer] = useState(null);
	const [productName, setProductName] = useState('');
	const [product, setProduct] = useState(null);


	const { data: products, error, isPending } = useFetchWithToken(`${config.API_URL}/api/product`);
	const { data: customers, errorC, isPendingC } = useFetchWithToken(`${config.API_URL}/api/customer/current`);


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

		fetch(`${config.API_URL}/api/product/name/${productName}`, {
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
				setProduct(data);
			})
			.catch(err => {
				console.log('fetch aborted');
			})

	}, [customerPhone, productName])

	const handleSubmit = (e) => {
		e.preventDefault();

		if (!product || !vat || !performanceDate || !issueDate) {
			toast.warn('Please fill all fields', {
				position: "bottom-right",
				autoClose: 5000,
				hideProgressBar: false,
				closeOnClick: true,
				pauseOnHover: true,
				draggable: true,
				progress: undefined,
				transition: Zoom,
				className: "bg-warning text-dark"
			});
		}
		else {
			const buyer = { performanceDate, issueDate, product, quentity, gross, vat, months };

			console.log(buyer);
		}
	}

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

	const makeProductOptions = (products) => {
		let productArray = [];

		if (products) {
			products.forEach((item) => {
				let it = {
					value: item.name.toString(),
					label: item.name.toString(),
				};
				productArray.push(it);
			})
		}
		return productArray;
	}


	const optionsProduct = makeProductOptions(products);
	const optionsCustomers = makeCustomerOptions(customers);

	const showCustomersDetails = (customer) => {
		if (customer) {
			return (
				<>
					<div>
						<ul class="list-group list-group-flush">
							<li class="list-group-item">Name: <b>{customer.firstName + ' ' + customer.lastName} </b></li>
							<li class="list-group-item">Email: <b> {customer.email} </b></li>
							<li class="list-group-item">Country: <b>{customer.country}</b></li>
							<li class="list-group-item">City: <b>{customer.city}</b></li>
							<li class="list-group-item">Street: <b>{customer.street} </b></li>
							<li class="list-group-item">Postal code: <b>{customer.postalCode}</b></li>
							<li class="list-group-item">Phone: <b>{customer.phone}</b></li>
						</ul>
					</div>
					<div class="d-flex">
						<a href={"/user/customers/edit/" + customer.id} className="text-decoration-none ml-auto">Edit customer's details</a>
					</div>
					<div class="d-flex mb-5">
						<a href="/user/customers/create" className="text-decoration-none ml-auto">Create new customer</a>
					</div>
				</>
			)
		}
		return (
			<div class="d-flex mb-4">
				<a href="/user/customers/create" className="text-decoration-none ml-auto">Create new customer</a>
			</div>
		)
	}

	const showProductDetails = (product) => {
		if (product) {
			return (
				<>
					<div>
						<ul class="list-group list-group-flush">
							<li class="list-group-item">Name: <b>{product.name} </b></li>
							<li class="list-group-item">PKWIU: <b> {product.pkwiu} </b></li>
							<li class="list-group-item">Measure unit: <b>{product.measureUnit}</b></li>
						</ul>
					</div>
					<div class="d-flex">
						<a href={`/user/product/edit/${product.id}`} className="text-decoration-none ml-auto">Edit product's details</a>
					</div>
					<div class="d-flex mb-5">
						<a href="/user/product/create" className="text-decoration-none ml-auto">Create new product</a>
					</div>
				</>
			)
		}
		return (
			<div class="d-flex mb-4">
				<a href="/user/product/create" className="text-decoration-none ml-auto">Create new product</a>
			</div>
		)
	}

	return (

		<>
			<div>
				{isPending && isPendingC && isPendingN && <div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
				{error && <div>{error}</div>}
				{errorC && <div>{errorC}</div>}
				{products && (

					<div class="container-fluid">
						<div class="d-flex justify-content-start align-items-center">
							<div class="col-md-8 col-lg-8 col-xl-6">
								<div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
									<p class="lead fw-normal mt-2 mb-4 display-4">New Invoice</p>
								</div>
								<form onSubmit={handleSubmit}>
									<div class="row mb-2">
										<div class="col-12">
											<span style={{ marginLeft: "5px" }} className="h5">Customer</span>
											<Select onChange={(e) => setCustomerPhone(e.value)} options={optionsCustomers} />
										</div>
									</div>

									{showCustomersDetails(customer)}

									<div class="row mb-2">
										<div class="col-12">
											<span style={{ marginLeft: "5px" }} className="h5">Product</span>
											<Select onChange={(e) => setProductName(e.value)} options={optionsProduct} />
										</div>
									</div>

									{showProductDetails(product)}

									<div class="row mb-5">

										<div class="col-12 col-sm-3">
											<span style={{ marginLeft: "5px" }} className="h6">Quentity</span>
											<input type="number" min="1" class="form-control"
												placeholder="e.g. 3" required value={quentity} onChange={(e) => setQuentity(e.target.value)} />
										</div>

										<div class="col-12 col-sm-4">
											<span style={{ marginLeft: "5px" }} className="h6">VAT rate %</span>
											<input type="number" min="0" max="100" step="0.1" class="form-control"
												placeholder="e.g. 23,0" required value={vat} onChange={(e) => setVat(e.target.value)} />
										</div>

										<div class="col-12 col-sm-5">
											<span style={{ marginLeft: "5px" }} className="h6">Gross</span>
											<input type="number" min="0" step="0.01" class="form-control"
												placeholder="e.g. 123,45" required value={gross} onChange={(e) => setGross(e.target.value)} />
										</div>
									</div>

									<div required className="mb-3 col-12">
										<p style={{ marginLeft: "5px" }}>Date of delivery/performance</p>
										<LocalizationProvider dateAdapter={AdapterDateFns}>
											<DateTimePicker clearable ampm={false} renderInput={(params) => (<TextField {...params} helperText="" />)}
												value={performanceDate} onChange={(newDate) => { setPerformanceDate(newDate); }} />
										</LocalizationProvider>
									</div>

									<div className="mb-3 col-12">
										<p style={{ marginLeft: "5px" }}>Date of issue</p>
										<LocalizationProvider dateAdapter={AdapterDateFns}>
											<DateTimePicker clearable ampm={false} renderInput={(params) => (<TextField {...params} helperText="" />)}
												value={issueDate} onChange={(newValue) => { setIssueDate(newValue); }} />
										</LocalizationProvider>
									</div>

									<div class="col-12 col-sm-6">
										<span style={{ marginLeft: "5px" }}>Payment deadline</span>
										<input type="number" min="1" class="form-control"
											placeholder="How many months?" required value={months} onChange={(e) => setMonths(e.target.value)} />
									</div>

									<div class="mb-3 mt-3 ms-3">
										{!isPendingN && <button class="btn btn-primary rounded-pill btn-lg">Add Invoice</button>}
										{isPendingN && <button class="btn btn-primary rounded-pill btn-lg" disabled>Adding invoice...</button>}
									</div>

								</form>
							</div>
						</div>
					</div>)}
			</div>

		</>


	);
}

export default InvoiceCreate;
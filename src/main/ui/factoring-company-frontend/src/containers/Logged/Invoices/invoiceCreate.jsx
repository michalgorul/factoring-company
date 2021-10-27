import { useState } from 'react';
import useFetch from '../../../components/useFetch/useFetch';
import TextField from '@material-ui/core/TextField';
import AdapterDateFns from '@material-ui/lab/AdapterDateFns';
import LocalizationProvider from '@material-ui/lab/LocalizationProvider';
import DateTimePicker from '@material-ui/lab/DateTimePicker';
import CreatableSelect from 'react-select/creatable';
import { Form, Row, Col } from 'react-bootstrap';
import { Spinner } from 'react-bootstrap';
import FloatingLabel from "react-bootstrap-floating-label";
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Zoom } from 'react-toastify';
toast.configure();


const InvoiceCreate = () => {
	const [performanceDate, setPerformanceDate] = useState(new Date());
	const [issueDate, setIssueDate] = useState(new Date());
	const [firstName, setFirstName] = useState('');
	const [lastName, setLastName] = useState('');
	const [city, setCity] = useState('');
	const [street, setStreet] = useState('');
	const [postalCode, setPostalCode] = useState('');
	const [product, setProduct] = useState('');
	const [pkwiu, setPkwiu] = useState('');
	const [quentity, setQuentity] = useState('');
	const [measureUnit, setMeasureUnit] = useState('');
	const [gross, setGross] = useState('');
	const [vat, setVat] = useState('');
	const [months, setMonths] = useState('');
	const [isPendingN, setIsPending] = useState(false);
	// const history = useHistory();
	const { data: products, error, isPending } = useFetch('http://localhost:8000/product');


	const handleSubmit = (e) => {
		e.preventDefault();

		if (!firstName || !lastName || !street || !city || !postalCode || !product || !pkwiu
			|| !measureUnit || !vat || !performanceDate || !issueDate) {
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
			const buyer = { performanceDate, issueDate, firstName, lastName, city, street, postalCode, product, pkwiu, quentity, measureUnit, gross, vat, months };

			console.log(buyer);
		}
	}

	const makeProductOptions = (products) => {
		let productArray = [];

		if (products) {
			products.forEach((item) => {
				let it = {
					value: item.product.toString(),
					label: item.product.toString(),
				};
				productArray.push(it);
			})
		}
		return productArray;
	}

	const makePkwiuOptions = (products) => {
		let productArray = [];

		if (products) {
			products.forEach((item) => {
				let it = {
					value: item.pkwiu.toString(),
					label: item.pkwiu.toString(),
				};
				productArray.push(it);
			})
		}
		const key = 'value';
		const arrayUniqueByKey = [...new Map(productArray.map(item =>
			[item[key], item])).values()];

		return arrayUniqueByKey;
		return productArray;
	}

	const makeMeasureUnitOptions = (products) => {
		let productArray = [];

		if (products) {
			products.forEach((item) => {
				let it = {
					value: item.measureUnit.toString(),
					label: item.measureUnit.toString(),
				};
				productArray.push(it);
			})
		}
		const key = 'value';
		const arrayUniqueByKey = [...new Map(productArray.map(item =>
			[item[key], item])).values()];

		return arrayUniqueByKey;
	}

	const optionsProduct = makeProductOptions(products);

	const optionsPkwiu = makePkwiuOptions(products);

	const optionsMeasureUnit = makeMeasureUnitOptions(products);

	const optionsVat = [
		{ value: '18', label: '18' },
		{ value: '23', label: '23' }
	];

	return (

		<>
			<div>
				{isPending && isPendingN && <div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
				{error && <div>{error}</div>}
				{products && (

					<div class="container-fluid">
						<div class="d-flex justify-content-start align-items-center">
							<div class="col-md-8 col-lg-8 col-xl-6">
								<div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
									<p class="lead fw-normal mt-2 mb-3 display-4">New Invoice</p>
								</div>
								<form onSubmit={handleSubmit}>
									<Form className="mb-4">
										<span style={{ marginLeft: "5px" }}>Buyer:</span>
										<Row className="align-items-center">
											<Col sm={6} className="my-1">
												<FloatingLabel onChange={(e) => setFirstName(e.target.value)} controlId="floatingInput" label="First Name" className="mb-1">
													<Form.Control />
												</FloatingLabel>
											</Col>
											<Col sm={6} className="my-1">
												<FloatingLabel onChange={(e) => setLastName(e.target.value)} controlId="floatingInput" label="Last Name" className="mb-1">
													<Form.Control id="inlineFormInputName" placeholder="Jane Doe" />
												</FloatingLabel>
											</Col>
										</Row>
										<Row className="align-items-center">
											<Col sm={5} className="my-1">
												<FloatingLabel onChange={(e) => setStreet(e.target.value)} controlId="floatingInput" label="Street" className="mb-3">
													<Form.Control id="inlineFormInputName" placeholder="Jane Doe" />
												</FloatingLabel>
											</Col>
											<Col sm={4} className="my-1">
												<FloatingLabel onChange={(e) => setCity(e.target.value)} controlId="floatingInput" label="City" className="mb-3">
													<Form.Control id="inlineFormInputName" placeholder="Jane Doe" />
												</FloatingLabel>
											</Col>
											<Col sm={3} className="my-1">
												<FloatingLabel onChange={(e) => setPostalCode(e.target.value)} controlId="floatingInput" label="Postal code" className="mb-3">
													<Form.Control id="inlineFormInputName" placeholder="Jane Doe" />
												</FloatingLabel>
											</Col>
										</Row>
									</Form>

									<div class="row mb-5">
										<div class="col-12 col-sm-6 mb-2">
											<span style={{ marginLeft: "5px" }}>Product</span>
											<CreatableSelect onChange={(e) => setProduct(e.label)} options={optionsProduct} />
										</div>
										<div class="col-12 col-sm-6 mb-2">
											<span style={{ marginLeft: "5px" }}>PKWIU</span>
											<CreatableSelect onChange={(e) => setPkwiu(e.label)} options={optionsPkwiu} />
										</div>
										<div class="col-12 col-sm-6">
											<span style={{ marginLeft: "5px" }}>Quentity</span>
											<input type="number" min="1" class="form-control"
												placeholder="e.g. 3" required value={quentity} onChange={(e) => setQuentity(e.target.value)} />
										</div>
										<div class="col-12 col-sm-6 mb-2">
											<span style={{ marginLeft: "5px" }}>Measure unit</span>
											<CreatableSelect onChange={(e) => setMeasureUnit(e.label)} options={optionsMeasureUnit} />
										</div>
										<div class="col-12 col-sm-6">
											<span style={{ marginLeft: "5px" }}>VAT rate</span>
											<CreatableSelect onChange={(e) => setVat(e.label)} options={optionsVat} />
										</div>

										<div class="col-12 col-sm-6">
											<span style={{ marginLeft: "5px" }}>Gross</span>
											<input type="number" min="0" step="0.01" class="form-control"
												placeholder="e.g. 123.45" required value={gross} onChange={(e) => setGross(e.target.value)} />
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
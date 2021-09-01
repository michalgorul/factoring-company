import ProgressBar from 'react-bootstrap/ProgressBar';
import React, { useState } from 'react';
import RangeSlider from 'react-bootstrap-range-slider';
import { Nav } from 'react-bootstrap';
import { Marginer } from '../../../components/marginer';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Zoom } from 'react-toastify';
import CreditList from './creditList';
toast.configure();

const Credit = () => {

	const [ value, setValue ] = useState(0); 
	const [ availableCredit, setAvailableCredit ] = useState(250000); 
	const [ usedCredit, setUsedCredit ] = useState(50000); 
	const [ percentage, setPercentage ] = useState(usedCredit / availableCredit * 100); 
	const [ whatCredits, setWhatCredits ] = useState('active');
	const handleSelect = (eventKey) => setWhatCredits(eventKey);

	const drawFunds = () => {
		setAvailableCredit(250000);
		let x = usedCredit + parseInt(value);
		if(x <= availableCredit){
			setUsedCredit(x);
			setPercentage(x / availableCredit * 100);
			setValue(0);
		}
		else{
			toast.error('You cannot draw funds', {
				position: "bottom-right",
				autoClose: 5000,
				hideProgressBar: false,
				closeOnClick: true,
				pauseOnHover: true,
				draggable: true,
				progress: undefined,
				transition: Zoom,
				});
		}		
	}

    return ( 
			<>
			<div className="bg-light me-3">
				<div className="container">
					<div className="col-12 col-lg-6">
						<div className="mb-1 mt-3" >
							<span className="display-4 fw-bold mb-2">${usedCredit}</span> of <span className="display-5">${availableCredit}</span>
							<p class="fs-5 ms-2">Your available credit</p>
						</div>
          	<ProgressBar now={percentage} animated style={{height:"5px"}} />
						<Marginer direction="vertical" margin={20} />
					</div>
				</div>
			</div>

			<div className="container mt-5">
				<div className="row">
					<div className="col-12 col-lg-6">
						<div className="mb-3 mt-1" >
							<span class="fs-5 ms-2 pe-3">How much do you want to draw?</span>					
							<RangeSlider min={0} max={availableCredit - usedCredit} size="lg" step="100" value={value} onChange={changeEvent => setValue(changeEvent.target.value)}/>
						</div>
						<Marginer direction="vertical" margin={12} />
					</div>
					<div className="col-12 col-lg-6 align-items-center align-middle">
						<buttton className="btn btn-primary rounded-pill btn-lg float-end" onClick={drawFunds}>Draw funds</buttton>
					</div>
				</div>
				
			</div>
			<hr class="me-3 mt-4 mb-4"/>

			<div className="container mt-5">
				<div className="row">
					<div className="col-12 col-lg-6 mb-3">
						<Nav variant="tabs" defaultActiveKey="active" onSelect={handleSelect} className="fs-5">
							<Nav.Item>
								<Nav.Link eventKey="active">Active</Nav.Link>
							</Nav.Item>
							<Nav.Item>
								<Nav.Link eventKey="processing">Processing</Nav.Link>
							</Nav.Item>
							<Nav.Item>
								<Nav.Link eventKey="review">In review</Nav.Link>
							</Nav.Item>
							<Nav.Item>
								<Nav.Link eventKey="funded">Funded</Nav.Link>
							</Nav.Item>
						</Nav>
					</div>
				</div>
			</div>
      <Marginer direction="vertical" margin={35} />
	  <CreditList className="pe-4 me-5 mt-5" whatCredits={whatCredits}/>

        


</>
     );
}
 
export default Credit;
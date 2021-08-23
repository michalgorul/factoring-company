import ProgressBar from 'react-bootstrap/ProgressBar'
import React, { useState } from 'react';
import { Nav } from 'react-bootstrap';
import { Marginer } from '../../../components/marginer';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Zoom } from 'react-toastify';
import InvoiceList from './invoiceList';
toast.configure();

const Invoices = () => {

	const [ availableCredit, setAvailableCredit ] = useState(5000000); 
	const [ usedCredit, setUsedCredit ] = useState(500000); 
	const [ percentage, setPercentage ] = useState(usedCredit / availableCredit * 100); 
  const [ whatInvoices, setWhatInvoices ] = useState('active');
  const handleSelect = (eventKey) => setWhatInvoices(eventKey);
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
          <div className="col-12 col-lg-6 mb-3">
          <Nav variant="tabs" defaultActiveKey="active" onSelect={handleSelect} className="fs-5">
            <Nav.Item>
              <Nav.Link eventKey="active">In process</Nav.Link>
            </Nav.Item>
            <Nav.Item>
              <Nav.Link eventKey="unfunded">Unfunded</Nav.Link>
            </Nav.Item>
            <Nav.Item>
              <Nav.Link eventKey="funded">Funded</Nav.Link>
            </Nav.Item>
          </Nav>
          </div>
          <div className="col-12 col-lg-6 align-items-end justify-content-between">
            <button className="btn btn-lg btn-primary rounded-pill float-end">Add new invoice</button>
          </div>
        </div>
			</div>
      <Marginer direction="vertical" margin={35} />
				<InvoiceList className="pe-4 me-5 mt-5" whatInvoices={whatInvoices}/>



        


</>
     );
}
 
export default Invoices;
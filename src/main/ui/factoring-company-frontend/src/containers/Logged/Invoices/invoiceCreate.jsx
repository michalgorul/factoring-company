import {useState} from 'react';
import TextField from '@material-ui/core/TextField';
import AdapterDateFns from '@material-ui/lab/AdapterDateFns';
import LocalizationProvider from '@material-ui/lab/LocalizationProvider';
import DateTimePicker from '@material-ui/lab/DateTimePicker';

const InvoiceCreate = () => {
    const [creationDate, setCreationDate] = useState(new Date());
    const [saleDate, setSaleDate] = useState(new Date());
    const [paymentDeadline, setPaymentDeadline] = useState(new Date());

    return ( 

			<>

        <div class="container-fluid h-custom">
            <div class="row d-flex justify-content-start align-items-center">
                <div class="col-md-8 col-lg-8 col-xl-6">
                    <form>
                    <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
                        <p class="lead fw-normal mt-2 mb-3 display-4">New Invoice</p>
                    </div>

                    <div class="form-outline form-floating mb-3">
                        <input type="text" class="form-control form-control-lg"
                        placeholder="Enter a valid email address" required />
                        <label class="form-label">First name</label>
                    </div>


                    <div required className="mb-3">
											<LocalizationProvider dateAdapter={AdapterDateFns}>
												<DateTimePicker clearable ampm={false} renderInput={(params) => (<TextField {...params} helperText="Creation date" />)} 
													value={creationDate} onChange={(newDate) => { setCreationDate(newDate); }}/>
											</LocalizationProvider>
                    </div>

										<div className="mb-3">
											<LocalizationProvider dateAdapter={AdapterDateFns}>
												<DateTimePicker clearable ampm={false} renderInput={(params) => (<TextField {...params} helperText="Sale date" />)} 
													value={saleDate} onChange={(newValue) => { setSaleDate(newValue); }}/>
											</LocalizationProvider>
                    </div>

										<div className="mb-3">
											<LocalizationProvider dateAdapter={AdapterDateFns}>
												<DateTimePicker clearable ampm={false} renderInput={(params) => (<TextField {...params} helperText="Payment Deadline" />)} 
													value={paymentDeadline} onChange={(newValue) => { setPaymentDeadline(newValue); }}/>
											</LocalizationProvider>
                    </div>
                    
                        
                    </form>
                </div>
            </div>
        </div>
</>
            
        
     );
}
 
export default InvoiceCreate;
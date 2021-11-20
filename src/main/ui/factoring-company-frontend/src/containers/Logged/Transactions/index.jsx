import React, {useState} from "react";
import TransactionList from "./transactionList";
import Select from "react-select";
import LocalizationProvider from '@material-ui/lab/LocalizationProvider';
import DatePicker from '@material-ui/lab/DatePicker';
import AdapterDateFns from "@material-ui/lab/AdapterDateFns";
import TextField from "@material-ui/core/TextField";
import {Collapse} from 'react-collapse';
import {Button, Modal} from "react-bootstrap";

const Transactions = () => {

    const [whatTransactions, setWhatTransactions] = useState('credit');
    const [sortOption, setSortOption] = useState('credit');
    const [startDate, setStartDate] = useState(null);
    const [endDate, setEndDate] = useState(null);
    const [show, setShow] = useState(false)

    const handleWhatTransactionsChange = (changeEvent) => {
        setWhatTransactions(changeEvent.target.value)
    }

    const displayWhatTransactions = () => {
        if (whatTransactions === 'credit') {
            return (
                <TransactionList whatTransactions={'credit'} sortOption={sortOption} startDate={startDate} endDate={endDate}/>)
        }
        return (<TransactionList whatTransactions={'invoice'} sortOption={sortOption} startDate={startDate} endDate={endDate}/>)
    }

    const handleShowDates = () => setShow(true);
    const handleClose = () => setShow(false);

    const sortOptions = [
        {value: 'idDesc', label: 'ID 🠕'},
        {value: 'dateDesc', label: 'Date 🠕'},
        {value: 'nameDesc', label: 'Name 🠕'},
        {value: 'amountDesc', label: 'Amount 🠕'},
        {value: 'benefitDesc', label: 'Benefit 🠕'},
        {value: 'idAsc', label: 'ID 🠗'},
        {value: 'dateAsc', label: 'Date 🠗'},
        {value: 'nameAsc', label: 'Name 🠗'},
        {value: 'amountAsc', label: 'Amount 🠗'},
        {value: 'benefitAsc', label: 'Benefit 🠗'},
    ]

    return (
        <>
            <div className="media align-items-center py-3">
                <div className="media-body ml-4">
                    <h4 className="font-weight-bold display-2">Transactions</h4>
                </div>
            </div>

            <div className="container mt-5 mb-4 h4">
                <div className="row align-items-start ms-1">
                    <div className="col-6 col-lg-3">
                        <div className="form-check">
                            <input className="form-check-input" type="radio" name="payOption" value="credit"
                                   checked={whatTransactions === 'credit'} onChange={handleWhatTransactionsChange}/>
                            <label className="form-check-label">Credits</label>
                        </div>
                    </div>
                    <div className="col-6 col-lg-3">
                        <div className="form-check">
                            <input className="form-check-input" type="radio" name="payOption" value="invoice"
                                   checked={whatTransactions === 'invoice'} onChange={handleWhatTransactionsChange}/>
                            <label className="form-check-label">Invoices</label>
                        </div>
                    </div>
                </div>
            </div>

            <div className="container-sm ">
                <div className="row align-content-center justify-content-end mb-4">
                    <div className="col-4 col-xl-2">
                        Sort by: <Select onChange={(e) => setSortOption(e.value)} options={sortOptions}/>
                    </div>
                    <div className="col-4 col-xl-2 ms-1 pt-3 mt-2">
                        <button className="btn btn-primary rounded-pill" onClick={handleShowDates}>Select dates</button>
                    </div>
                </div>
            </div>

            {displayWhatTransactions()}


            <Modal show={show} onHide={handleClose}>
                <Modal.Header closeButton>
                    <Modal.Title>Dates Selection</Modal.Title>
                </Modal.Header>
                <Modal.Body className={"text-center"}>
                    <div className="mb-2 fs-5">Start date:</div>
                    <LocalizationProvider dateAdapter={AdapterDateFns}>
                        <DatePicker clearable ampm={false}
                                    renderInput={(params) => (<TextField {...params} helperText=""/>)}
                                    value={startDate} onChange={(newDate) => {
                            setStartDate(newDate);
                        }}/>
                    </LocalizationProvider>

                    <div className="mb-2 mt-4 fs-5">End date:</div>
                    <LocalizationProvider dateAdapter={AdapterDateFns}>
                        <DatePicker clearable ampm={false} className={"mb-4"}
                                    renderInput={(params) => (<TextField {...params} helperText=""/>)}
                                    value={endDate} onChange={(newDate) => {
                            setEndDate(newDate);
                        }}/>
                    </LocalizationProvider>
                    <div className="row justify-content-center">
                        <div className="col-6 mt-4 mb-2">
                            <Button className={"btn btn-lg rounded-pill btn-block"} onClick={handleClose}>Close</Button>

                        </div>
                    </div>


                </Modal.Body>
            </Modal>
        </>

    );
}

export default Transactions;
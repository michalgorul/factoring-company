import React, {useState} from "react";
import TransactionList from "./transactionList";
import Select from "react-select";

const Transactions = () => {

    const [whatTransactions, setWhatTransactions] = useState('credit');
    const [sortOption, setSortOption] = useState('credit');

    const handleWhatTransactionsChange = (changeEvent) => {
        setWhatTransactions(changeEvent.target.value)
    }

    const displayWhatTransactions = () => {
        if (whatTransactions === 'credit') {
            return (<TransactionList whatTransactions={'credit'} sortOption={sortOption}/>)
        }
        return (<TransactionList whatTransactions={'invoice'} sortOption={sortOption}/>)
    }

    const sortOptions = [
        { value: 'idDesc', label: 'ID 🠕' },
        { value: 'dateDesc', label: 'Date 🠕' },
        { value: 'nameDesc', label: 'Name 🠕' },
        { value: 'amountDesc', label: 'Amount 🠕' },
        { value: 'benefitDesc', label: 'Benefit 🠕' },
        { value: 'idAsc', label: 'ID 🠗' },
        { value: 'dateAsc', label: 'Date 🠗' },
        { value: 'nameAsc', label: 'Name 🠗' },
        { value: 'amountAsc', label: 'Amount 🠗' },
        { value: 'benefitAsc', label: 'Benefit 🠗' },
    ]

return (
    <>
        <div className="media align-items-center py-3">
            <div className="media-body ml-4">
                <h4 className="font-weight-bold display-2">Transactions</h4>
            </div>
        </div>

        <div className="container-sm ">
            <div className="row justify-content-end me-3">
                <div className="col-4 col-xl-2">
                    Sort by: <Select onChange={(e) => setSortOption(e.value)} options={sortOptions}/>
                </div>
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

        {displayWhatTransactions()}
    </>

);
}

export default Transactions;
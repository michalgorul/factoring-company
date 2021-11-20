import useFetchWithToken from "../../../services/useFetchWithToken";
import config from "../../../services/config";
import Table from "react-bootstrap/Table";
import {Spinner} from "react-bootstrap";
import {
    compareBenefit,
    compareBenefitAsc,
    compareId,
    compareIdAsc,
    compareName,
    compareNameAsc,
    compareTransactionDate,
    compareTransactionDateAsc,
    compareValue,
    compareValueAsc
} from "../../../services/compare";
import React from "react";
import {ArrowDownShort, ArrowUpShort} from "react-bootstrap-icons";

const TransactionList = ({whatTransactions, sortOption}) => {
    const {error, isPending, data: transactions} = useFetchWithToken(`${config.API_URL}/api/transaction/${whatTransactions}`)

    const handleShowArrow = (creditTransaction) => {
        if (creditTransaction) {
            if (creditTransaction.benefit === true) {
                return (
                    <ArrowUpShort className="text-success"/>
                )
            }
            return <ArrowDownShort className="text-danger fs-5"/>
        }
    }

    const whatSorting = (sortOption) => {
        switch (sortOption) {
            case 'idDesc':
                return compareId;
            case 'nameDesc':
                return compareName;
            case 'benefitDesc':
                return compareBenefit;
            case 'amountDesc':
                return compareValue;
            case 'dateDesc':
                return compareTransactionDate;
            case 'idAsc':
                return compareIdAsc;
            case 'nameAsc':
                return compareNameAsc;
            case 'benefitAsc':
                return compareBenefitAsc;
            case 'amountAsc':
                return compareValueAsc;
            case 'dateAsc':
                return compareTransactionDateAsc;
            default:
                return compareId;
        }
    }

    return (
        <div>
            <Table striped borderless hover responsive>
                <caption>Transactions List</caption>
                <thead>
                <tr>
                    <th>#</th>
                    <th>Date</th>
                    <th>Name</th>
                    <th className="text-center">Amount</th>
                    <th className="text-center">Benefit</th>
                </tr>
                </thead>
                <tbody>
                {error && <>
                    <div className="alert alert-warning fs-3" role="alert">{error} </div>
                    <button className="text-decoration-none ms-3 fs-3" onClick={() => {
                        window.location.href = "/something"
                    }}> Click to refresh
                    </button>
                </>}
                {isPending &&
                <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary"/></div>}
                {transactions && transactions
                    .sort(whatSorting(sortOption))
                    .map(transaction => (
                        <tr key={transaction.id} className="clickable">
                            <th>
                                <a href={'/user/transactions/' + transaction.id}
                                   className="text-decoration-none text-dark d-block">{transaction.id}
                                </a>
                            </th>
                            <td>
                                <a href={'/user/transactions/' + transaction.id} className="text-decoration-none text-dark d-block">
                                    {new Date(transaction.transactionDate).toDateString()}
                                </a>
                            </td>
                            <td>
                                <a href={'/user/transactions/' + transaction.id}
                                   className="text-decoration-none text-dark d-block">
                                    {transaction.name}
                                </a>
                            </td>
                            <td>
                                <a href={'/user/transactions/' + transaction.id} className="text-center text-decoration-none text-dark d-block">
                                    {transaction.value.toFixed(2)}
                                </a>
                            </td>
                            <td>
                                <a href={'/user/transactions/' + transaction.id} className=" text-center text-decoration-none text-dark d-block">
                                    {handleShowArrow(transaction)}
                                </a>
                            </td>
                        </tr>

                    ))}
                </tbody>
            </Table>
            {whatSorting(sortOption)}
        </div>
    );
}

export default TransactionList;
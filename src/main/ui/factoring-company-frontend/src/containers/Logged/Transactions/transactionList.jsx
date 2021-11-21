import useFetchWithToken from "../../../services/useFetchWithToken";
import config from "../../../services/config";
import Table from "react-bootstrap/Table";
import {Spinner} from "react-bootstrap";
import React from "react";
import {handleFilterTransactionsDates, handleShowArrow, whatSorting} from "../../../services/historyService";

const TransactionList = ({whatTransactions, sortOption, startDate, endDate}) => {
    const {error, isPending, data: transactions} = useFetchWithToken(`${config.API_URL}/api/transaction/${whatTransactions}`)

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
                    .filter(transaction => handleFilterTransactionsDates(transaction, startDate, endDate))
                    .map(transaction => (
                        <tr key={transaction.id} className="clickable">
                            <th>
                                {transaction.id}
                            </th>
                            <td>
                                {new Date(transaction.transactionDate).toDateString()}
                            </td>
                            <td>
                                {transaction.name}
                            </td>
                            <td className="text-center">
                                {transaction.value.toFixed(2)}
                            </td>
                            <td className="text-center">
                                {handleShowArrow(transaction)}
                            </td>
                        </tr>

                    ))}
                </tbody>
            </Table>
        </div>
    );
}

export default TransactionList;
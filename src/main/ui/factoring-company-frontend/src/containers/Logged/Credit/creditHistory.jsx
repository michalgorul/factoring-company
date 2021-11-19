import {useParams} from "react-router-dom";
import useFetchWithToken from "../../../services/useFetchWithToken";
import config from "../../../services/config";
import {Marginer} from "../../../components/marginer";
import Table from "react-bootstrap/Table";
import {Spinner} from "react-bootstrap";
import {compareId} from "../../../services/compare";
import React from "react";
import {ArrowDownShort, ArrowUpShort} from "react-bootstrap-icons";

const CreditHistory = () => {
    const {id} = useParams();

    const {error, isPending, data: creditTransactions} = useFetchWithToken(`${config.API_URL}/api/transaction/credit/${id}`)

    const handleShowArrow = (creditTransaction) => {
      if(creditTransaction){
          if(creditTransaction.benefit === true){
              return(
                  <ArrowUpShort className="text-success" />
              )
          }
          return <ArrowDownShort className="text-danger fs-5" />
      }
    }
    return (
        <>
            <div className="media align-items-center py-3">
                <div className="media-body ml-4">
                    <h4 className="font-weight-bold display-2">Credit History</h4>
                </div>
            </div>
            <Marginer direction="vertical" margin={35}/>
            <Table striped borderless hover responsive>
                <caption>History of credit</caption>
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
                {creditTransactions && creditTransactions
                    .sort(compareId)
                    .map(creditTransaction => (
                        <tr key={creditTransaction.id} className="clickable" onClick="#">
                            <th>{creditTransaction.id}</th>
                            <td>{new Date(creditTransaction.transactionDate).toDateString()}</td>
                            <td>{creditTransaction.name}</td>
                            <td className="text-center">
                                {creditTransaction.value.toFixed(2)}
                            </td>
                            <td className="text-center">
                                {handleShowArrow(creditTransaction)}
                            </td>
                        </tr>
                    ))}
                </tbody>
            </Table>
        </>

    )
}

export default CreditHistory;
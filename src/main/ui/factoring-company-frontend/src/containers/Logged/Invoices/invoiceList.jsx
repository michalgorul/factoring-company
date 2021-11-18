import Table from 'react-bootstrap/Table'
import {Spinner} from 'react-bootstrap';
import useFetchWithToken from '../../../services/useFetchWithToken';
import config from '../../../services/config';
import {compareId} from "../../../services/compare";

const InvoiceList = ({whatInvoices}) => {
    const {error, isPending, data: invoices} = useFetchWithToken(`${config.API_URL}/api/invoice/current`);

    return (
        <Table striped borderless hover>
            <caption>List of {whatInvoices} invoices</caption>
            <thead>
            <tr>
                <th>#</th>
                <th>Invoice</th>
                <th>Invoice Date</th>
                <th>Due Date</th>
                <th>Invoice Amount</th>
                <th>Paid</th>
            </tr>
            </thead>
            <tbody>
            {error && <>
                <div className="alert alert-warning fs-3" role="alert">{error} </div>
                <button className="text-decoration-none ms-3 fs-3" onClick={() => {
                    window.location.href = "/something"
                }}> Click to refresh </button></>}
            {isPending &&
            <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary"/></div>}
            {invoices && invoices
                .filter(invoice => invoice.status === whatInvoices)
                .sort(compareId)
                .map(invoice => (
                    <tr key={invoice.id} className="clickable">
                        <th>{invoice.id}</th>
                        <td><a href={"/user/invoices/" + invoice.id} className="text-decoration-none">{invoice.invoiceNumber}</a>
                        </td>
                        <td>{new Date(invoice.creationDate).toDateString()}</td>
                        <td>{new Date(invoice.paymentDeadline).toDateString()}</td>
                        <td>{Number(invoice.toPay).toFixed(2)}</td>
                        <td>{Number(invoice.paid).toFixed(2)}</td>
                    </tr>
                ))}
            </tbody>
        </Table>
    );
}

export default InvoiceList;
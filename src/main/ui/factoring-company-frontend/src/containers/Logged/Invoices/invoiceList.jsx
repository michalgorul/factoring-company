import Table from 'react-bootstrap/Table'
import {Spinner} from 'react-bootstrap';
import useFetchWithToken from '../../../services/useFetchWithToken';
import config from '../../../services/config';

const InvoiceList = ({whatInvoices}) => {
    const {error, isPending, data: invoices} = useFetchWithToken(`${config.API_URL}/api/invoice/current`);

    function compare(a, b) {
        if (a.id < b.id) {
            return -1;
        }
        if (a.id > b.id) {
            return 1;
        }
        return 0;
    }

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
                .sort(compare)
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
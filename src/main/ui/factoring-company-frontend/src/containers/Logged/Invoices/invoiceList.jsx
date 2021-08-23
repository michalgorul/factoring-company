import Table from 'react-bootstrap/Table'
import useFetch from "../../../components/useFetch/useFetch";
import { Spinner } from 'react-bootstrap';


const InvoiceList = ({whatInvoices}) => {
    const { error, isPending, data: invoices } = useFetch('http://localhost:8000/invoices-'+ whatInvoices)

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
            { error &&<> <div class="alert alert-warning fs-3" role="alert">{error} </div> 
                            <a class="text-decoration-none ms-3 fs-3" href="" onClick={() => {window.location.href="/something"}}> Click to refresh </a></>}
            { isPending && <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary" /></div> }
            { invoices && invoices.map(invoice => (
                    <tr key={invoice.id} className="clickable" onclick="#">
                        <th>{invoice.id}</th>
                        <td><a href="#" className="text-decoration-none">{invoice.invoiceNumber}</a></td>
                        <td>{invoice.creationDate}</td>
                        <td>{invoice.paymentDeadline}</td>
                        <td>{invoice.toPay}</td>
                        <td>{invoice.paid}</td>
                    </tr>
            ))}
            </tbody>
        </Table>
     );
}
 
export default InvoiceList;
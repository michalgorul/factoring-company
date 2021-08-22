import Table from 'react-bootstrap/Table'
import useFetch from "../../../components/useFetch/useFetch";


const InvoiceList = () => {
    const { error, isPending, data: invoices } = useFetch('http://localhost:8000/invoices')

    return ( 
        <Table striped borderless hover>
            <thead>
                <tr>
                <th>Invoice</th>
                <th>Invoice Date</th>
                <th>Due Date</th>
                <th>Invoice Amount</th>
                <th>Paid</th>
                </tr>
            </thead>
            <tbody>
            { error && <div>{ error }</div> }
            { isPending && <div>Loading...</div> }
            { invoices && invoices.map(invoice => (
                    <tr key={invoice.id} className="clickable" onclick="#">
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
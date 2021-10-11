import Table from 'react-bootstrap/Table'
import useFetch from "../../../components/useFetch/useFetch";
import { Spinner } from 'react-bootstrap';
import useFetchWithToken from '../../../services/useFetchWithToken';
import config from '../../../services/config';

const CreditList = ({whatCredits}) => {
    const { error, isPending, data: credits } = useFetchWithToken(`${config.API_URL}/api/credit/current`)

    return ( 
        <Table striped borderless hover>
            <caption>List of {whatCredits} credits</caption>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Draw</th>
                    <th>Draw Date</th>
                    <th>Amount</th>
                    <th>Next Payment</th>
                    <th>Balance</th>
                </tr>
            </thead>
            <tbody>
            { error &&<> <div class="alert alert-warning fs-3" role="alert">{error} </div> 
                            <button class="text-decoration-none ms-3 fs-3" href="#" onClick={() => {window.location.href="/something"}}> Click to refresh </button></>}
            { isPending && <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary" /></div> }
            { credits && credits
            .filter(credit => credit.status == whatCredits)
            .map(credit => (
                    <tr key={credit.id} className="clickable" onclick="#">
                        <th>{credit.id}</th>
                        <td><a href={"/user/credit/" + credit.id} className="text-decoration-none">{credit.creditNumber}</a></td>
                        <td>{credit.creationDate}</td>
                        <td>{credit.amount}</td>
                        <td>{credit.nextPayment}</td>
                        <td>{credit.balance}</td>
                    </tr>
            ))}
            </tbody>
        </Table>
     );
}
 
export default CreditList;
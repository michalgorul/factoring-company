import Table from 'react-bootstrap/Table'
import {Spinner} from 'react-bootstrap';
import useFetchWithToken from '../../../services/useFetchWithToken';
import config from '../../../services/config';

const CreditList = ({whatCredits}) => {
    const {error, isPending, data: credits} = useFetchWithToken(`${config.API_URL}/api/credit/current`)

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
        <Table striped borderless hover responsive>
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
            {error && <>
                <div className="alert alert-warning fs-3" role="alert">{error} </div>
                <button className="text-decoration-none ms-3 fs-3" onClick={() => {
                    window.location.href = "/something"
                }}> Click to refresh
                </button>
            </>}
            {isPending &&
            <div style={{padding: "70px 0", textAlign: "center"}}><Spinner animation="grow" variant="primary"/></div>}
            {credits && credits
                .filter(credit => credit.status === whatCredits)
                .sort(compare)
                .map(credit => (
                    <tr key={credit.id} className="clickable" onClick="#">
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
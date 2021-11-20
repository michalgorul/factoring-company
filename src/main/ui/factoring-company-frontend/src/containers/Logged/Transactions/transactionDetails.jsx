import {useParams} from "react-router-dom";

const TransactionDetails = () => {
    const {id} = useParams();
    return(
        <div>details {id}</div>
    )

}

export default TransactionDetails;
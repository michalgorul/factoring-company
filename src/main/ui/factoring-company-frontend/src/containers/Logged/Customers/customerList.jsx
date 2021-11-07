const CustomerList = ({customers}) => {
    return ( 
        <div className="customer-list">
        {customers.map(customer => (
            <li key={customer.id} class="list-group-item list-group-item list-group-item-action d-flex align-items-start">
            <div class="ms-2 me-auto fs-5">
            <div class="fw-bold">
                <a href={'/user/customers/'+ customer.id} class="text-decoration-none stretched-link">{customer.firstName + ' ' + customer.lastName}</a>    
            </div>
            {customer.companyName}
            </div>
        </li>
        ))}
     
        </div>


     );
}
 
export default CustomerList;
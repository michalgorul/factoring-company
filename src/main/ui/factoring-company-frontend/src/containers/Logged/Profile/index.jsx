
const Profile = () => {
    return ( 
        <div class="container flex-grow-1 container-p-y">

            <div class="media align-items-center py-3">
              <div class="media-body ml-4">
                <h4 class="font-weight-bold display-2">John Doe</h4>
              </div>
            </div>

            <div class="row my-5 align-items-center justify-content-center container-fluid shadow p-3 mb-5 rounded">
            <div class="col-9 col-lg-4">
                    <div class="card border-1">
                        <div class="card-body text-center py-4 flex-fill">
                            <h4 class="card-title">Invoices</h4>
                            <p class="card-text mx-5 text-muted fs-4">100</p>
                        </div>
                    </div>
                </div> 

                <div class="col-9 col-lg-4">
                    <div class="card border-1">
                        <div class="card-body text-center py-4 flex-fill">
                            <h4 class="card-title">Customers</h4>
                            <p class="card-text mx-5 text-muted fs-4">100</p>
                        </div>
                    </div>
                </div> 

                <div class="col-9 col-lg-4">
                    <div class="card border-1">
                        <div class="card-body text-center py-4 flex-fill">
                            <h4 class="card-title">Comission</h4>
                            <p class="card-text mx-5 text-muted fs-4">10000$</p>
                        </div>
                    </div>
                </div> 
            </div>

              <h5 class="mt-4 mb-3">General</h5>
              <div class="table-responsive">
              <table class="table table-hover">
                  <tbody>
                    <tr>
                      <th>Username:</th>
                      <td>nmaxwell</td>
                    </tr>
                    <tr>
                      <th>Name:</th>
                      <td>Nelle Maxwell</td>
                    </tr>
                    <tr>
                      <th>E-mail:</th>
                      <td>nmaxwell@mail.com</td>
                    </tr>
                    <tr>
                      <th>Company:</th>
                      <td>Company Ltd.</td>
                    </tr>
                  </tbody>
                </table>
              </div>
                

                <h5 class="mt-4 mb-3">Address</h5>

                <ul class="list-group list-group-flush">
                    <li class="list-group-item list-group-item-action">An item</li>
                    <li class="list-group-item list-group-item-action">A second item</li>
                    <li class="list-group-item list-group-item-action">A third item</li>
                    <li class="list-group-item list-group-item-action">A fourth item</li>
                    <li class="list-group-item list-group-item-action">And a fifth one</li>
                </ul>
                <table class="table table-hover me-2">
                  <tbody>
                    <tr>
                      <th>Country:</th>
                      <td>nmaxwell</td>
                    </tr>
                    <tr>
                      <th>City:</th>
                      <td>Nelle Maxwell</td>
                    </tr>
                    <tr>
                      <th>Street:</th>
                      <td>nmaxwell@mail.com</td>
                    </tr>
                    <tr>
                      <th>Postal code:</th>
                      <td>Company Ltd.</td>
                    </tr>
                  </tbody>
                </table>


              </div>

     );
    }
 
export default Profile;
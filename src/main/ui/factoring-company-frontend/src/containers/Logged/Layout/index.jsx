import Sidebar from "../Sidebar/sidebar";

const Layout = (props) => {
    return ( 
        <div>
            <div class="d-flex">

               <Sidebar />

                <div>
                    {props.children}
                </div>

            </div>
        </div>
     );
}
 
export default Layout;
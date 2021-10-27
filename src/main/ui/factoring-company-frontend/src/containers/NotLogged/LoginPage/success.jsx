import Card from 'react-bootstrap/Card'
import { BrandLogo } from "../../../components/brandLogo";
import { Marginer } from '../../../components/marginer'
const PasswordResetSuccess = () => {

    setTimeout(function () {
        window.location.replace('/login');
    }, 6000);

    return (
        <>
            <div class="jumbotron d-flex align-items-center min-vh-100">
                <div class="container">
                    <div class="row justify-content-md-center">
                        <div class="col col-lg-2">
                        </div>
                        <div class="col-md-auto">
                            <Card className="text-center">
                                <Card.Header className="bg-primary"><BrandLogo logoSize={120} textSize={35} className="d-none d-md-block" /></Card.Header>
                                <Card.Body>
                                    <Card.Title><span className="h2">Password was updated</span></Card.Title>
                                    <Card.Text>
                                        <span className="h4">
                                            You can login now with new password
                                        </span>
                                        <br />
                                        <span className="h6"><Marginer direction="vertical" margin={10} />
                                            If you need any help please contact our support
                                        </span>
                                    </Card.Text>
                                </Card.Body>
                            </Card>
                        </div>
                        <div class="col col-lg-2">
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}

export default PasswordResetSuccess;
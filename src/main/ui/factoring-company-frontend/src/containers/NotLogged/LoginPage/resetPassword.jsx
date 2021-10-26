import Form from 'react-bootstrap/Form'
import FloatingLabel from 'react-bootstrap/FloatingLabel'
import Card from 'react-bootstrap/Card'
import Button from 'react-bootstrap/Button'
import { useState } from 'react'
import { BrandLogo } from "../../../components/brandLogo";
const PasswordReset = () => {

    const [email, setEmail] = useState('');

    const handleSubmit = () => {
        setTimeout(() => {
            console.log(email);
        }, 5000)
    }

    return (
        <>
            <div class="jumbotron d-flex align-items-center min-vh-100">
                <div class="container">
                    <div class="row justify-content-md-center">
                        <div class="col col-lg-2">
                        </div>
                        <div class="col-md-auto">
                            <Card className="text-center">
                            <Card.Header className="bg-primary"><BrandLogo logoSize={120} textSize={35} className="d-none d-md-block"/></Card.Header>
                                <Card.Body>
                                    <Card.Title><span className="h2">Forgot your password?</span></Card.Title>
                                    <Card.Text>
                                        <span className="h5">
                                            We will send you a link to change your password.
                                        </span>
                                        <br />
                                        <span className="h5">
                                            If you still need support, please visit our help center.
                                        </span>
                                    </Card.Text>
                                    <form onSubmit={handleSubmit}>
                                    <Form.Label>Your profile email address</Form.Label>
                                    <FloatingLabel
                                        controlId="floatingInput"
                                        label="Email address"
                                        className="mb-3">
                                        <Form.Control type="email" placeholder="name@example.com"
                                        value={email} onChange={(e) => setEmail(e.target.value)} />
                                    </FloatingLabel>
                                    <Button type="submit" className="btn-lg rounded-pill">Reset password</Button>
                                    </form>
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

export default PasswordReset;
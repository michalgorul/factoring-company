import Table from 'react-bootstrap/Table'
import { Spinner } from 'react-bootstrap';
import useFetchWithToken from '../../../services/useFetchWithToken';
import config from '../../../services/config';
import { Download } from 'react-bootstrap-icons';
import { useEffect } from 'react';

const FileList = ({whatCatalog}) => {
    const { data: documents, error, isPending } = useFetchWithToken(`${config.API_URL}/api/file`)

    useEffect(() => {
        if (documents) {
            documents.forEach(document=>{
                document.size = document.size/1000 + ' KB';
            })
        }

    }, [documents]);

    return ( 
        <Table striped borderless hover>
        <caption>List of {whatCatalog} documents</caption>
        <thead>
            <tr>
                <th>Name</th>
                <th>Size</th>
                <th>Download</th>
            </tr>
        </thead>
        <tbody>
            {error && <> <div class="alert alert-warning fs-3" role="alert">{error} </div>
                <button class="text-decoration-none ms-3 fs-3" href="#" onClick={() => { window.location.href = "/something" }}> Click to refresh </button></>}
            {isPending && <div style={{ padding: "70px 0", textAlign: "center" }}><Spinner animation="grow" variant="primary" /></div>}
            {documents && documents
                .filter(document => document.catalog == whatCatalog)
                .map(document => (
                    <tr key={document.id} className="clickable" onclick="#">
                        <td><button type="button" class="btn btn-link text-decoration-none">{document.name}</button></td>
                        <td class="">{document.size}</td>
                        <td><button type="button" class="btn btn-link"><Download /></button></td>
                    </tr>
                ))}
        </tbody>
    </Table>
     );
}
 
export default FileList;
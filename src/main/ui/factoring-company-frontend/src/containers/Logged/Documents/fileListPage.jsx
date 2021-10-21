import { useParams } from "react-router";
import { Marginer } from "../../../components/marginer";
import FileList from "./fileList";

function capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

const FileListPage = () => {
  const { catalog } = useParams()
  let catalogName = capitalizeFirstLetter(catalog).replace('-', ' ') + ' documents';
  let catalogInDB = ''
  if (catalog == "factoring-company") {
    catalogInDB = 'fc';
  }
  else {
    catalogInDB = catalog;
  }

  return (
    <>
      <div class="media align-items-center py-3">
        <div class="media-body ml-4">
          <h4 class="font-weight-bold display-4">{catalogName}</h4>
        </div>
      </div>
      <Marginer direction="vertical" margin={35} />
      <FileList className="pe-4 me-5 mt-5" whatCatalog={catalogInDB} />
    </>
  );
}

export default FileListPage;
import { useParams } from "react-router";

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }

const FileListPage = () => {
    const { catalog } = useParams()
    let catalogName = capitalizeFirstLetter(catalog).replace('-', ' ') + ' documents';
    let catalogInDB = ''
    if(catalog == "factoring-company"){
      catalogInDB = 'fc';
    }
    else{
      catalogInDB = catalog;
    }

    return (
        <div class="media align-items-center py-3">
        <div class="media-body ml-4">
          <h4 class="font-weight-bold display-4">{catalogName}</h4>
        </div>
      </div>
    );
}

export default FileListPage;
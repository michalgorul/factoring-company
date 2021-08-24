import { Folder, FolderPlus, StarFill } from "react-bootstrap-icons"
import styled from "styled-components";


const Directory = styled.a`
  position: relative;
  display: inline-block;
  overflow: hidden;
  background: linear-gradient(to right, #0d6efd, #0d6efd 50%, black 50%);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-size: 200% 100%;
  background-position: 100%;
  transition: background-position 275ms ease;
  text-decoration: none; // text decorations are clipped in WebKit browsers
  &:hover {
    background-position: 0 100%;
  }
`

const Documents = () => {
    return ( 
        <>
        <div class="media align-items-center py-3">
        <div class="media-body ml-4">
          <h4 class="font-weight-bold display-2">Your documents</h4>
          <a href="#" class="btn btn-primary rounded-pill fs-4 float-end me-5">Add files + </a>
        </div>
      </div>

			<ul class="list-group list-group-flush me-4 fs-3 ms-3">
			<li class="list-group-item mt-3"><StarFill className="text-primary mb-4 me-3" /> 
					<Directory href="#">Favourite</Directory>
				</li>
				<li class="list-group-item mt-3"><Folder className="text-primary mb-4 me-3" /> 
					<Directory href="#">Work</Directory>
				</li>
				<li class="list-group-item mt-3"><Folder className="text-primary mb-4 me-3" /> 
					<Directory href="#">Bank documents</Directory>
				</li>
				<li class="list-group-item mt-3"><Folder className="text-primary mb-4 me-3" /> 
					<Directory href="#">Tax forms</Directory>
				</li>
				<li class="list-group-item mt-3"><FolderPlus className="text-primary mb-4 me-3" /> 
					<Directory href="#">Factoring Company documents</Directory>
				</li>
			</ul>
      </>
     );
}
 
export default Documents;
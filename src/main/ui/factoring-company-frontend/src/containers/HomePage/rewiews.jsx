import React from 'react';
import { Stars, StarFill, StarHalf } from 'react-bootstrap-icons';
import Google from '../../images/google-symbol.png'
//<div>Icons made by <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>

import styled from "styled-components";
import { Marginer } from '../../components/marginer';


const FullWidth = styled.div`
  width: 100%;
`;


const Reviews = () => {
    return ( 

        <FullWidth className="bg-light">
            <div class="container-lg">
                <div class="text-center">
                    <Marginer direction="vertical" margin={25} />
                    <h2><Stars /> Application Reviews</h2>
                    <p class="lead text-muted">Funding solutions tailored to your business needs</p>
                </div>

                <div class="row justify-content-center my-5">
                    <div class="col-lg-8">
                        <div class="list-group">
                            <div class="list-group-item py-3">
                                <div class="pb-2">
                                    <StarFill />
                                    <StarFill />
                                    <StarFill />
                                    <StarFill />
                                    <StarFill />
                                </div>
                                <h5 class="mb-1">A must-buy for every businessman</h5>
                                <p class="mb-1">Lorem ipsum dolor sit amet consectetur adipisicing elit. Tenetur error veniam sit expedita est illo maiores neque quos nesciunt, reprehenderit autem odio commodi labore praesentium voluptate repellat in id quisquam.</p>
                                <small>Review by Mario</small>
                            </div>
                            <div class="list-group-item py-3">
                                <div class="pb-2">
                                <StarFill />
                                    <StarFill />
                                    <StarFill />
                                    <StarFill />
                                    <StarFill />
                                </div>
                                <h5 class="mb-1">A must-buy for every businessman</h5>
                                <p class="mb-1">Lorem ipsum dolor sit amet consectetur adipisicing elit. Tenetur error veniam sit expedita est illo maiores neque quos nesciunt, reprehenderit autem odio commodi labore praesentium voluptate repellat in id quisquam.</p>
                                <small>Review by Mario</small>
                            </div>
                            <div class="list-group-item py-3">
                                <div class="pb-2">
                                <StarFill />
                                    <StarFill />
                                    <StarFill />
                                    <StarFill />
                                    <StarFill />
                                </div>
                                <h5 class="mb-1">A must-buy for every businessman</h5>
                                <p class="mb-1">Lorem ipsum dolor sit amet consectetur adipisicing elit. Tenetur error veniam sit expedita est illo maiores neque quos nesciunt, reprehenderit autem odio commodi labore praesentium voluptate repellat in id quisquam.</p>
                                <small>Review by Mario</small>
                            </div>
                            <div class="list-group-item py-3">
                                <div class="pb-2">
                                <StarFill />
                                    <StarFill />
                                    <StarFill />
                                    <StarFill />
                                    <StarFill />
                                </div>
                                <h5 class="mb-1">A must-buy for every businessman</h5>
                                <p class="mb-1">Lorem ipsum dolor sit amet consectetur adipisicing elit. Tenetur error veniam sit expedita est illo maiores neque quos nesciunt, reprehenderit autem odio commodi labore praesentium voluptate repellat in id quisquam.</p>
                                <small>Review by Mario</small>
                            </div>
                            <div class="list-group-item py-3">
                                <div class="pb-2">
                                <StarFill />
                                    <StarFill />
                                    <StarFill />
                                    <StarFill />
                                    <StarHalf />
                                </div>
                                <h5 class="mb-1">A must-buy for every businessman</h5>
                                <p class="mb-1">Lorem ipsum dolor sit amet consectetur adipisicing elit. Tenetur error veniam sit expedita est illo maiores neque quos nesciunt, reprehenderit autem odio commodi labore praesentium voluptate repellat in id quisquam.</p>
                                <small>Review by Mario</small>
                            </div>
                        </div>

                    </div>
                </div>
                <figure class="text-center">
                    <blockquote class="blockquote">
                    <p class="lead "><strong>Excelent</strong>, <strong>4.8</strong> out of <strong>5</strong> based on 125,522 reviews.</p>
                    </blockquote>
                    <blockquote class="blockquote">

                    <div class="media">                  
                        <span class="media-left">
                            <img src={Google} alt="Google" width="50" height="50"/>
                        </span>
                    </div>
                    </blockquote>
                </figure>
                    
            </div>
        </FullWidth>
            
     );
}
 
export default Reviews;
import React, { Fragment } from "react";
// import { getProduct } from "../../actions/productActions";
// import { useDispatch, useSelector } from "react-redux";
import { Link } from "react-router-dom";

import ReactStars from "react-rating-stars-component";

// import shoes from "../assets/images/flash-1.png";
// import Loader from "../Loading/Loader";
// import {useAlert} from "react-alert";

const ShopCart = ({ productItems }) => {
  const options = {
    edit: false,
    color: "rgba(20,20,20,0.1)",
    activecolor: "tomato",
    value: productItems.ratings,
    size: window.innerWidth < 600 ? 20 : 25,
    isHalf: true,
  };
  // const alert = useAlert();
  // const dispatch = useDispatch();
  // const { products,loading} = useSelector((state) => state.products);

  // useEffect(() => {

  //   dispatch(getProduct());
  // }, [dispatch]);

  return (
    <>
      <Fragment>
        <Link to={`/product/${productItems._id}`}>
          <div className="box">
            <div className="product mtop">
              <div className="img">
              
                <img src={productItems.images[0].url} alt="" />
                <div className="product-like">
                  <i className="fa-regular fa-heart"></i>
                </div>
              </div>
              <div className="product-details">
                <h3>{productItems.name}</h3>
                <div className="review">
                  
                    <ReactStars {...options} />{" "}
                 
                  <p>({productItems.numOfReviews}) Reviews</p>
                </div>
                <div className="price">
                  <h4>${productItems.price}</h4>
                  <button>
                    <i className="fa fa-plus"></i>
                  </button>
                </div>
             
              </div>
            </div>
          </div>
        </Link>
      </Fragment>
    </>
  );
};

export default ShopCart;

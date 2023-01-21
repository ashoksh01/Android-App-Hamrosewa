import React, { Fragment, useEffect, useState } from "react";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import { Link } from "react-router-dom";
import { useParams } from "react-router-dom";
// import shoes from "../assets/images/flash-1.png";

import { clearError, getProduct } from "../../actions/productActions";
import { useDispatch, useSelector } from "react-redux";
import Loader from "../Loading/Loader";
import {useAlert} from "react-alert";
import ReactStars from "react-rating-stars-component";
import { Rating } from "@material-ui/lab";

// import { ToastContainer, toast } from 'react-toastify';
// import 'react-toastify/dist/ReactToastify.css';

import { addItemsToCart } from "../../actions/cartAction";


const SampleNextArrow = (props) => {
  const { onClick } = props;
  return (
    <div className="control-btn" onClick={onClick}>
      <button className="next">
        <i className="fa fa-long-arrow-alt-right"></i>
      </button>
    </div>
  );
};
const SamplePrevArrow = (props) => {
  const { onClick } = props;
  return (
    <div className="control-btn" onClick={onClick}>
      <button className="prev">
        <i className="fa fa-long-arrow-alt-left"></i>
      </button>
    </div>
  );
};

const FlashCard = () => {
  
 

  const settings = {
    dots: false,
    infinite: true,
    speed: 500,
    slidesToShow: 4,
    slidesToScroll: 1,
    nextArrow: <SampleNextArrow />,
    prevArrow: <SamplePrevArrow />,
  };

  const alert = useAlert();
  const dispatch = useDispatch();
  

  
  const [quantity, setquantity] = useState(1);

   const addToCartHandler=(ID)=>{
    dispatch(addItemsToCart(ID,quantity));
    alert.success("Item added to cart")
  }


   
  const { data,loading,error} = useSelector((state) => state.products);

   

  useEffect( () => {
    if(error){
      alert.error(error);
      dispatch(clearError())
      
    }
    
    dispatch(getProduct());
  }, [dispatch,error,alert]);

  

  return (
    <>
      <Fragment>
      {loading ? <Loader/>:(
           <Slider {...settings}>
        {data &&
          data.map((productItems) => (
          <Link key={productItems._id} to={`/product/${productItems._id}`}>
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
                  
                    <Rating readOnly value={productItems.ratings} precision={0.5} />{" "}
           
                  <p>({productItems.numOfReviews}) Reviews</p>
                </div>
                <div className="price">
                  <h4>${productItems.price}.00 </h4>
                  <button onClick={()=>addToCartHandler(productItems._id)}>
                    <i className="fa fa-plus"></i>
                  </button>
                </div>
             
              </div>
            </div>
          </div>
        </Link>
          ))}
      </Slider>
      )}
       
     
      </Fragment>
      
    </>
  );
};

export default FlashCard;
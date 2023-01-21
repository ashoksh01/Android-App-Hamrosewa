import React,{useEffect,useState} from "react"
import { useDispatch, useSelector } from "react-redux";
import { clearError, lowPriceProduct} from "../../actions/productActions";
import Slider from "react-slick"
import "slick-carousel/slick/slick.css"
import "slick-carousel/slick/slick-theme.css"

import { Link } from "react-router-dom";
// import "../newarrivals/style.css"

const Dcard = () => {
  const dispatch = useDispatch();
    const { data,loading,error} = useSelector((state) => state.lowPriceProduct);
    console.log(data.length);
    
      useEffect( () => {
    if(error){
      alert.error(error);
      dispatch(clearError())
      
    }
    dispatch(lowPriceProduct());
  }, [dispatch,error,alert]);
  const settings = {
    dots: false,
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 1,
    autoplay: true,
  }
  return (
    <>
      <Slider {...settings}>
        { data && data.map((productItems) => {
          return (
              <Link key={productItems._id} to={`/product/${productItems._id}`}>
              <div className='box product' >
                <div className='img'  >
                 
                  <img src={productItems.images[0].url} alt='' style={{height:"300px" , width:"100%", objectfit:"cover"}}/>
                </div>
                <h4>{productItems.name}</h4>
                <span>{productItems.price}</span>
              </div>
           
            </Link>
          )
        })}
      </Slider>
    </>
  )
}

export default Dcard

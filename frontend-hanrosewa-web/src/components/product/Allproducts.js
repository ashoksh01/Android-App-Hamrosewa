import React, { Fragment, useEffect } from "react";
// import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import { Link } from "react-router-dom";
import "./product.css";

// import ReactStars from "react-rating-stars-component";

import { getProduct } from "../../actions/productActions";
import { useDispatch, useSelector } from "react-redux";
import Loader from "../Loading/Loader";
import { useAlert } from "react-alert";
import { clearError } from "../../actions/productActions";
import { ToastContainer, toast } from "react-toastify";

import "react-toastify/dist/ReactToastify.css";

const ALLProduct = () => {
  // const alert = useAlert();

  // const dispatch = useDispatch();
  const { products, loading, error } = useSelector((state) => state.products);
  console.log(products);

  useEffect(() => {
    if (error) {
      if (error) {
        toast.error(error, {
          position: "top-center",

          autoClose: 5000,

          hideProgressBar: false,

          closeOnClick: true,

          pauseOnHover: true,

          draggable: true,

          progress: undefined,
        });
      }
      // alert.error(error);
      // dispatch(clearError());
    }
    dispatch(getProduct());
  }, [dispatch, error]);

  // const options = {
  //   edit: false,
  //   color: "rgba(20,20,20,0.1)",
  //   activecolor: "tomato",
  //   value: products.ratings,
  //   size: window.innerWidth < 600 ? 20 : 25,
  //   isHalf: true,
  // };

  return (
    <Fragment>
      {loading ? (
        <Loader />
      ) : (
        <section className="shop background">
          <div className="container d_flex">
            <div className="product-content  grid1 product-content-grid1-main">
              {products &&
                products.map((productItems) => (
                  <Link to={`/product/${productItems._id}`}>
                    <div className="box box-main-content">
                      <div className="product  product-card-main">
                        <div className="img12">
                          <img src={productItems.images[0].url} alt="" />
                          <div className="product-like">
                            <i className="fa-regular fa-heart"></i>
                          </div>
                        </div>

                        <div className="product-details">
                          <h3>{productItems.name}</h3>
                          <div className="review">
                            {/* <p>
                                <ReactStars value={productItems.ratings} />{" "}
                              </p> */}
                            <p>({productItems.numOfReviews}) Reviews</p>
                          </div>
                          <div className="price">
                            <h4>${productItems.price}.00 </h4>
                            <button>
                              <i className="fa fa-plus"></i>
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </Link>
                ))}
            </div>
            <ToastContainer />

            <div />
          </div>
        </section>
      )}
    </Fragment>
  );
};

export default ALLProduct;

import React, { Fragment, useEffect, useState } from "react";
import Carousel from "react-material-ui-carousel";
import {
  clearError,
  getProductDetails,
  newReview,
} from "../../actions/productActions";

import { useDispatch, useSelector } from "react-redux";
import { useParams } from "react-router-dom";

import { NEW_REVIEW_RESET } from "../../contants/productContants";

import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import "./Testimonial.css";
// import { Avatar } from "@material-ui/core";
import { ArrowBackIos, ArrowForwardIos } from "@material-ui/icons";
import {
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  Button,
} from "@material-ui/core";

import "./ProductDetails.css";
import { Rating } from "@material-ui/lab";
import Loader from "../Loading/Loader";
import ReviewCard from "./reviewCard";
import { useAlert } from "react-alert";
import Footer from "../footer/Footer";
import { addItemsToCart } from "../../actions/cartAction";

const PreviousBtn = (props) => {
  console.log(props);
  const { className, onClick } = props;

  return (
    <div className={className} onClick={onClick}>
      <ArrowBackIos style={{ color: "gray", fontSize: "45px" }} />
    </div>
  );
};
const NextBtn = (props) => {
  const { className, onClick } = props;
  return (
    <div className={className} onClick={onClick}>
      <ArrowForwardIos style={{ color: "gray", fontSize: "45px" }} />
    </div>
  );
};

const ProductsDetails = () => {
  const dispatch = useDispatch();
  const alert = useAlert();
  const { id } = useParams();

  const { product, loading, error } = useSelector(
    (state) => state.productDetails
  );
  const { success, error: reviewError } = useSelector(
    (state) => state.newReview
  );

  useEffect(() => {
    if (error) {
      alert.error(error);
      dispatch(clearError());
    }
    if (reviewError) {
      alert.error(reviewError);
      dispatch(clearError());
    }

    if (success) {
      alert.success("Review Submitted Successfully");
      dispatch({ type: NEW_REVIEW_RESET });
    }

    dispatch(getProductDetails(id));
  }, [dispatch, id, error, alert, reviewError, success]);

  const options = {
    value: product.ratings,
    size: "large",
    readOnly: true,
    precision: 0.5,
  };
  const [quantity, setquantity] = useState(1);
  const [open, setOpen] = useState(false);
  const [rating, setRating] = useState(0);
  const [comment, setComment] = useState("");
  const increaseQuanity = () => {
    if (product.Stock <= quantity) return;
    const qty = quantity + 1;
    setquantity(qty);
  };
  const decreaseQuanity = () => {
    if (quantity >= 1) return;
    const qty = quantity - 1;
    setquantity(qty);
  };

  const addToCartHandler = () => {
    dispatch(addItemsToCart(id, quantity));
    alert.success("Item added to cart");
  };
  const submitReviewToggle = () => {
    open ? setOpen(false) : setOpen(true);
  };
  const reviewSubmitHandler = () => {
    const myForm = new FormData();

    myForm.set("rating", rating);
    myForm.set("comment", comment);
    myForm.set("productId", id);

    dispatch(newReview(myForm));

    setOpen(false);
  };

  return (
    <Fragment>
      {loading ? (
        <Loader />
      ) : (
        <Fragment>
          <div className="ProductDetails">
            <div className="second">
              <Carousel>
                {product.images &&
                  product.images.map((item, i) => (
                    <img
                      className="CarouselImage"
                      key={i}
                      src={item.url}
                      alt={`${i} Slide`}
                    />
                  ))}
              </Carousel>
            </div>

            <div className="detailsBlockSecond">
              <div className="detailsBlock-1">
                <h2>{product.name}</h2>
              </div>

              <div className="detailsBlock-2">
                <Rating
                  {...options}
                 
                />
                <span>{product.numOfReviews} Reviews</span>
              </div>

              <div className="detailsBlock-3">
                <h1>₹{product.price}</h1>
                <div className="detailsBlock-3-1">
                  <div className="detailsBlock-3-1-1">
                    <button onClick={decreaseQuanity}>-</button>
                    <input type="number" readOnly value={quantity} />
                    <button onClick={increaseQuanity}>+</button>
                  </div>{" "}
                  <button onClick={addToCartHandler}>Add to Card</button>
                </div>
                <p>
                  Status:{" "}
                  <b className={product.Stock < 1 ? "redColor" : "greenColor"}>
                    {product.Stock < 1 ? "OutOfStock" : "InStock"}
                  </b>
                </p>
              </div>
              <div className="detailsBlock-4">
                Descriptions:<p>{product.description}</p>
              </div>
              <button onClick={submitReviewToggle} className="submitReview">
                Submit Review
              </button>
            </div>
          </div>
          <h1 style={{ marginBottom: 20 }} className="reviewsHeading">
            Reviews
          </h1>
          <Dialog
            aria-labelledby="simple-dialog-title"
            open={open}
            onClose={submitReviewToggle}
          >
            <DialogTitle>Submit Review</DialogTitle>
            <DialogContent className="submitDialog">
              <Rating
                onChange={(e) => setRating(e.target.value)}
                value={rating}
                size="large"
              />

              <textarea
                className="submitDialogTextArea"
                cols="30"
                rows="5"
                value={comment}
                onChange={(e) => setComment(e.target.value)}
              ></textarea>
            </DialogContent>
            <DialogActions>
              <Button onClick={submitReviewToggle} color="secondary">
                Cancel
              </Button>
              <Button onClick={reviewSubmitHandler} color="primary">
                Submit
              </Button>
            </DialogActions>
          </Dialog>

          {product.reviews && product.reviews[0] ? (
            <div
              className="testimonial"
              style={{
                display: "flex",
                justifyContent: "center",
                marginTop: 50,
              }}
            >
              <div style={{ width: "50%", textAlign: "center" }}>
                <Slider
                  prevArrow={<PreviousBtn />}
                  nextArrow={<NextBtn />}
                  dots
                >
                  {product.reviews &&
                    product.reviews.map((review) => (
                      <ReviewCard review={review} />
                    ))}
                </Slider>
              </div>
            </div>
          ) : (
            <p className="noReviews">There is no reviews</p>
          )}
        </Fragment>
      )}
      {/* <Footer /> */}
    </Fragment>
  );
};

export default ProductsDetails;

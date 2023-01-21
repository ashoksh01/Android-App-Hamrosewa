import React, { useEffect, useState } from "react";
// import Catg from "./Catg"
import ShopCart from "./ShopCart";
import "./style.css";
import {  getProduct } from "../../actions/productActions";
import { useDispatch, useSelector } from "react-redux";
import Loader from "../Loading/Loader";
import { useAlert } from "react-alert";
import { useParams } from "react-router-dom";
import Pagination from "react-js-pagination";
import Typography from "@material-ui/core/Typography";
import Slider from "@material-ui/core/Slider";
import Footer from "../footer/Footer";
import Wrapper from "../wrapper/Wrapper";
// import { withWidth } from "@material-ui/core";

const categories = [
  {
   
    cateName: "Sunglass",
  },
  {
   
    cateName: "Shoes",
  },
  {
    
    cateName: "Watch",
  },
  {
    
    cateName: "SmartPhones",
  },
  
];

const Shop = () => {
  const [currentPage, setCurrentPage] = useState(1);
  const [price, setPrice] = useState([0, 25000]);
  const [category, setCategory] = useState("");
  const [ratings, setRating] = useState(0);

  const { keyword } = useParams();

  const dispatch = useDispatch();
  const alert = useAlert();
  const {
    data,
    error,
    loading,
    resultPerPage,
    productNumber,
    filteredProductsCount,
  } = useSelector((state) => state.products);
  console.log(data.length);
  // console.log(productNumber);
  const setCurrentPageNo = (e) => {
    setCurrentPage(e);
  };
  const pricehandler = (event, newPrice) => {
    setPrice(newPrice);
  };

  useEffect(() => {
    if(error){
    return alert.error(error);
    }
    dispatch(getProduct(keyword, currentPage, price, category,ratings));
  }, [dispatch, keyword, currentPage, price, category,ratings,error,alert]);

  let count = filteredProductsCount;
  return (
    <>
      <section className="shop background">
        <div className="container d_flex">
          <div className="category">
            <div className="chead d_flex">
              <h1>Category</h1>
              <h1>Shops </h1>
            </div>
            {categories.map((category, index) => {
              return (
                <div
                  className="box f_flex"
                  key={index}
                  onClick={() => setCategory(category.cateName)}
                >
                  <img src={category.cateImg} alt="" />
                  <span>{category.cateName}</span>
                </div>
              );
            })}

            <div className="box">
              <div className="sliderprice">
                <Typography className="price">Price</Typography>
                <Slider
                  value={price}
                  onChange={pricehandler}
                  valueLabelDisplay="auto"
                  aria-labelledby="range-Slider"
                  min={0}
                  max={25000}
                />
              </div>
            </div>
           

            <div className="box ">
             
                 <div className="sliderprice">
              <Typography  className="price" component="legend">
                Rating
              </Typography>
              <Slider
              value={ratings}
              onChange={(e,newRating)=>{
                setRating(newRating);
              }}
              aria-labelledby="continuous-slider"
              valueLabelDisplay="auto"
              min={0}
              max={5}
              
              
              
              
              />
              </div>

              
            </div>
          </div>

          <div className="contentWidth">
            <div className="heading d_flex">
              <div className="heading-left row  f_flex">
                <h2>Features Products</h2>
              </div>
              <div className="heading-right row ">
                <span>View all</span>
                <i className="fa-solid fa-caret-right"></i>
              </div>
            </div>
            <div className="product-content  grid1">
              {loading ? (
                <Loader />
              ) : (
                <>
                  {data &&
                    data.map((productItems,index) => (
                      <ShopCart
                        key={productItems._id}
                        productItems={productItems}
                      />
                    ))}
                </>
              )}
            </div>
            {resultPerPage < count && (
              <div className="paginationBox">
                <Pagination
                  activePage={currentPage}
                  itemsCountPerPage={resultPerPage}
                  totalItemsCount={productNumber}
                  onChange={setCurrentPageNo}
                  nextPageText="Next"
                  prevPageText="Prev"
                  firstPageText="1st"
                  lastPageText="Last"
                  itemClass="page-item"
                  linkClass="page-link"
                  activeClass="pageItemActive"
                  activeLinkClass="pageLinkActive"
                />
              </div>
            )}
          </div>
        </div>
      </section>
      
      {/* <Footer/> */}
    </>
  );
};

export default Shop;

import React, { useState } from "react";
import logo from "../../components/assets/images/logo-najik.png";
import { Link,useNavigate  } from "react-router-dom";
import { useSelector } from "react-redux"

import './search.css';
import Login from "../User/login";

const Search = () => {
  const navigate = useNavigate();
  const [toggle ,setToggle]=useState(false)
   const {cartItems} = useSelector((state)=> state.cart);

  // console.log(history);
  window.addEventListener("scroll", function () {
    const search = document.querySelector(".search");
    search.classList.toggle("active", window.scrollY > 100);
  });
  const [keyword, setKeyword] = useState("");

  const SearchSubmitHandler = (e) => {
    e.preventDefault();
    if(keyword.trim()){
      navigate(`/products/${keyword}`)

    }
    else{
      navigate("/products")
    }
  };
  return (
    <>
      <form className="searchBox" onSubmit={SearchSubmitHandler}>
        <section className="search">
          <div className="container c_flex">
            <div className="logo with">
             <Link to="/">
              <img src={logo} alt="" style={{width:"180px" }} />
             </Link>
            </div>

            <div className="search-box f_flex">
              <i className="fa fa-search"></i>
              <input
                type="text"
                placeholder="Search and hit enter..."
                onChange={(e) => setKeyword(e.target.value)}
              />
             <span>All category</span>
            </div>

            <div className="icon f_flex width">
              <i className="fa fa-user icon-circle" onClick={()=>{setToggle(!toggle)}}></i>
              <div className="cart">
                <Link to="/cart" >
                  <i className="fa fa-shopping-bag icon-circle"></i>
                  <span>{cartItems.length}</span>
                </Link>
              </div>
            </div>
          </div>
        </section>
      </form>
      {toggle?

      <Login/>:<div></div>
      }
    </>
  );
};

export default Search;

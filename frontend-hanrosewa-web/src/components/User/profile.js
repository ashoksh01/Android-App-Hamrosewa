import React, { useEffect, useState } from "react";
import "./profile.css";
import { useSelector } from "react-redux";
import Loader from "../Loading/Loader";
import { useNavigate, Link } from "react-router-dom";
import UpdateProfile from "./UpdateProfile";
import MailOutlineIcon from "@material-ui/icons/MailOutline";
import LockOpenIcon from "@material-ui/icons/LockOpen";
import FaceIcon from "@material-ui/icons/Face";
import UpdatePassword from "./UpdatePassword";
import Footer from "../footer/Footer";

const Profile = () => {
  const tabtoggle = (index) => {
    setTab(index);
  };

  const [toggle, setToggle] = useState(false);
  const [passwordtoggle, setpasswordToggle] = useState(false);
  const [tab, setTab] = useState(0);

  const nagivate = useNavigate();
  const { user, loading, isAuthenticated } = useSelector((state) => state.user);
  useEffect(() => {
    if (isAuthenticated == false) {
      nagivate("/");
    }
  }, [isAuthenticated, nagivate]);

  return (
    <>
      {loading ? (
        <Loader />
      ) : (
        <div className="content">
          <div className="cover-page">
            <img
              src="https://www.jdmedia.co.za/images/carousel/Ecommerce-Banner-1920.jpg"
              className="cover-img"
              alt="not found"
            />
          </div>

          <div className="row-cols-2 ">
            <div className="profile-info">
              <img className="rounded-img" src={user.image.url} alt="" />
              <h3 className="name">{user.name}</h3>
              <span className="location">{user.email} ✅</span>
              <p>Created At: {String(user.createdAt).substring(0, 10)}</p>
              {/* <button className="edit-btn" onClick={() => setToggle(!toggle)}>
                Edit Profile
              </button> */}
              {/* <Link to="/password/update">Change Password</Link> */}
              {/* <button
                className="edit-btn"
                onClick={() => setpasswordToggle(!passwordtoggle)}
              >
                channge Password
              </button> */}
              <div className="social-icons ">
                <span>
                  <i className="fab fa-instagram"></i>
                </span>
                <span>
                  <i className="fab fa-facebook-f"></i>{" "}
                </span>
                <span>
                  <i className="fab fa-twitter"></i>
                </span>
              </div>
            </div>

            <div className="tab-section">
              <div className="d-flex tab-nav ">
                <span className="toggle-btn active" onClick={() => setTab(0)}>
                  Privacy Setting
                </span>

                <span className="toggle-btn" onClick={() => setTab(1)}>
                  Chnage Profile
                </span>

                <span className="toggle-btn" onClick={() => setTab(2)}>
                  Bought
                </span>
              </div>

              <div className="product-type">
                <div
                  className={
                    tab === 0 ? "row-cols-3 product-list active" : "d-none"
                  }
                >
                  <UpdatePassword />
                </div>
              </div>
              <div className="product-type">
                <div
                  className={
                    tab === 1 ? "row-cols-3 product-list active" : "d-none"
                  }
                >
                  <UpdateProfile />
                </div>
              </div>
            </div>
          </div>
        </div>
      )}

      {toggle ? <UpdateProfile /> : <div></div>}
      {passwordtoggle ? <UpdatePassword /> : <div></div>}
      {/* <Footer/> */}
    </>
  );
};

export default Profile;

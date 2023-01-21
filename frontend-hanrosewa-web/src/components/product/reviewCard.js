import React from "react";
import ReactStars from "react-rating-stars-component";
import { Avatar } from "@material-ui/core";
// import "./Testimonial.css";
const ReviewCard = ({ review }) => {
  const options = {
    edit: false,
    color: "rgba(20,20,20,0.1)",
    activecolor: "tomato",
    value: review.rating,
    size: window.innerWidth < 600 ? 20 : 25,
    isHalf: true,
  };

  return (
    <div
    
      className="review-card"
      style={{
        display: "flex",
        alignItems: "center",
        flexDirection: "column",
        textAlign: "center",
        color: "gray",
       
        padding: "10px",
        margin: "auto",
        justifyContent: "center",
      }}
    >
      <Avatar
        imgProps={{ style: { borderRadius: "50%" } }}
        src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80"
        style={{
          width: 120,
          height: 120,
          border: "1px solid lightgray",
          padding: 7,
          marginBottom: 20,
        }}
      />

      <h1>{review.name}</h1>
      <ReactStars {...options} classNames="stars" />
      <p>{review.comment}</p>

      {/* <p style={{ fontStyle: "italic", marginTop: 25 }}>
          <span style={{ fontWeight: 500, color: "green" }}>PAULA WILSON</span>{" "}
          , Media Analyst
        </p> */}
    </div>
  );
};

export default ReviewCard;

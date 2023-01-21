import React, { Fragment, useEffect } from "react";
import { getAdminProduct } from "../../actions/productActions";
import { getAllOrders } from "../../actions/orderAction";

import { getAllUsers } from "../../actions/userAction";
import Sidebar from "./Sidebar";
import "./dashboard.css";
import { useDispatch, useSelector } from "react-redux";

import { Typography } from "@material-ui/core";
import { Link } from "react-router-dom";
import { Doughnut } from "react-chartjs-2";
import { Line } from "react-chartjs-2";
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  LineElement,
  Legend,
  CategoryScale,
  LinearScale,
  PointElement,
  Filler,
  ArcElement,
} from "chart.js";

ChartJS.register(
  Title,
  Tooltip,
  LineElement,
  Legend,
  CategoryScale,
  LinearScale,
  PointElement,
  Filler,
  ArcElement
);

const Dashboard = () => {
  const dispatch = useDispatch();
  const { data, error } = useSelector((state) => state.products);
  const { orders } = useSelector((state) => state.allOrders);
  const { users } = useSelector((state) => state.allUsers);
  let outOfStock = 0;

  data &&
    data.forEach((item) => {
      if (item.Stock === 0) {
        outOfStock += 1;
      }
    });

    let totalAmount = 0;
  orders &&
    orders.forEach((item) => {
      totalAmount += item.totalPrice;
    });

  useEffect(() => {
    if (error) {
      return alert.error(error);
    }

    dispatch(getAdminProduct());
    dispatch(getAllOrders());
    dispatch(getAllUsers());
  }, [dispatch, alert, error]);

  const lineState = {
    labels: ["Initial Amount", "Amount Earned"],
    datasets: [
      {
        label: "TOTAL AMOUNT",
        backgroundColor: ["tomato"],
        hoverBackgroundColor: ["rgb(197, 72, 49)"],
        data: [0, totalAmount],
      },
    ],
  };
  const doughnutState = {
    labels: ["Out of Stock", "InStock"],
    datasets: [
      {
        backgroundColor: ["#00A6B4", "#6800B4"],
        hoverBackgroundColor: ["#4B5000", "#35014F"],
        data: [outOfStock, data.length - outOfStock],
      },
    ],
  };

  return (
    <Fragment>
      <div className="dashboard">
        <Sidebar />
        <div className="dashboardContainer">
          <Typography component="h1"> Hamro-Sewa Admin Dashboard</Typography>
          <div className="dashboardSummary">
            <div>
              <p>
                Total Amount <br /> ₹{totalAmount}
              </p>
            </div>
            <div className="dashboardSummaryBox2">
              <Link to="/admin/products">
                <p>Services</p>
                <p>{data && data.length}</p>
              </Link>
              <Link to="/admin/orders">
                <p>Booking History</p>
                <p>{orders && orders.length}</p>
              </Link>
              <Link to="/admin/users">
                <p>Users</p>
                <p>{users && users.length}</p>
              </Link>
            </div>
          </div>
          <div className="lineChart">
            <Line data={lineState} />

            <div className="doughnutChart">
              <Doughnut data={doughnutState} />
            </div>
          </div>
        </div>
      </div>
    </Fragment>
  );
};

export default Dashboard;

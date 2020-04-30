import React from "react";
import axios from "axios";
import "./App.css";
import {
  API_URL,
  PRO_PREFIX,
  BACKLOG_API_KEY,
  BACKLOG_URL,
  BACKLOG_STATUS,
  AUTO_UPDATE_MIN,
  LUPACK_ATTR,
  WORKING_TIME
} from "./utilities/constants.js";

export default class App extends React.Component {
  constructor(props) {
    super(props);
    const date = new Date();
    this.state = {
      hour: this.checkTime(date.getHours()),
      minute: this.checkTime(date.getMinutes()),
      second: this.checkTime(date.getSeconds()),
      crt_minute: "",
      updateTicket: ""
    };
    this.autoUpdate = this.autoUpdate.bind(this);
    this.checkTime = this.checkTime.bind(this);
  }

  checkTime(elem) {
    if (elem < 10) {
      elem = "0" + elem;
    }
    return elem;
  }

  //Kiểm tra giờ giấc hợp lệ thì update
  autoUpdate() {
    const date = new Date();
    this.setState({
      hour: this.checkTime(date.getHours()),
      minute: this.checkTime(date.getMinutes()),
      second: this.checkTime(date.getSeconds())
    });
    let crt_minute = this.state.crt_minute;
    let minute = this.state.minute;
    let second = this.state.second;
    if (
      this.state.hour >= WORKING_TIME.start &&
      this.state.hour < WORKING_TIME.end
    ) {
      if (minute % AUTO_UPDATE_MIN === 0) {
        if (minute !== crt_minute) {
          this.setState({ crt_minute: minute });
          this.getDataLupack();
        }
        if (second === '05') {
          this.sendNotifyEmail(this.state.updateTicket);
        }
      }
    }
  }

  sendNotifyEmail(ticketIds) {
    if (ticketIds !== "") {
      const url = API_URL + "fdoc_t_ticket/notify_update/ticket=" + ticketIds;
      axios
        .get(url)
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
      this.setState({ updateTicket: "" });
    }
  }

  //Set thời gian update logic. Hiện tại: Cứ 1000ms thì update 1 lần
  componentDidMount() {
    window.setInterval(this.autoUpdate, 1000);
  }

  //Lấy data từ Lupack
  getDataLupack() {
    const mileStone = LUPACK_ATTR.mileStone;
    const tmp =
      mileStone.LuDev + "-" + mileStone.LuTest + "-" + mileStone.LuFix;
    const url =
      API_URL +
      "fdoc_t_ticket/find/pro_id=" +
      LUPACK_ATTR.proId +
      "&mile_stone=" +
      tmp +
      "&status=" +
      LUPACK_ATTR.status;
    axios.get(url).then(response => {
      this.updateBacklog(response.data.entities.tickets);
    });
  }

  //Update Backlog
  updateBacklog(tickets) {
    let updateTicket = "";
    tickets.forEach((ticket, i) => {
      const issueName = PRO_PREFIX + ticket.tik_i_trac_id;
      const urlGet =
        BACKLOG_URL + "issues/" + issueName + "?apiKey=" + BACKLOG_API_KEY;
      axios
        .get(urlGet)
        .then(response => {
          const data = response.data;
          if (data.status.id === BACKLOG_STATUS.Open) {
            const urlUpdate =
              BACKLOG_URL +
              "issues/" +
              data.issueKey +
              "?apiKey=" +
              BACKLOG_API_KEY;
            axios
              .patch(urlUpdate, {
                statusId: BACKLOG_STATUS.InProgress
              })
              .then(response2 => {
                if (updateTicket === "") {
                  updateTicket = ticket.tik_i_trac_id;
                } else {
                  updateTicket = updateTicket + "-" + ticket.tik_i_trac_id;
                }
                this.setState({ updateTicket: updateTicket });
              })
              .catch(e2 => {
                console.log("Loi1: " + ticket.tik_i_trac_id);
              });
          }
        })
        .catch(e => {
          console.log("Loi2: " + ticket.tik_i_trac_id);
        });
    });
  }

  //Dùng để vẽ màn hình
  render() {
    const state = this.state;
    const time = state.hour + ":" + state.minute + ":" + state.second;
    return (
      <div className="App">
        <h1 align="center">{time}</h1>
      </div>
    );
  }
}

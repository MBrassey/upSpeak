import React, { Component } from 'react';
import Identicon from 'identicon.js';
import logo from '../img/upSpeak.png';
import eth from '../img/ethicon.png';

const motd = [ 'upSpeak is an Ethereum based Decentralized Social Network!',
               'upSpeak Naturally Incentivises High Quality Posts!', 
               'upSpeak Topics are Added by its Users!',
               'upSpeak is Opensource and Ad-free.',
               'Content on upSpeak cant be Deleted, Modified or Changed.',
               'upSpeak is 100% Censorship Resistant.',
               'upSpeak is Literally Un-Stoppable!',
               'upSpeak is Powered by Ethereum Smart Contracts!',
               'upSpeak has No Owners or Employees, only Developers!',
               'upSpeak is Autonimous and Decentralized.',
               'upSpeak is Deployed to Ethereum Main Net!',
               'upSpeak is a Blockchain Application.',
               'up-its! are a Fully Peer-to-Peer Rewards System.',
               'upSpeak Developers Only get Paid when You Add a Topic.',
               'upSpeak Naturally De-Incentivises Spam.',
               'Whats on Your Mind?',
               'What do You Say?',
               'The Most Appreciated Posts Rise to the Top!',
               'upSpeak Users are Paid Instantly in Ethereum!',
               'Speed Up the Mining of Your Post by Paying a Higher Gas Fee.',
               'The reward for for one up-it! is 0.007 ETH.',
               'You can Run your Own upSpeak Web Server.',
               'All Post & Topics on upSpeak are perminant.',
               'upSpeak Users pay other Users Directly by Clicking up-it!'
              ];

function Rand(motd){
  const keys = Object.keys(motd);
  let i = keys.length - 1;
  const j = Math.floor(Math.random() * i);
  return motd[keys[j]];
}

document.body.style = 'background: #DFE5E8;';
class Main extends Component {

  render() {
    return (
      <div className="container-fluid mt-5">
        <div className="row">
          <main role="main" className="col-lg-12 ml-auto mr-auto" style={{ maxWidth: '504px', background: '#DFE5E8' }}>
            <div className="content mr-auto ml-auto">
              <p>&nbsp;</p>
                <form onSubmit={(event) => {
                  event.preventDefault()
                  const content = this.postContent.value
                  this.props.createPost(content)
                }}>
                <div className="form-group ">
                <img src={logo} width="496" height="301" alt="upSpeak" /><br /><br /><br />
                  <input
                    id="postContent"
                    type="text"
                    ref={(input) => { this.postContent = input }}
                    className="form-control"
                    placeholder= {Rand(motd)}
                    required />
                </div>
                <button type="submit" className="btn btn-info btn-block">Share</button>
              </form>
              <p>&nbsp;</p>
              { this.props.posts.map((post, key) => {
                return(
                  <div className="card mb-4" key={key} >
                    <div className="card-header">
                      <img
                        className='mr-2'
                        width='30'
                        height='30'
                        src={`data:image/png;base64,${new Identicon(post.author, 30).toString()}`}
                      />
                      <small className="text-muted">{post.author}</small>
                    </div>
                    <ul id="postList" className="list-group list-group-flush">
                      <li className="list-group-item">
                        <p>{post.content}</p>
                      </li>
                      <li key={key} className="list-group-item py-2">
                        <small className="float-left mt-1 text-muted">
                        <img src={eth} width="9" height="14" alt="upSpeak" /> [{window.web3.utils.fromWei(post.tipAmount.toString(), 'Ether')} ETH]
                        </small>
                        <button
                          className="btn btn-info btn-sm float-right pt-0"
                          name={post.id}
                          onClick={(event) => {
                            let tipAmount = window.web3.utils.toWei('0.007', 'Ether')
                            console.log(event.target.name, tipAmount)
                            this.props.tipPost(event.target.name, tipAmount)
                          }}
                        >
                          <strong>up-it!</strong> [0.007 ETH]
                        </button>
                      </li>
                    </ul>
                  </div>
                )
              })}
            </div>
          </main>
        </div>
      </div>
    );
  }
}

export default Main;

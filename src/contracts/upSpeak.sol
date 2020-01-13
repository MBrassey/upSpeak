pragma solidity ^0.5.0;

contract upSpeak {
    string public name;
    uint256 public topicCount = 0;
    uint public postCount = 0;
    
    constructor() public {
        name = "upSpeak";
    }

    mapping (uint => Topic) public topics;
    mapping(uint => Post) public posts;

    struct Topic {
        uint _id;
        string _topicName;
        address payable wallet;
    }

    struct Post {
        uint id;
        string content;
        uint tipAmount;
        address payable author;
        string _topicName;
    }

    event TopicCreated(
        uint _id,
        string _topicName,
        address payable wallet
    );

    event PostCreated(
        uint id,
        string content,
        uint tipAmount,
        address payable author
    );

    event PostTipped(
        uint id,
        string content,
        uint tipAmount,
        address payable author
    );

    function createTopic(string memory _topicName) public payable {
        // Require valid dontent
        require(bytes(_topicName).length > 0);
        // Require payment to create new topic
        address payable _wallet;
        address(_wallet).transfer(msg.value);
        topicCount += 1;
        topics[topicCount] = Topic(topicCount, _topicName, msg.sender);
    }
    
    function createPost(string memory _content, string memory _topicName) public {
        // Require valid content
        require(bytes(_content).length > 0);
        // Increment the post count
        postCount ++;
        // Create the post
        posts[postCount] = Post(postCount, _content, 0, msg.sender, _topicName);
        // Trigger event
        emit PostCreated(postCount, _content, 0, msg.sender);
    }

    function tipPost(uint _id) public payable {
        // Make sure the id is valid
        require(_id > 0 && _id <= postCount);
        // Fetch the post
        Post memory _post = posts[_id];
        // Fetch the author
        address payable _author = _post.author;
        // Pay the author by sending them Ether
        address(_author).transfer(msg.value);
        // Incremet the tip amount
        _post.tipAmount = _post.tipAmount + msg.value;
        // Update the post
        posts[_id] = _post;
        // Trigger an event
        emit PostTipped(postCount, _post.content, _post.tipAmount, _author);
    }
    
}
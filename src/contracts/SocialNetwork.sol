pragma solidity ^0.5.0;

contract SocialNetwork {
    string public name;
    uint public topicCount = 0;
    uint public postCount = 0;
    mapping (uint => Topic) public topics;
    mapping(uint => Post) public posts;

    struct Topic {
        uint id;
        string topicName;
        uint tipAmount2;
        address payable author;
    }

    struct Post {
        uint id;
        string content;
        uint tipAmount;
        address payable author;
    }

    event TopicCreated(
        uint id,
        string topicName,
        uint tipAmount2,
        address payable author
    );

    event PostCreated(
        uint id,
        string content,
        uint tipAmount,
        address payable author
    );

    event TopicTipped(
        uint id,
        string topicName,
        uint tipAmount2,
        address payable author
    );

    event PostTipped(
        uint id,
        string content,
        uint tipAmount,
        address payable author
    );

    constructor() public {
        name = "upSpeak";
    }

    function createTopic(string memory _topicName) public {
        // Require valid topic name
        require(bytes(_topicName).length > 0);
        // Increment the topic count
        topicCount ++;
        // Create the post
        topics[topicCount] = Topic(topicCount, _topicName, 0, msg.sender);
        // Trigger event
        emit TopicCreated(topicCount, _topicName, 0, msg.sender);
    }

    function createPost(string memory _content) public {
        // Require valid content
        require(bytes(_content).length > 0);
        // Increment the post count
        postCount ++;
        // Create the post
        posts[postCount] = Post(postCount, _content, 0, msg.sender);
        // Trigger event
        emit PostCreated(postCount, _content, 0, msg.sender);
    }

    function tipTopic(uint _id) public payable {
        // Make sure the id is valid
        require(_id > 0 && _id <= topicCount);
        // Fetch the topic
        Topic memory _topic = topics[_id];
        // Fetch the author
        address payable _author = _topic.author;
        // Pay the author by sending them Ether
        address(_author).transfer(msg.value);
        // Incremet the tip amount
        _topic.tipAmount2 = _topic.tipAmount2 + msg.value;
        // Update the post
        topics[_id] = _topic;
        // Trigger an event
        emit TopicTipped(topicCount, _topic.topicName, _topic.tipAmount2, _author);
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

pragma solidity ^0.5.0;

contract upSpeak {
    string public name;
    uint256 public topicCount = 0;
    uint public postCount = 0;
    mapping (uint => Topic) public topics;
    mapping(uint => Post) public posts;

    struct Topic {
        uint _id;
        string _topicName;
        string _authorAddress;
        address charged author;
        address payable upSpeakWallet;        
    }

    struct Post {
        uint id;
        string content;
        uint tipAmount;
        address payable author;
    }

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

    constructor() public {
        name = "upSpeak";
    }

    function createTopic(string memory _topicName, string memory _authorAddress) public payable{
        // Fetch the author
        address charged _author = _topic.author;
        topicCount += 1;
        topics[topicCount] = Topic(topicCount, _topicName, _authorAddress);
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
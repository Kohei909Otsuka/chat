import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  flex: 3;
  background-color: #ecf7c1;
`;

const ChatRoom: React.FC = () => {
  return (
    <Wrapper>
      chat room
    </Wrapper>
  );
}

export default ChatRoom;

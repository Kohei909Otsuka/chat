import React from 'react';
import styled from 'styled-components';
import Header from './Header';
import Rooms from './Rooms';
import ChatRoom from './ChatRoom';

const Wrapper = styled.div`
  height: calc(100vh - 50px);
  display: flex;
`;

const Main: React.FC = () => {
  return (
    <div>
      <Header />
      <Wrapper>
        <Rooms />
        <ChatRoom />
      </Wrapper>
    </div>
  );
}

export default Main;

import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  background-color: #ddedbe;
  flex: 1;

  display: flex;
  justify-content: center;
  align-items: center;
`;

type Props = {
  name: string;
};

const ChatRoomHeader: React.FC<Props> = (props: Props) => {
  return (
    <Wrapper>
      {props.name}
    </Wrapper>
  )
};

export default ChatRoomHeader;

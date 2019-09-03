import React, { useState } from 'react';
import styled from 'styled-components';

interface WrapperStyle {
  focus: boolean;
};
const Wrapper = styled.div<WrapperStyle>`
  height: 60px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 10px 0 10px;
  background-color: ${props => props.focus ? "red" : ""};
`;

type Props = {
  name: string;
  unreadCount: number;
};

const Room: React.FC<Props> = (props: Props) => {
  const [focus, setFocus] = useState(false)

  const { name, unreadCount } = props;
  let displayName = name;
  let displayUnreadCount = "";

  if (name.length >= 10) {
    displayName =
      name.substring(0, 10) + "...";
  }

  if (unreadCount > 0) {
    displayUnreadCount =
      unreadCount.toString();
  }

  return (
    <Wrapper
      onMouseOver={() => setFocus(true)}
      onMouseOut={() => setFocus(false)}
      focus={focus}
    >
      <div>
        {displayName}
      </div>
      <div>
        {displayUnreadCount}
      </div>
    </Wrapper>
  );
};

export default Room;

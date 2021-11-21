const rand = () => Math.floor(Math.random() * 255);
const randBackgroundColor = () => `rgba(${rand()}, ${rand()}, ${rand()}, 0.2)`;
const randBorderColor = () => `rgba(${rand()}, ${rand()}, ${rand()}, 1)`;
const randColor = () => `${rand()}, ${rand()}, ${rand()}`;

export {rand, randBorderColor, randBackgroundColor, randColor}
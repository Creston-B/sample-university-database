getRandomInt = function (min, max) {
  return( Math.floor(Math.random() * (max - min)) + min);
}

// university years generation (altered a few arbitrarily to give larger / smaller student bodies)
// for (let i = 1000; i<= 1017; i++) {
//  console.log(`(${i}, 2018, ${getRandomInt(2000, 3000)}, ${getRandomInt(20, 120)}, ${getRandomInt(5, 20)}, ${getRandomInt(45, 55)}),`);
//  console.log(`(${i}, 2019, ${getRandomInt(2000, 3000)}, ${getRandomInt(20, 120)}, ${getRandomInt(5, 20)}, ${getRandomInt(45, 55)}),`);
//  console.log(`(${i}, 2020, ${getRandomInt(2000, 3000)}, ${getRandomInt(20, 120)}, ${getRandomInt(5, 20)}, ${getRandomInt(45, 55)}),`);
// }

//university year score generation
for (let i = 1000; i<= 1017; i++) {
  let low = getRandomInt(40, 90);
  let max = low + 20;
  if (max > 100) {
    max = 100
  }
 for (let criteria_id = 500; criteria_id <= 504; criteria_id++) { 
    for (let year = 2018; year <= 2020; year++) {
      console.log(`(${i}, ${criteria_id}, ${year}, ${getRandomInt(low, max)}),`);
    }
  }
}

Method: GET

Path: /units/si

Query parameter: units​. "A string containing any number of SI units multiplied or divided, which might contain parenthesis. Examples: "degree", "degree/minute", "(degree/(minute*hectare))", "ha*°"

Return a JSON object with two values:

unit_name​: a string of units converted to their SI counterpart. They do not need to be reduced, so something like "(s/s)” for "(min/min)” is acceptable. The parenthesis should match the input.

multiplication_factor​: a floating point number (rounded to 14 decimal places) you can use to convert any input in the original units to the new widely-used SI units.

Example:

GET "/units/si?units=degree/minute"

->
```json
{ 
  "unit_name": "rad/s", 
  "multiplication_factor”: 0.00029088820867 
 }
```

https://desolate-island-19052.herokuapp.com is the application


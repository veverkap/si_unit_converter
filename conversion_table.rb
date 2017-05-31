class ConversionTable
  DATA = [
    # TIME
    { 
      name: "minute",
      symbol: "min",
      type: "time",
      factor: 60,
      conversion_unit: "s"
    },
    { 
      name: "hour",
      symbol: "h",
      type: "time",
      factor: 3600,
      conversion_unit: "s"
    },
    { 
      name: "day",
      symbol: "d",
      type: "time",
      factor: 86400,
      conversion_unit: "s"
    },
    # PLANE ANGLE
    { 
      name: "degree",
      symbol: "°",
      type: "plane angle",
      factor: (Math::PI / 180),
      conversion_unit: "rad"
    },
    { 
      name: "",
      symbol: "'",
      type: "plane angle",
      factor: (Math::PI / 10800),
      conversion_unit: "rad"
    },
    { 
      name: "second",
      symbol: "\"\"",
      type: "plane angle",
      factor: (Math::PI / 648000),
      conversion_unit: "rad"
    },
    # AREA
    { 
      name: "hectare",
      symbol: "ha",
      type: "area",
      factor: 10000,
      conversion_unit: "m^2"
    },
    # VOLUME
    { 
      name: "litre",
      symbol: "L",
      type: "volume",
      factor: 0.001,
      conversion_unit: "m^3"
    },
    # MASS
    { 
      name: "tonne",
      symbol: "t",
      type: "mass",
      factor: 1000,
      conversion_unit: "kg"
    },          
  ]
end
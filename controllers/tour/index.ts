import Tour from "../../models/tour.ts";

const getTours = () => {
  const tours: Tour[] = [
    {
      title: "Tour 1",
      body: "Body 1",
      price: 25,
    },
    {
      title: "Tour 2",
      body: "Body 2",
      price: 12,
    },
  ];
};

export default getTours;

const cssnanoPlugin = require("cssnano")({
  preset: [
    "default",
    {
      discardComments: {
        removeAll: true,
      },
    },
  ],
});

module.exports = {
  plugins: [
    require("tailwindcss")("./config/tailwind.config.js"),
    require("autoprefixer"),
    ...(process.env.HUGO_ENVIRONMENT === "production" ? [cssnanoPlugin] : []),
  ],
};

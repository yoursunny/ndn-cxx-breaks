const path = require("node:path");

/** @return {import("webpack").Configuration} */
module.exports = (env, argv) => ({
  mode: argv.mode ?? "production",
  devtool: argv.mode === "development" ? "cheap-module-source-map" : "source-map",
  entry: "./src/main.jsx",
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            cacheDirectory: true,
            cacheCompression: false,
            plugins: [
              [
                "@babel/plugin-transform-react-jsx",
                {
                  pragma: "h",
                  pragmaFrag: "Fragment",
                }
              ],
            ],
          },
        },
      },
    ],
  },
  resolve: {
    extensions: [".js", ".jsx"]
  },
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "public"),
  },
  node: false,
});

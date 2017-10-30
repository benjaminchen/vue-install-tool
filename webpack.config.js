const path = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const CleanWebpackPlugin = require('clean-webpack-plugin')
const ExtractTextPlugin = require("extract-text-webpack-plugin")
const UglifyJSPlugin = require('uglifyjs-webpack-plugin2')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const webpack = require('webpack')

var isProduction = (process.env.NODE_ENV === 'production')
var isDevServer = false

process.argv.forEach(function(arg) {
  if (arg.indexOf("webpack-dev-server") !== -1) {
    isDevServer = true
  }
}.bind(isDevServer), this);

const extractSass = new ExtractTextPlugin({
  filename: isProduction ? "assets/css/bundle-[chunkhash].min.css" : "assets/css/bundle-[chunkhash].css"
})

const getPlugins = function() {
  let plugins = [
    new HtmlWebpackPlugin({
        template: 'src/pug/index.pug'
    }),
    extractSass,
    new CopyWebpackPlugin([
      {
        from: 'src/images',
        to: 'assets/images'
      }
    ]),
  ]

  ! isDevServer && plugins.push(new CleanWebpackPlugin(['dist']))
  isProduction && plugins.push(new UglifyJSPlugin())

  return plugins
}

module.exports = {
  entry: './src/index.js',
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    }
  },
  devServer: {
    contentBase: path.join(__dirname, "dist"),
    compress: true,
    port: 9000,
    open: true
  },
  plugins: getPlugins(),
  output: {
    filename: isProduction ? 'assets/js/bundle-[chunkhash].min.js' : 'assets/js/bundle-[chunkhash].js',
    path: path.resolve(__dirname, 'dist')
  },
  module: {
    rules: [
        {
          test: /\.pug$/,
          use: [
            {
              loader: "html-loader",
              options: { attrs: false }
            },
            {
              loader: "pug-html-loader",
            }
          ]
        },
        {
          test: /\.vue$/,
          use: ['vue-loader']
        },
        {
          test: /\.scss$/,
          use: extractSass.extract({
              use: [
                {
                  loader: "css-loader",
                  options: { 
                    minimize: isProduction ? true : false,
                    url: false
                  }
                }, 
                {
                  loader: "sass-loader",
                  options: { 
                    minimize: isProduction ? true : false,
                    url: false
                  }
                }
              ],
              fallback: "style-loader"
          })
        }
      ],
  }
}
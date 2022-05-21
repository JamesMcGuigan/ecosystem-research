// Source: https://github.com/vercel/next.js/discussions/19065
// opt-out of image optimization, no-op
const staticImageLoader = ({ src }) => {
    return src
}
export default staticImageLoader;
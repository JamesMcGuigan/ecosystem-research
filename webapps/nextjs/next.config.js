/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  productionBrowserSourceMaps: true,


  // DOCS: https://github.com/vercel/next.js/discussions/19065
  // warn  - Statically exporting a Next.js application via `next export` disables API routes.
  images: {
    loader: "custom",
    // disableStaticImages: true,  // base64 encode images on prerender ???
  }
}

module.exports = nextConfig

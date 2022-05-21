# Web Application Frameworks

## Svelte

```
npm init svelte svelte

✔ Which Svelte app template? › Skeleton project
✔ Add type checking? › TypeScript
✔ Add ESLint for code linting? … Yes
✔ Add Prettier for code formatting? … Yes
✔ Add Playwright for browser testing? … Yes
```

svelte.config.ts
```
// https://kit.svelte.dev/docs/adapters#supported-environments-static-sites
import adapter from '@sveltejs/adapter-static';  
const config = {
	kit: {
		adapter: adapter(),
		prerender: { default: true }
	}
};
```

Build and deploy
```
cd ./svelte/
svelte-kit build
http-server ./build/
```

## NextJs
```
npx create-next-app@latest nextjs
```
Build and deploy
```
cd ./nextjs/
next dev
next build && next start
next build && next export && http-server out/  # static site generation
```

Static Site Generation
- https://github.com/vercel/next.js/discussions/19065
- warn - Statically exporting a Next.js application via `next export` disables API routes.

next.config.js
```
images: {
    loader: "custom",
    // disableStaticImages: true,  // base64 encode images on prerender ???
}
```
index.js
```
const staticImageLoader = ({ src }) => {
    return src
};
<Image src="/vercel.svg"  alt="Vercel Logo" width={72} height={16} loader={staticImageLoader} />
<Image src="/favicon.png" alt="Vercel Logo" width={16} height={16} unoptimized />
```

## Vite Preact 
- https://vitejs.dev/guide/#scaffolding-your-first-vite-project
- https://github.com/vitejs/awesome-vite#templates

```
pnpm create vite vite-preact-ts
✔ Select a framework: › preact
✔ Select a variant: › preact-ts
```

```
cd vite-preact-ts
pnpm install
vite                                     # dev server
tsc && vite build && http-server dist/   # production
```
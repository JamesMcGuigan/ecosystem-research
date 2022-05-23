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

Issues:
- Unsure how to implement SSR Server Side Rendering without a Node Server
- https://github.com/yomete/preact-ssr/blob/master/server.js - SSR via Node

## Vite React RTK
- https://github.com/laststance/vite-rtk-query

```
npx degit laststance/vite-rtk-query vite-react-rtk
```
```
cd vite-react-rtk
yarn dev
yarn build && http-server ./dist/
```


## Vite React Electron

Electron is for building native desktop apps via embedded Chrome

- https://github.com/electron-vite/electron-vite-react
- https://github.com/maxstue/vite-reactts-electron-starter
- https://github.com/jctaoo/vite-electron-esbuild-starter

```
npm create electron-vite
✔ Project template: › React
```
```
cd electron-vite-react
vim packages/renderer/src/App.tsx
yarn 
yarn build
webapps/electron-vite-react/release/1.0.0/linux-unpacked/vite-react-electron
```


## React Native - Ignite

This project fails to build on Arch Linux
- https://blog.logrocket.com/top-react-native-boilerplates-for-2021/
- https://github.com/infinitered/ignite

```
npx ignite-cli new IgniteReactNative
```

## React Native Starter Kit
Builds, but unsure how to simulate locally on Arch Linux
- https://github.com/mcnamee/react-native-starter-kit
```
npx degit https://github.com/mcnamee/react-native-starter-kit react-native-starter-kit
```
```
# brew install --cask cocoapods
gem install cocoapods -V  # PATH+=~/.local/share/gem/ruby/*/bin
sudo pacman -S react-native-debugger
sudo pacman -S android-studio
```
```
yarn install && ( cd ios && pod install )
android-studio
npx react-native run-ios --simulator="iPhone 11"  # requires xcode
npx react-native run-android
```
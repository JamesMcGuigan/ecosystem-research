# Webapps

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
// Source: https://compile.fi/canvas-filled-three-ways-js-webassembly-and-webgl/

const canvas = document.getElementById('canvas-wasm-full');
window.resizeCanvas(canvas);

// Contains the actual webassembly
const base64data = 'AGFzbQEAAAABFgRgAn9/AX9gAn9/AXxgAXwAYAF8AXwCEgEDZW52Bm1lbW9yeQIBgAKAAgMFBAMCAQAHEwIFX2luaXQAAwdfcmVuZGVyAAEKowUEKQAgAEQAAAAAAADgP6CcIABEAAAAAAAA4D+hmyAARAAAAAAAAAAAZhsLogMCDH8DfEGMrOgDKAIAIgZBAEoEQEGQrOgDKAIAIQdBiKzoAygCACIEQQBKIQhBlKzoAygCACEJIABEAAAAAAAAJECjRAAAAAAAQJ9AoJyqtyEOQYCs6AMrAwAhDwNAIAcgA2siBSAFbCEKIAQgA2whCyAIBEBBACEBA0AgCSABayICIAJsIApqtyIAnyENRAAAAAAAAPA/IAIgBRACRBgtRFT7IRlAo0QAAAAAAMByQKIgAEQAAAAAAAB5QKMgDaAgDqGgmSIAIABEAAAAAAAAWUCjnEQAAAAAAABZQKKhRAAAAAAAAFlAo6EiAEQAAAAAAABJQKJEAAAAAAAA8D8gDSAPo6EiDaIQAKohAiAARAAAAAAAAPA/oCAARAAAAAAAAG5AoiANRJqZmZmZmek/okSamZmZmZnJP6CiokQAAAAAAADgP6IQAKohDCABIAtqQQJ0QYAIaiAAIAAgAEQAAAAAAABeQKKioiANohAAqkEIdCACQRB0ciAMckGAgIB4cjYCACABQQFqIgEgBEcNAAsLIANBAWoiAyAGSA0ACwsLhQEBA3wgAEEAIABrIABBf0obt0S7vdfZ33zbPaAhAiABtyEDIAFBf0oEfEQYLURU+yHpPyEEIAMgAqEgAiADoKMFRNIhM3982QJAIQQgAiADoCACIAOhowsiAiACIAJE4zYawFsgyT+ioqIgAkRgdk8eFmrvP6KhIASgIgKaIAIgAEEASBsLTABBiKzoAyAANgIAQYys6AMgATYCAEGQrOgDIAFBAXUiATYCAEGUrOgDIABBAXUiADYCAEGArOgDIAEgAWwgACAAbGq3nzkDAEGACAs=';
const decode = (b64) => {
    const str = window.atob(b64);
    const array = new Uint8Array(str.length);
    for (let i = 0; i < str.length; i += 1) {
        array[i] = str.charCodeAt(i);
    }
    return array.buffer;
};
const memSize = 256;
const memory = new WebAssembly.Memory({ initial: memSize, maximum: memSize });

const instance = new WebAssembly.Instance(
    new WebAssembly.Module(new Uint8Array(decode(base64data))),
    { env: { memory } }
);
const height = canvas.height;
const width = canvas.width;
// Disabling alpha seems to give a slight boost. Image data still includes alpha though.
const ctx = canvas.getContext(
    '2d',
    {
        alpha: false,
        antialias: false,
        depth: false
    }
);
if (!ctx) {
    throw 'Your browser does not support canvas';
}

const pointer = instance.exports._init(width, height);
const data = new Uint8ClampedArray(memory.buffer, pointer, width * height * 4);
const img = new ImageData(data, width, height);

const render = (timestamp) => {
    instance.exports._render(timestamp);
    ctx.putImageData(img, 0, 0);
    window.requestAnimationFrame(render);
};
window.requestAnimationFrame(render);


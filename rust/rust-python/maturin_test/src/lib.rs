use pyo3::prelude::*;
use pyo3::wrap_pyfunction;

#[pyfunction]
fn double(x: usize) -> usize {
    x * 2
}

#[pyfunction]
fn double_f64(x: f64) -> f64 {
    x * 2.0
}


#[pymodule]
#[pyo3(name = "maturin_test")]
fn module_with_functions(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_wrapped(wrap_pyfunction!(double))?;
    m.add_wrapped(wrap_pyfunction!(double_f64))?;
    Ok(())
}
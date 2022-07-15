use spfunc::zeta::zeta;
use cauchy::Scalar;

// Riemann Hypothesis
// Find zeta(s) = 0 where not s != -2n || 0.5+ni
// https://en.wikipedia.org/wiki/Riemann_hypothesis
fn main() {
    for s in [
        f64::complex(1.0, 0.0),
        f64::complex(0.0, 0.0),
        f64::complex(-2., 0.),
        f64::complex(-4., 0.),
        f64::complex(-6., 0.),
        f64::complex(-8., 0.),
        f64::complex(0.5, 1.),
    ] {
        let value = zeta(s);
        println!( "zeta({}) = {}", s, value )
    }
}


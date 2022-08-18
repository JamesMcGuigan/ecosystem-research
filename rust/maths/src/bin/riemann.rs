use spfunc::zeta::zeta;
use cauchy::Scalar;

// Riemann Hypothesis
// Find zeta(s) = 0 where not s != -2n || 0.5+ni
// https://en.wikipedia.org/wiki/Riemann_hypothesis
//
// zeta(  1 + 0i) = inf  +  0i
// zeta(  0 + 0i) = -0.5 + -0i
// zeta( -2 + 0i) = -0.0000000000000000793016446160826 + -0i
// zeta( -4 + 0i) = -0.000000000000022519620576912853  + -0i
// zeta( -6 + 0i) = NaN + NaNi
// zeta( -8 + 0i) = NaN + NaNi
// zeta( .5 + 1i) = 0.1439364270771886 - 0.7220997435316734i

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

use std::cmp;

#[derive(Copy, Clone)]  // Unsure how this works - https://doc.rust-lang.org/std/marker/trait.Copy.html
struct Color {
    red:   u8,
    blue:  u8,
    green: u8,
}
impl Color {
    fn copy(&self) -> Color {
        return Color {
            red:   self.red,
            blue:  self.blue,
            green: self.green,
        }
    }
    fn grayscale(value: u8) -> Color {
        return Color { red: value, green: value, blue: value };
    }
    fn brightness(&self) -> u8 {
        return ((self.red as u16 + self.green as u16 + self.blue as u16) / 3) as u8;
    }
    fn set_brightness(&mut self, value: u8) {
        let brightness = self.brightness();
        let rescale = |x: u8| {
            let scale = value as f64 / brightness as f64;
            cmp::min(cmp::max(0, (x as f64 * scale) as u8), 255)
        };
        self.red   = rescale(self.red);
        self.blue  = rescale(self.blue);
        self.green = rescale(self.green);

        // 255+ Overflow may cause brightness to be incorrect, so loop until convergence
        // println!("self.brightness() = {}", self.brightness());
        if ( (self.brightness() as i16) - (value as i16) ).abs() > 2 {
            self.set_brightness(value)
        }
    }
}


struct TupleColor(u8, u8, u8);

pub fn run() {
    let color = Color { red: 16, green: 64, blue: 42 };
    println!("color       = ({}, {}, {}) | brightness = {}", color.red, color.green, color.blue, color.brightness());

    // doesn't cause an infinite loop
    for brightness in 0..=255 {
        let mut clone = color.copy();
        clone.set_brightness(brightness);
        if ( (clone.brightness() as i16) - (brightness as i16) ).abs() > 1 {
            println!("clone.set_brightness({}) = ({}, {}, {}) | brightness = {}", brightness, clone.red, clone.green, clone.blue, clone.brightness());
        }
    }

    let tuple_color = TupleColor(2,55,0);
    println!("tuple_color = ({}, {}, {}))", tuple_color.0, tuple_color.1, tuple_color.2);

    //// Unsure how to loop over Struct or Tuple
    // print!("tuple_color = ("); for value in tuple_color.iter() { print!("{}, ", value); }; print!("\n");

    let gray = Color::grayscale(255/2);
    println!("gray        = ({}, {}, {}) | brightness = {}", gray.red, gray.green, gray.blue, gray.brightness());

}
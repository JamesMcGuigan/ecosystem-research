// use yew::prelude::{Properties, Component, Context, Html, html};
use yew::prelude::*;
use gloo_console::log;
use stdweb::web::Date;

#[derive(PartialEq, Properties)]
pub struct Counter {
    value: i64
}

pub enum Msg {
    Increment,
    Decrement,
    Bulk(Vec<Msg>),
}

impl Component for Counter
{
    type Message = Msg;
    type Properties = ();

    fn create(_ctx: &Context<Self> ) -> Self {
        Counter { value: 0 }
    }

    fn update(&mut self, _ctx: &Context<Self>, msg: Self::Message) -> bool {
        match msg {
            Msg::Increment => {
                self.value += 1;
                log!("plus one");
            }
            Msg::Decrement => {
                self.value -= 1;
                log!("minus one");
            }
            Msg::Bulk(list) => for msg in list {
                self.update(_ctx, msg);
                log!("Bulk Action");
            }
        };
        true
    }

    // BUG: expected `()`, found enum `Msg`
    fn view(&self, _ctx: &Context<Self>) -> Html {
        // let link = ctx.link();
        // <button onclick={link.callback(|_| Msg::Increment)}>{ "Increment" }</button>
        html! {
            <div>
                <nav class="menu">
                    <button onclick={|_| Msg::Increment}>{ "Increment" }</button>
                    <button onclick={|_| Msg::Decrement}>{ "Decrement" }</button>
                    <button onclick={|_| Msg::Bulk(vec![Msg::Increment, Msg::Increment])}>
                        { "Increment Twice" }
                    </button>
                </nav>
                <p>{ self.value }</p>
                <p>{ Date::new().to_string() }</p>
            </div>
        }
    }
}

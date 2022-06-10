// Source: https://yew.rs/docs/getting-started/build-a-sample-app
use yew::prelude::*;
use gloo_console::log;

#[derive(PartialEq, Properties)]
pub struct Counter {
    value: i64,
}

pub enum Msg {
    Increment,
    Decrement,
    Bulk(Vec<Msg>),
}

impl Component for Counter {
    type Message = Msg;
    type Properties = ();

    fn create(_ctx: &Context<Self>) -> Self {
        Self {
            value: 0,
        }
    }

    fn update(&mut self, ctx: &Context<Self>, msg: Self::Message) -> bool {
        match msg {
            Msg::Increment => {
                log!("Increment");
                self.value += 1;
            }
            Msg::Decrement => {
                log!("Decrement");
                self.value -= 1;
            }
            Msg::Bulk(list) => for msg in list {
                log!("Bulk Action");
                <Self as Component>::update(self, ctx, msg);
            }
        }
        true  // true = rerender
    }

    fn view(&self, ctx: &Context<Self>) -> Html {
        // This gives us a component's "`Scope`" which allows us to send messages, etc to the component.
        let link = ctx.link();
        html! {
            <div class="counter">
                <h2>{ "Counter" }</h2>
                <nav class="menu">
                    <button onclick={link.callback(|_| Msg::Bulk(vec![Msg::Increment, Msg::Increment, Msg::Increment]))}>{ "+3" }</button>
                    <button onclick={link.callback(|_| Msg::Increment)}>{ "+1" }</button>
                    <button onclick={link.callback(|_| Msg::Decrement)}>{ "-1" }</button>
                    <button onclick={link.callback(|_| Msg::Bulk(vec![Msg::Decrement, Msg::Decrement, Msg::Decrement]))}>{ "-3" }</button>
                </nav>
                <p>{ self.value }</p>
            </div>
        }
    }
}

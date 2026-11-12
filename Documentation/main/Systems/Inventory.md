# Inventory

## Style

- Weight/grid hybrid — STALKER-style, not pure Tetris (12 batteries don't eat your whole pack)
- Free-grid layout (like an unlocked Windows desktop) — items can be placed freely, no overlap, with auto-stack and auto-sort
- Weight is the primary constraint, grid is spatial organization
- Volume must also be part of the design.
- Weight + Volume are density. Items can be rejected for volume, but not weight. 
    - Volume/fullness can be represented as a bar at the top of the inventory
    - There could be a very funny mechanic where you can rip a bag apart if you pick it up and there's too much weight in it, but I don't think we're going to do that. Instead, the limitation will be you as your character carrying a certain amount of weight. You might successfully pick it up, or we even just simply have a limitation to say this item is too heavy for me. Because what this does is it enables us to have strength and agility and other personal mechanics as part of the process. This is similar to how at least one other game does it, and I like that mechanic. It also lends itself to exploring other types of personal attributes on characters.

## Player Interaction

- Pick up items into inventory
- Drop, share, trade with other players
- Access dead player inventories
- See [[Interactions]]

## Design Thoughts

When an item is inside an inventory, it only exists as data until it is dropped. Once it's dropped, it exists as data and a game object. The game object references the instance of the item it's representing.

When I pick up a prop, the prop goes away and something representing it gets stored.

I think in this context, items are explicitly things that exist in the real world. So they should have *some* type of physical representation.

Currency can exist as a physical item. There might be a scenario in the future where, like, you might have a digital bank, for example, and you can convert an item of physical currency into a digital currency. But that digital currency also might just have its own data structure, that might be related to or have ownership from a player.

The backpack is an item that happens to hold things, and it also happens to be an item that can be wearable.

A player might have their own personal inventory (undecided, It depends upon whether characters can be naked or not, Which would be funny because we could have them in their underwear and technically they could store things in their underwear if they really wanted to, But I don't know), but the inventory belongs to the backpack, which is an item in this case. So an item can have an inventory, and an inventory holds items. For example, a backpack can hold a backpack.


>  I usually do an MVC pattern, and when a Model (data) is updated, it fires an event that a Controller (business logic) subscribes to, which in turn will call an update on a View (presentation layer). The View handles all the animations and stuff, which I'm trying to make sure doesn't change the state of the game at all. If multiple animations need to wait on eachother, I usually queue them either in a View if no state change is involved, or in the Controller when there needs to be true sequencing of game logic.
> 
> So essentially, the card (Model) does it's effect, a Controller queues an animation in the View, and the View executes it and ways until it finished to continue to the next animation it needs to show. I tend to not care that animations are finished or not, but if you do, you could have the View also fire an event and the Controller handle game states based on it. 
> 
> [https://www.reddit.com/r/gamedev/s/bmTLyJhyMx](https://www.reddit.com/r/gamedev/s/bmTLyJhyMx)

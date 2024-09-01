const std = @import("std");
const rl = @import("raylib");
const event = @import("sage").event.event;

const c = @cImport({
    @cInclude("SDL2/SDL.h");
});

pub const window = struct {
    title: []const u8,

    width: u32,
    height: u32,

    set_event_callback: ?fn (callback: fn (e: *const event) void) void,

    pub fn init() !void {
        defer c.SDL_Quit();
        const screen = c.SDL_CreateWindow("Sage Engine", c.SDL_WINDOWPOS_UNDEFINED, c.SDL_WINDOWPOS_UNDEFINED, 400, 140, c.SDL_WINDOW_OPENGL).?;
        defer c.SDL_DestroyWindow(screen);
        const renderer = c.SDL_CreateRenderer(screen, -1, 0).?;
        defer c.SDL_DestroyRenderer(renderer);

        var quit = false;

        while (!quit) {
            var e: c.SDL_Event = undefined;
            while (c.SDL_PollEvent(&e) != 0) {
                switch (e.type) {
                    c.SDL_QUIT => {
                        quit = true;
                    },
                    else => {},
                }
            }
            _ = c.SDL_RenderClear(renderer);
            c.SDL_RenderPresent(renderer);

            c.SDL_RenderPresent(renderer);

            c.SDL_Delay(17);
        }
    }
};

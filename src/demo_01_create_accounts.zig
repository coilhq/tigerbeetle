const std = @import("std");

usingnamespace @import("tigerbeetle.zig");
usingnamespace @import("demo.zig");

pub fn main() !void {
    const fd = try connect(config.port);
    defer std.os.close(fd);

    var accounts = [_]Account{
        Account{
            .id = 1,
            .user_data = 0,
            .reserved = [_]u8{0} ** 48,
            .unit = 710, // Let's use the ISO-4217 Code Number for ZAR
            .code = 1000, // A chart of accounts code to describe this as a clearing account.
            .flags = .{ .debits_must_not_exceed_credits = true },
            .debits_reserved = 0,
            .debits_accepted = 0,
            .credits_reserved = 0,
            .credits_accepted = 10000, // Let's start with some liquidity.
        },
        Account{
            .id = 2,
            .user_data = 0,
            .reserved = [_]u8{0} ** 48,
            .unit = 710, // Let's use the ISO-4217 Code Number for ZAR
            .code = 2000, // A chart of accounts code to describe this as a payable account.
            .flags = .{},
            .debits_reserved = 0,
            .debits_accepted = 0,
            .credits_reserved = 0,
            .credits_accepted = 0,
        },
    };

    try send(fd, .create_accounts, accounts, CreateAccountsResult);
}

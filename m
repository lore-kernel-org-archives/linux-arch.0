Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35402 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbdDCPbb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2017 11:31:31 -0400
MIME-Version: 1.0
In-Reply-To: <20170403081328.30266-1-npiggin@gmail.com>
References: <20170403081328.30266-1-npiggin@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Apr 2017 08:31:30 -0700
Message-ID: <CA+55aFx92vOh28CWp5zid8RzbM=5pO0Or51zS4D8M97L=69hHA@mail.gmail.com>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>
Message-ID: <20170403153130.3LqdtomRhbNKAZ6XY9ydnGbFw5vzj_bL3Cml4qguilA@z>

On Mon, Apr 3, 2017 at 1:13 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The loops have some restrictions on what can be used, but they are
> intended to be small and simple so it's not generally a problem:
>  - Don't use cpu_relax.
>  - Don't use return or goto.
>  - Don't use sleeping or spinning primitives.

So you're supposed to "break" out of the loop if you want to exit
early? Or what?

One of the issues is that with a do-while/until loop, at least the way
you've coded it, it's always done at least once.

Which means that people will have to code the condition as

    if (cond) {
        .. fast case..
        return;
    }

    spin_do {
       ...
    } spin_until (cond);
    .. slow case ..

because "cpu_relax()" itself can be slightly slow.

And the way you've done it, even if there's a "break" in the loop, the
cpu_relax() is still done (because it's done at the top).

So quite frankly, I think "while(cond) ()" semantics would be better
than "do { } while (cond)".

Now, a lot of loops *are* of the kind where we've already handled the
fast case earlier, so by the time we get into the loop we really are
waiting for the condition to become true (but we knew it started out
false). But not all.

Doing a quick

    git grep -2 cpu_relax

for existing users of cpu_relax() does imply that most of the current
users are very much of the "cpu_relax() at the _end_ of the loop
tests" type.

So I don't know. I think the interface sucks.

What is it that POWER _actually_ wants? Not the loop - the
"cpu_relax()" kind of thing. Can we abstract *that* better?

                    Linus
